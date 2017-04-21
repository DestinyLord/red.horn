<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Admin_role_model extends Core_model
{
    /**
     * @var string
     */
    public $_tableName = 'backend_admin_role';

    /**
     * Admin_role_model constructor.
     */
	function __construct()
	{
		parent::__construct();
	}

    /**
     * 根据条件获取某个权限数据
     *
     * @param array $params
     * @param string $keyWord
     * @return array
     */
    public function getRoleItem($params =[], $keyWord = '')
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
     * 根据条件获取多个权限数据，除了超级管理员
     *
     * @param array $params
     * @return array
     */
    public function getRoleItems($params =[])
    {
        $params['order_by'] = 'id ASC';
        // 超级管理员不允许显示
        $params['where']['id !='] = 1;

        $result = $this->getItems(
            $this->_tableName, '*', $params
        );

        return $result;
    }
    
    /**
     * 插入记录
     * @author  alan    2014.7.21
     * @return  INT OR Boolean   插入的新ID 或 FALSE
     */ 
    function insertRecord()
	{
	   $roleName = $this->input->post('role_name');
	   $options = array(
                'role_name'    => $roleName,
                'role_code'    => $this->input->post('role_code'),
                'role_describe'      => $this->input->post('role_describe'),
        );
		$this->db->insert("admin_role",$options);
        
		if($this->db->affected_rows())
		{
            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '添加角色：'.$roleName
            );
			return TRUE;
		}
		else
		{
			return FALSE;
		}
	}
    
    /**
     * 更改记录
     * @author  alan    2014.7.22
     * @return  Boolean   TRUE 或 FALSE
     */
    function updateRecord()
	{
		$id=$this->input->post("id");

        if($id == 1 && !checkIsAdmin())
        {
            echoMsg(10008);
        }

        $roleName = $this->input->post('role_name');
        $options = array(
                'role_name'    => $roleName,
                'role_code'    => $this->input->post('role_code'),
                'role_describe'      => $this->input->post('role_describe'),
        );
        
        
        $this->db->update("admin_role",$options,array('id'=>$id));
        
        $res = $this->db->affected_rows();// 是否修改成功标识
        
  
        if($res > 0)
        {
            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '修改角色：'.$roleName
            );
            return TRUE;
        }else
        {
            return FALSE;
        }
		
	}
    
    
    /**
     * 删除记录
     * @author  alan    2014.7.22
     */
    function deleteRecord()
    {
        $ids = intval($this->input->get('id'));
        
        $where = '';
        if(is_array($ids))
        {
            if(in_array(1, $ids))
            {
                echoMsg(10008);
            }
            $where .= ' id IN ('.implode(',' ,$ids).')';
        }else
        {
            if($ids == 1)
            {
                echoMsg(10008);
            }
            $where .= ' id = '.$ids;
        }
        $query = $this->db->query('SELECT * FROM '.DBPREFIX.'admin_role WHERE '.$where); 
        if($query->num_rows() > 0)
        {
            if(is_array($ids))
            {
                $data = $query->result_array();
            }else
            {
                $data = $query->row_array();
            }
        }

        $deleteSql = 'DELETE FROM '.DBPREFIX.'admin_role WHERE '.$where;
        $this->db->query($deleteSql);
        if($this->db->affected_rows() > 0)
        {
            if(is_array($ids)) // 如果是批量删除
            {
                foreach($data as $v)
                {
                    // 添加操作日志
                    $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                    $this->Admin_log_model->setAdminLog(
                        '批量删除角色：'.$v['role_name']
                    );
                }
            }
            else
            {
                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '删除角色：'.$data['role_name']
                );
            }
            return TRUE;
        }else
        {
            return FALSE;
        }
    } 

}