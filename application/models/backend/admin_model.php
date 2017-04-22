<?php
class Admin_model extends Core_model
{
    /**
     * @var string
     */
    protected $_tableName = 'backend_admin';

    /**
     * Admin_model constructor.
     */
	function __construct()
	{
		parent::__construct();
	}

    /**
     * 校验用户帐号密码
     * @param $username
     * @param $password
     * @return bool
     */
	function checkUser($username, $password)
	{
        $row = $this->getItem(
            $this->_tableName, ['where' => ['username' => $username]]
        );

		if(!empty($row))
		{
            if(md5($row['salt'] . $password) !== $row['password'])
            {
                return false;
            }
			
			$data = array(
				'last_login_ip'   => $this->input->ip_address(),
				'last_login_time' => time(),
				'hits'            => $row['hits'] + 1
			);
            $this->update(
                $this->_tableName, $data, ['username' => $username]
            );

            // 获取角色信息
            $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
            $role = $this->Admin_role_model->getRoleItem(
                ['where' => ['id' => $row['admin_role_id']]]
            );
            
			$sessionData = [
				'admin_id'              => $row['id'],
                'admin_username'        => $row['username'],
                'admin_surname'         => $row['surname'],
				'admin_last_login_time' => date("Y-m-d H:i:s",$row['last_login_time']),
				'admin_login_ip'        => $row['last_login_ip'],
				'admin_role_id'         => $row['admin_role_id'],
				'admin_hits'            => $data['hits'],
                'admin_action_list'     => $row['action_list'] . ',' . $role['action_list'],
                'admin_avatar'          => $row['avatar_path'],
			];

			$this->session->set_userdata($sessionData);
			return true;
		}
		else
		{
			return false;
		}
		
	}

    /**
     * 根据条件获取某个管理员数据
     *
     * @param $params
     * @param string $keyWord
     * @return array
     */
    public function getAdminItem($params, $keyWord = '')
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
     * 根据条件获取多个管理员数据，除了超级管理员
     *
     * @param bool $isTree
     * @param array $params
     * @return array
     */
    public function getAdminItems($isTree = TRUE, $params = [])
    {
        $params['order_by']         = 'a.admin_role_id, a.hits DESC, a.id DESC';
        $params['where']['a.id !='] = 1;

        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
        $params['join'] = [
            'table' => "{$this->Admin_role_model->_tableName} AS ar",
            'cond'  => 'a.admin_role_id = ar.id',
            'type'  => 'left'
        ];
        $data           = $this->getItems(
            "{$this->_tableName} AS a", 'a.*, ar.role_name', $params
        );
        $result = [];

        if ($isTree)
        {
            getTreeData($data, 0, $result);
        }
        else
        {
            $result = $data;
        }

        return $result;
    }
	
    /**
     * 递归获取数据
     * @author  alan    2014.7.21
     * @param   $id     父ID
     * @return  Array OR false   二维数组或False
     */ 
	function parseRecords($pid)
	{
		static $records=array();
        $this->db->select('a.*, ar.role_name',false);
        $this->db->from('admin AS a');
        $this->db->join('admin_role AS ar', 'a.admin_role_id = ar.id', 'left');
        $this->db->where('a.id != ', 1); //不显示超级管理员
        $this->db->where('a.parent_id', $pid);
        $this->db->order_by('a.admin_role_id, a.hits DESC, a.id DESC');
		$query=$this->db->get();
        if($query->num_rows() > 0)
        {
            $resource = $query->result_array();
    		foreach($resource as $row)
    		{
    			$records[]=$row;
    			if($row['has_child']==1)
    			{
    				$this->parseRecords($row['id']);
    			}
    		}
        }
		return $records;
	}

    /**
     * 获取用户信息
     *
     * @return array
     */
    function getUserInfo() 
    {
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
        $_roleTableName = $this->Admin_role_model->_tableName;

        $this->db->select(
            'a.*, ar.role_name, ap.surname AS psurname, ap.username AS pusername',
            false
        );
        $this->db->from($this->_tableName . ' AS a');
        $this->db->join(
            $_roleTableName . ' AS ar', 'a.admin_role_id = ar.id', 'left'
        );
        // 父级信息
        $this->db->join(
            $this->_tableName . ' AS ap', 'ap.id = a.parent_id', 'left'
        );
        $this->db->where('a.id',$this->session->userdata('admin_id'));
        $query = $this->db->get();

        if($query->num_rows() > 0)
        {
            return $query->row_array();
        }
        else
        {
            return [];
        }
    }

