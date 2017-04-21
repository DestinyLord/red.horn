<?php
class Admin_menu_model extends Core_model
{

    /**
     * @var string
     */
    protected $_tableName = 'backend_admin_menu';

    /**
     * Admin_menu_model constructor.
     */
	function __construct()
	{
		parent::__construct();
	}

    /**
     * 根据条件获取某个菜单数据
     *
     * @param $params
     * @param string $keyWord
     * @return array
     */
    public function getMenuItem($params, $keyWord = '')
    {
        $result = $this->getItem($this->_tableName, $params);

        if (!empty($result) && !empty($keyWord) && isset($result[$keyWord]))
        {
            return $result[$keyWord];
        }
        else
        {
            return $result;
        }
    }

    /**
     * 根据条件获取多个菜单数据
     *
     * @param array $params
     * @return array
     */
	public function getMenuItems($params = [])
    {
        $params['order_by'] = 'seqorder ASC';

        $data   = $this->getItems(
            $this->_tableName, '*', $params
        );
        $result = [];

        getTreeData($data, 0, $result);

        return $result;
    }

    /**
     * 新增菜单操作
     *
     * @param $parentId
     * @param $menuTitle
     * @param $insertData
     * @return bool
     */
    function insertMenu($parentId, $menuTitle, $insertData)
	{
	    $isExist = $this->getTotals(
	        $this->_tableName, ['where' => ['menu_title' => $menuTitle]]
        );

	    if ($isExist > 0)
        {
            echoMsg(10015);
        }

        $insertId = $this->insert($this->_tableName, $insertData);

		if (!empty($insertId))
		{
			if ($parentId)
			{
			    $parentData = $this->getMenuItem(
			        ['where' => ['id' => $parentId]]
                );

				if(!empty($parentData))
				{
					$level = (int)$parentData['level'] + 1;
					$queue = $parentData['queue'] . $insertId . ",";

					// 若原父菜单无子菜单，则更新父菜单
					if (empty($parentData['has_child']))
                    {
                        $this->update(
                            $this->_tableName, ['has_child' => 1], ['id' => $parentId]
                        );
                    }
				}
				else
                {
                    echoMsg(10016);
                    return FALSE;
                }
			}
			else
			{
				$level = 0;
				$queue = "," . $insertId . ",";
			}

			$updateData = [
				'queue' => $queue, 'level' => $level
			];
			$this->update($this->_tableName, $updateData, ['id' => $insertId]);

            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '添加菜单：'.$menuTitle
            );

			return TRUE;
		}
		else
		{
			return FALSE;
		}
	}

    /**
     * 修改菜单操作
     *
     * @param $id
     * @param $menuTitle
     * @param $parentId
     * @param $oldParentId
     * @param $updateData
     * @return bool
     */
    function updateMenu($id, $menuTitle, $parentId, $oldParentId, $updateData)
	{
	    // 判断菜单名称是否已经存在
        $isExist = $this->getTotals(
            $this->_tableName,
            [
                'where' => [
                    'menu_title' => $menuTitle,
                    'id !='      => $id
                ]
            ]
        );

        if ($isExist > 0)
        {
            echoMsg(10015);
        }

        //如果更改了父ID, 就更新父ID的记录和自己的记录
		if($parentId != $oldParentId)
		{
            $row = $this->getMenuItem(['where' => ['id' => $parentId]]);

			if(!empty($row))
			{
				$level = (int)$row['level'] + 1;
				$queue = $row['queue'] . $id . ",";
			}
			else
			{
				$level = 0;
				$queue = "," . $id . ",";
			}
            
			$updateData['queue'] = $queue;
            $updateData['level'] = $level;

            $res = $this->update($this->_tableName, $updateData, ['id' => $id]);
            
			if(!empty($oldParentId))
			{
                //检查原来的父ID里面是否还有子菜单
                $oldHasChild = $this->getTotals(
                    $this->_tableName, ['where' => ['parent_id' => $oldParentId]]
                );

				if($oldHasChild > 0)
				{
				    $this->update(
				        $this->_tableName, ['has_child' => 1], ['id'=>$oldParentId]
                    );
				}
				else
				{
                    $this->update(
                        $this->_tableName, ['has_child' => 0], ['id'=>$oldParentId]
                    );
				}
			}

			if(!empty($parentId))//这条记录的父ID肯定是存在子元素
			{
                $this->update(
                    $this->_tableName, ['has_child' => 1], ['id'=>$parentId]
                );
			}

			$hasChild = $this->input->post("has_child");

			if($hasChild)
			{
				$this->updateQD($id, $queue, $level);
			}
		}
		else
        {
            $res = $this->update($this->_tableName, $updateData, ['id' => $id]);
        }
        
        if($res > 0)
        {
            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '修改菜单：'.$menuTitle
            );

            return TRUE;
        }
        else
        {
            return FALSE;
        }
		
	}
    
    /**
     * 递归更改子菜单的级别和目录树
     * @param   $pid    INT     父ID
     * @param   $queue  String  目录树
     * @param   $level  INT     目录级别     
     */ 
    function updateQD($pid, $queue, $level)
	{
		$data = $this->getMenuItems(['where' => ['parent_id' => $pid]]);

		if (!empty($data))
        {
            foreach ($data as $item)
            {
                $updateData = [
                    'level' => $level + 1,
                    'queue' => $queue . $item['id'] . ","
                ];
                $this->update($this->_tableName, $updateData, ['id' => $item['id']]);

                if ($item['has_child'])
                {
                    $this->updateQD(
                        $item['id'], $updateData['queue'], $updateData['deep_id']
                    );
                }
            }
        }
	}


    /**
     * 删除菜单操作
     *
     * @param $id
     * @return bool
     */
    function deleteMenu($id)
    {
        $data   = $this->getMenuItem(['where' => ['id' => $id]]);
        $result = FALSE;

        if (!empty($data))
        {
            $result = $this->delete($this->_tableName, ['id' => $id]);

            if (!empty($result))
            {
                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '删除菜单：'.$data['menu_title']
                );
            }
        }

        return $result;
    } 

}