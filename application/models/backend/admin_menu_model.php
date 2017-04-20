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
     * 插入记录
     * @author  alan    2014.7.21
     * @return  INT OR Boolean   插入的新ID 或 FALSE  
     */ 
    function insertRecord()
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
     * 更改记录
     * @author  alan    2014.7.22
     * @return  Boolean   TRUE 或 FALSE  
     */
    function updateRecord()
	{
		$parent_id=$this->input->post("parent_id");
		$old_parent_id=$this->input->post("old_parent_id");
		$id=$this->input->post("id");
        $menuTitle = $this->input->post('menu_title');
        
        $options = array(
            'parent_id'     => $parent_id,
            'menu_title'    => $menuTitle,
            'icon_class'    => $this->input->post('icon_class'),
            'menu_url'      => $this->input->post('menu_url'),
            'action_code'   => $this->input->post('action_code'),
            'seqorder'      => $this->input->post('seqorder'),
        );
        
        //如果更改了父ID ,就更新父ID的记录和自己的记录
		if($parent_id != $old_parent_id)
		{
			$query=$this->db->get_where("admin_menu",array('id'=>$parent_id));
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
            
			$this->db->update("admin_menu",$options,array('id'=>$id));            
            $res = $this->db->affected_rows();//是否修改成功标识
            
			if($old_parent_id)
			{
				$query=$this->db->get_where("admin_menu",array('parent_id'=>$old_parent_id));//检查原来的父ID里面是否还有子菜单
				if($query->num_rows()>0)
				{
					$this->db->update("admin_menu",array("has_child"=>1),array('id'=>$old_parent_id));
				}
				else
				{
					$this->db->update("admin_menu",array("has_child"=>0),array('id'=>$old_parent_id));
				}
			}
			if($parent_id)//这条记录的父ID肯定是存在子元素
			{
				$this->db->update("admin_menu",array("has_child"=>1),array('id'=>$parent_id));
			}
			$hasChd = $this->input->post("has_child");
			if($hasChd)
			{
				$this->update_qd($id,$queue,$level);
			}
		}else
        {
            $this->db->update("admin_menu",$options,array('id'=>$id));
            
            $res = $this->db->affected_rows();//是否修改成功标识
        }
        
        //echo $this->db->last_query();exit;
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
    function update_qd($pid,$queue,$level)
	{
		$query=$this->db->get_where("admin_menu",array('parent_id'=>$pid));
        if($query->num_rows() > 0)
        {
            $res = $query->result();
    		foreach($res as $row)
    		{
    			$data=array(
    				'level'=>$level+1,
    				'queue'=>$queue.$row->id.","
    			);
    			$this->db->update("admin_menu",$data,array('id'=>$row->id));

    			if($row->has_child)
    			{
    				$this->update_qd($row->id,$data['queue'],$data['deep_id']);
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
        
        $where = '';
        if(is_array($ids))
        {
            $where .= ' id IN ('.implode(',' ,$ids).')';
        }else
        {
            $where .= ' id = '.$ids;
        }
        $query = $this->db->query('SELECT * FROM '.DBPREFIX.'admin_menu WHERE '.$where); 
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

        $deleteSql = 'DELETE FROM '.DBPREFIX.'admin_menu WHERE '.$where;
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
                        '批量删除菜单：'.$v['menu_title']
                    );
                }     
            }
            else
            {
                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '删除菜单：'.$data['menu_title']
                );
            }
            return true;
        }else
        {
            return false;
        }
    } 

}