    /**
     * 检查当前用户的密码
     *
     * @param $password
     * @return bool
     */
    function checkPasswordIsRight($password) 
    {
        $admin = $this->Admin_model->getAdminItem(
            ['where' => ['id' => $this->session->userdata('admin_id')]]
        );
        
        if(md5($admin['salt'] . $password) == $admin['password'])
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    } 
    /**
     * 添加记录
     * @author  alan    2014.7.21
     * @return  INT    2:用户名存在 ，0:添加失败 ，1:添加成功  
     */ 
    function insertRecord()
	{
	   $parent_id = $this->input->post('parent_id');
       $username = $this->input->post('username');
       
        //检查用户名是否存在
        $query=$this->db->get_where("admin",array('username'=>$username));
        if($query->num_rows()>0)
        {
        	return 2;
        }
       
       $salt =  mt_rand(1000, 50000);
	   $options = array(
                'parent_id'     => $parent_id ? $parent_id : 0,
                'admin_role_id' => $this->input->post('admin_role_id'),
                'username'      => $username,
                'password'      => md5($salt.$this->input->post('password')),
                'surname'       => $this->input->post('surname'),
                'salt'          => $salt,
                'has_child'     => 0,
                'create_time'   => time(),
        );
        	
		$this->db->insert("admin",$options);
        
		if($this->db->affected_rows())
		{
			$max_id = $this->db->insert_id();
			if($parent_id)
			{
				$query=$this->db->get_where("admin",array('id'=>$parent_id));
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
			$this->db->update("admin",$data,array('id'=>$max_id));
            
			if($parent_id)
			{
				$data=array('has_child'=>1);
				$this->db->update("admin",$data,array('id'=>$parent_id));
			}

            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '添加管理员：'.$username
            );

			return 1;	
		}
		else
		{
			return 0;
		}
	}


    /**
     * 检查用户是否已存在
     *
     * @param int $id
     * @param $userName
     * @return bool
     */
    function checkUserIsExist($id = 0, $userName)
    {
        //检查用户名是否存在
        if($id)
        {
            $where = ['id !=' => $id, 'username' => $userName];
        }
        else
        {
            $where = ['username' => $userName];
        }

        $result = $this->getTotals($this->_tableName, ['where' => $where]);

        return !boolval($result);
    }
    
