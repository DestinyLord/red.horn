<?php
class Admin_action_model extends Core_model
{
    /**
     * @var string
     */
    protected $_tableName = 'backend_admin_action';

    /**
     * Admin_action_model constructor.
     */
	function __construct()
	{
		parent::__construct();
	}

    /**
     * 根据条件获取单个权限数据
     *
     * @param $params
     * @param string $keyWord
     * @return array
     */
    public function getActionItem($params, $keyWord = '')
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
     * 根据条件获取多个权限数据
     *
     * @param array $params
     * @return array
     */
    public function getActionItems($params = [])
    {
        $params['join']     = [
            'table' => "{$this->_tableName} AS b",
            'cond'  => 'a.relevance_code = b.action_code',
            'type'  => 'left'
        ];
        $params['order_by'] = 'a.action_id ASC';
        $data               = $this->getItems(
            "{$this->_tableName} AS a",
            'a.*, b.action_title AS relevance_title',
            $params
        );

        $result = [];
        $pid    = isset($params['parent_id']) ? intval($params['parent_id']) : 0;

        getTreeData($data, $pid, $result, 'action_id');

        return $result;
    }

    /**
     * 权限新增操作
     *
     * @param $parentId
     * @param $actionTitle
     * @param $insertData
     * @return bool
     */
    function insertAction($parentId, $actionTitle, $insertData)
	{
        $isExist = $this->getTotals(
            $this->_tableName, ['where' => ['action_title' => $actionTitle]]
        );

        if ($isExist > 0)
        {
            echoMsg(10019);
        }

	    $insertId = $this->insert($this->_tableName, $insertData);

		if(!empty($insertId))
		{
			if($parentId)
			{
			    $parentData = $this->getActionItem(['where' => ['action_id' => $parentId]]);

				if(!empty($parentData))
				{
					$level = (int)$parentData['level'] + 1;
					$queue = $parentData['queue'] . $insertId . ",";

                    // 若原父菜单无子菜单，则更新父菜单
                    if (empty($parentData['has_child']))
                    {
                        $this->update(
                            $this->_tableName, ['has_child' => 1], ['action_id' => $parentId]
                        );
                    }
				}
                else
                {
                    echoMsg(10020);
                    return FALSE;
                }
			}
			else
			{
				$level = 0;
				$queue = "," . $insertId . ",";
			}

            $updateData = ['queue' => $queue, 'level' => $level];
			$this->update($this->_tableName, $updateData, ['action_id' => $insertId]);

            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '添加权限：'.$actionTitle
            );

			return TRUE;	
		}
		else
		{
			return FALSE;
		}
	}

    /**
     * 权限修改操作
     *
     * @param $id
     * @param $actionTitle
     * @param $parentId
     * @param $oldParentId
     * @param $updateData
     * @return bool
     */
    function updateAction($id, $actionTitle, $parentId, $oldParentId, $updateData)
	{
        // 判断权限名称是否已经存在
        $isExist = $this->getTotals(
            $this->_tableName,
            [
                'where' => [
                    'action_title' => $actionTitle,
                    'action_id !=' => $id
                ]
            ]
        );

        if ($isExist > 0)
        {
            echoMsg(10019);
        }

        //如果更改了父ID, 就更新父ID的记录和自己的记录
		if($parentId != $oldParentId)
		{
            $row = $this->getActionItem(['where' => ['action_id' => $parentId]]);

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
            $res = $this->update($this->_tableName, $updateData, ['action_id' => $id]);
            
			if(!empty($oldParentId))
			{
                // 检查原来的父ID里面是否还有子菜单
                $oldHasChild = $this->getTotals(
                    $this->_tableName, ['where' => ['parent_id' => $oldParentId]]
                );

                // 由于原父数据的has_child=1，所以不存在才修改
                if (empty($oldHasChild))
                {
                    $this->update(
                        $this->_tableName, ['has_child' => 0], ['action_id'=>$oldParentId]
                    );
                }
			}

            // 这条记录的父ID若不存在子数据，则修改
			if(!empty($row) && empty($row['has_child']))
			{
                $this->update(
                    $this->_tableName, ['has_child' => 1], ['action_id'=>$parentId]
                );
			}

            $hasChild = $this->input->post("has_child");

			if(!empty($hasChild))
			{
				$this->updateQD($id, $queue, $level);
			}
		}
		else
        {
            $res = $this->update($this->_tableName, $updateData, ['action_id' => $id]);
        }

        if($res > 0)
        {
            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '修改权限：'.$actionTitle
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
     *
     * @param $pid
     * @param $queue
     * @param $level
     */
    function updateQD($pid, $queue, $level)
	{
	    $data = $this->getActionItems(['where' => ['parent_id' => $pid]]);

        if(!empty($data))
        {
            foreach ($data as $item)
            {
                $updateData = [
                    'level' => $level + 1,
                    'queue' => $queue . $item['action_id'] . ","
                ];
                $this->update($this->_tableName, $updateData, ['action_id' => $item['action_id']]);

                if ($item['has_child'])
                {
                    $this->updateQD(
                        $item['action_id'], $updateData['queue'], $updateData['level']
                    );
                }
            }
        }
	}
    
    
    /**
     * 删除记录
     * @author  alan    2014.7.22
     */
    function deleteRecord()
    {
        $ids = intval($this->input->get('id'));
        
        if(is_array($ids))
        {
            $this->db->where_in('action_id',$ids);
        }else
        {
            $this->db->where('action_id',$ids);
        }
        $this->db->delete('admin_action');
        if($this->db->affected_rows() > 0)
        {
            return TRUE;
        }else
        {
            return FALSE;
        }
    }
    
    /**
     *  设置权限
     *  @author     alan    2014.3.30
     *  @param      string  $type 设置的类型，分为用户和角色 
     *  @return     boolean     
     */ 
    function setAction($type, $id, $data)
    {
        $affRow = 0;
        if(is_array($data) && !empty($data))
        {
            $actionStr = implode(',',$data);
        }else
        {
            $actionStr = '';
        }        
        if($type == 'admin_user')
        {
            $this->db->update('admin', array('action_list'=>$actionStr), array('id'=>$id));
            $affRow = $this->db->affected_rows();
        }else
        {
            $this->db->update('admin_role', array('action_list'=>$actionStr), array('id'=>$id));
            $affRow = $this->db->affected_rows();            
        }
        
        if($affRow > 0)
        {
            if($type == 'admin_user')
            {
                $data = $this->db->get_where('admin', array('id' => $id))->row_array();

                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '分派权限：'.$data['username']
                );
            }else
            {
                $data = $this->db->get_where('admin_role', array('id' => $id))->row_array();

                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '分派权限：'.$data['role_name']
                );
            }
            return TRUE;
        }else
        {
            return FALSE;
        }
    } 

}