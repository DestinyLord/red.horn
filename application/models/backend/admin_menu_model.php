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
     * 根据条件获取多个菜单数据
     *
     * @param array $params
     * @return array
     */
	public function getMenuItems($params = [])
    {
        $params['order_by'] = 'seqorder ASC';

        $result = $this->getItems(
            $this->_tableName, '*', $params
        );

        return $result;
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
     * 新增菜单操作
     *
     * @return bool
     */
    function insertMenu()
	{
	   $parent_id = $this->input->post('parent_id');
       $menuTitle = $this->input->post('menu_title');
	   $options = array(
                'parent_id'     => $parent_id,
                'menu_title'    => $menuTitle,
                'icon_class'    => $this->input->post('icon_class'),
                'menu_url'      => $this->input->post('menu_url'),
                'action_code'   => $this->input->post('action_code'),
                'seqorder'      => $this->input->post('seqorder'),
                'has_child'     => 0,
        );
		$this->db->insert("admin_menu",$options);
        
		if($this->db->affected_rows())
		{
			$max_id = $this->db->insert_id();
			if($parent_id)
			{
				$query=$this->db->get_where("admin_menu",array('id'=>$parent_id));
				if($query->num_rows()>0)
				{
					$row=$query->row_array();
					$level=(int)$row['level']+1;
					$queue=$row['queue'].$max_id.",";
				}
			}
			else
			{
				$level=0;
				$queue=",".$max_id.",";
			}
			$data=array(
				'queue'=>$queue,
				'level'=>$level
			);
			$this->db->update("admin_menu",$data,array('id'=>$max_id));
            
			if($parent_id)
			{
				$data=array('has_child'=>1);
				$this->db->update("admin_menu",$data,array('id'=>$parent_id));
			}
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
        //如果更改了父ID ,就更新父ID的记录和自己的记录
		if($parentId != $oldParentId)
		{
            $row   = $this->getMenuItem(['where' => ['id' => $parentId]]);

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
            $this->db->update("admin_menu",$updateData,array('id'=>$id));
            
            $res = $this->db->affected_rows();//是否修改成功标识
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