    /**
     * 更改记录
     * @author  alan    2014.7.22
     * @return  INT    2:用户名存在 ，0:添加失败 ，1:添加成功 
     */
    function updateRecord()
	{
		$parent_id=$this->input->post("parent_id");
        $username = $this->input->post('username');
		$old_parent_id=$this->input->post("old_parent_id");
        $oldUsername=$this->input->post("old_username");
		$id=$this->input->post("id");
        
        if($id == 1 && !checkIsAdmin())
        {
            echoMsg(10008);
        }

        //修改的用户信息
        $userData = $this->getAdminItem(
            ['where' => ['id' => $id]]
        );
        //检查这个操作人是否是这条记录的上级，不然，没资格修改
        $parentIdArr = explode(',', trim($userData['queue'], ','));
        if(!in_array($this->session->userdata('admin_id'), $parentIdArr) && $this->session->userdata('admin_id') != 1)
        {
            echoMsg(10002);
        }
        if($username != $oldUsername)//如果用户名有变动，才检查这个用户名是否存在
        {
            $query=$this->db->get_where("admin",array('username'=>$username));
    		if($query->num_rows()>0)
    		{
    		  if($query->row_array())
    			return 2;
    		}
        }
        
        $options = array(
                'parent_id'     => $parent_id ? $parent_id : 0,
                'admin_role_id' => $this->input->post('admin_role_id'),
                'username'      => $username,
                'surname'       => $this->input->post('surname'),
                'create_time'   => time(),
        );
        
        //如果密码不为空，即更改密码
        if($this->input->post('new_password'))
        {
            
            $salt =  mt_rand(1000, 50000);
            $options['password'] = md5($salt.$this->input->post('new_password'));
            $options['salt'] = $salt;
        }
        
        //如果更改了父ID, 就更新父ID的记录和自己的记录
		if($parent_id != $old_parent_id)
		{
			$query=$this->db->get_where("admin",array('id'=>$parent_id));
			if($query->num_rows()>0)
			{
				$row=$query->row_array();
				$level=(int)$row['level']+1;
				$queue=$row['queue'].$id.",";
			}
			else
			{
				$level=0;
				$queue=",".$id.",";
			}
            
			$options['queue'] = $queue;
            $options['level'] = $level;
            
			$this->db->update("admin",$options,array('id'=>$id));   

            $res = $this->db->affected_rows();//是否修改成功标识
            
			if($old_parent_id)
			{
				$query=$this->db->get_where("admin",array('parent_id'=>$old_parent_id));//检查原来的父ID里面是否还有子菜单
				if($query->num_rows()>0)
				{
					$this->db->update("admin",array("has_child"=>1),array('id'=>$old_parent_id));
				}
				else
				{
					$this->db->update("admin",array("has_child"=>0),array('id'=>$old_parent_id));
				}
			}
			if($parent_id)//这条记录的父ID肯定是存在子元素
			{
				$this->db->update("admin",array("has_child"=>1),array('id'=>$parent_id));
			}
			$hasChd = $this->input->post("has_child");
			if($hasChd)
			{
				$this->update_qd($id,$queue,$level);
			}
		}else
        {
            $this->db->update("admin",$options,array('id'=>$id));
            $res = $this->db->affected_rows();//是否修改成功标识
        }
        
        //echo $this->db->last_query();exit;
        if($res > 0)
        {
            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '修改管理员：'.$username
            );
            return 1;
        }else
        {
            return 0;
        }
		
	}
    
    /**
     * 递归更改子菜单的级别和目录树
     * @param   $pid    INT     父ID
     * @param   $queue  String  目录树
     * @param   $level  INT     目录级别     
     */ 
    function update_qd($pid,$queue,$level)
	{
		$query=$this->db->get_where("admin",array('parent_id'=>$pid));
        if($query->num_rows() > 0)
        {
            $res = $query->result();
    		foreach($res as $row)
    		{
    			$data=array(
    				'level'=>$level+1,
    				'queue'=>$queue.$row->id.","
    			);
    			$this->db->update("admin",$data,array('id'=>$row->id));

    			if($row->has_child)
    			{
    				$this->update_qd($row->id,$data['queue'],$data['deep_id']);
    			}
    		}
        }
	}


    /**
     * 更改个人信息
     *
     * @param array $extraOptions
     * @return bool
     */
    function updateUserInfo($extraOptions = [])
    {
        //姓名和Email处理
        $options = [];

        if (!empty($this->input->post('surname')))
        {
            $options['surname']=$this->input->post('surname');
        }

        if (!empty($this->input->post('email')))
        {
            $options['email'] = $this->input->post('email');
        }

        //密码处理
        $newPassword = $this->input->post('new_password');

        if(!empty($newPassword))
        {
            if($this->checkPasswordIsRight($this->input->post('current_password')))//检查原密码是否正确
            {
                $salt = mt_rand(1000, 50000);
                $options['password'] = md5($salt.$newPassword);
                $options['salt'] = $salt;
            }
            else
            {
                return FALSE;
            }
        }

        $options = array_merge($options, $extraOptions);

        if(count($options) > 0)//存在修改的时候才执行
        {
            $result = $this->update(
                $this->_tableName, $options, ['id'=>$this->session->userdata('admin_id')]
            );

            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '更改个人信息：' . $this->session->userdata('admin_username')
            );

            return $result > 0 ? TRUE : FALSE;
        }
        else
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
        $ids   = intval($this->input->get('id'));
        $where = '';
        if(is_array($ids))
        {
            if(in_array(1, $ids))
            {
                echoMsg(10008);
            }
            $where .= ' id IN ('.implode(',', $ids).')';
        }else
        {
            if($ids == 1)
            {
                echoMsg(10008);
            }
            $where .= ' id = '.$ids;
        }
        $query = $this->db->query('SELECT * FROM '.DBPREFIX.'admin WHERE '.$where); 
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

        $deleteSql = 'DELETE FROM '.DBPREFIX.'admin WHERE '.$where;
        $this->db->query($deleteSql);
        if($this->db->affected_rows() > 0)
        {
            if(is_array($ids)) //如果是批量删除
            {
                foreach($data as $v)
                {
                    // 添加操作日志
                    $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                    $this->Admin_log_model->setAdminLog(
                        '批量删除管理员：'.$v['username']
                    );
                }     
            }
            else
            {
                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '删除管理员：'.$data['username']
                );
            }
            
            return true;
        }else
        {
            return false;
        }
    } 
    

}
?>