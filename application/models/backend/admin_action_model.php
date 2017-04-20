<?php
class Admin_action_model extends CI_Model
{
	function __construct()
	{
		parent::__construct();
	}
    
    /**
     * 获取所有菜单
     * @author  alan    2014.7.21
     * @return  Array OR false   二维数组或False
     */ 
    function getRecords()
	{
		return $this->parseRecords(0);
	}
	
    /**
     * 递归获取菜单数组
     * @author  alan    2014.7.21
     * @param   $id     父ID
     * @return  Array OR false   二维数组或False
     */ 
	function parseRecords($pid)
	{
		static $records=array();
        $this->db->select('a.* ,b.action_title AS relevance_title' ,false);
        $this->db->from('admin_action AS a');
        $this->db->join('admin_action AS b' ,'a.relevance_code = b.action_code AND a.relevance_code IS NOT NULL' ,'left');
        $this->db->where('a.parent_id' ,$pid ,false);
        $this->db->where('a.is_enable' ,1);
        $this->db->order_by('b.action_id ASC');
		$query=$this->db->get();
        if($query->num_rows() > 0)
        {
            $resource = $query->result_array();
    		foreach($resource as $row)
    		{
    			$records[]=$row;
    			if($row['has_child']==1)
    			{
    				$this->parseRecords($row['action_id']);
    			}
    		}
        }
		return $records;
	}
    
    /**
     * 获取一条菜单记录
     * @author  alan    2014.7.21
     * @param   $id     INT     表ID 
     * @return  Array OR false   一维数组或False
     */ 
    function getRecord($id)
	{
		$query = $this->db->get_where('admin_action',array('action_id'=>$id));
        if($query->num_rows() > 0)
        {
            return $query->row_array();
        }else
        {
            return false;
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
	   $options = array(
                'parent_id'     => $parent_id,
                'action_title'    => $this->input->post('action_title'),
                'action_code'    => $this->input->post('action_code'),
                'relevance_code'      => $this->input->post('relevance_code'),
                'has_child'     => 0,
        );
		$this->db->insert("admin_action",$options);
        
		if($this->db->affected_rows())
		{
			$max_id = $this->db->insert_id();
			if($parent_id)
			{
				$query=$this->db->get_where("admin_action",array('action_id'=>$parent_id));
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
			$this->db->update("admin_action",$data,array('action_id'=>$max_id));
            
			if($parent_id)
			{
				$data=array('has_child'=>1);
				$this->db->update("admin_action",$data,array('action_id'=>$parent_id));
			}
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
        
        $options = array(
                'parent_id'     => $parent_id,
                'action_title'    => $this->input->post('action_title'),
                'action_code'    => $this->input->post('action_code'),
                'relevance_code'      => $this->input->post('relevance_code'),
        );
        
        //如果更改了父ID ,就更新父ID的记录和自己的记录
		if($parent_id != $old_parent_id)
		{
			$query=$this->db->get_where("admin_action",array('action_id'=>$parent_id));
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
            
			$this->db->update("admin_action",$options,array('action_id'=>$id));            
            $res = $this->db->affected_rows();//是否修改成功标识
            
			if($old_parent_id)
			{
				$query=$this->db->get_where("admin_action",array('parent_id'=>$old_parent_id));//检查原来的父ID里面是否还有子菜单
				if($query->num_rows()>0)
				{
					$this->db->update("admin_action",array("has_child"=>1),array('action_id'=>$old_parent_id));
				}
				else
				{
					$this->db->update("admin_action",array("has_child"=>0),array('action_id'=>$old_parent_id));
				}
			}
			if($parent_id)//这条记录的父ID肯定是存在子元素
			{
				$this->db->update("admin_action",array("has_child"=>1),array('action_id'=>$parent_id));
			}
			$hasChd = $this->input->post("has_child");
			if($hasChd)
			{
				$this->update_qd($id,$queue,$level);
			}
		}else
        {
            $this->db->update("admin_action",$options,array('action_id'=>$id));
            
            $res = $this->db->affected_rows();//是否修改成功标识
        }
        
        //echo $this->db->last_query();exit;
        if($res > 0)
        {
            return true;
        }else
        {
            return false;
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
		$query=$this->db->get_where("admin_action",array('parent_id'=>$pid));
        if($query->num_rows() > 0)
        {
            $res = $query->result();
    		foreach($res as $row)
    		{
    			$data=array(
    				'level'=>$level+1,
    				'queue'=>$queue.$row->id.","
    			);
    			$this->db->update("admin_action",$data,array('action_id'=>$row->id));

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
        $ids = $this->input->get('id');
        
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
            return true;
        }else
        {
            return false;
        }
    }
    
    /**
     *  设置权限
     *  @author     alan    2014.3.30
     *  @param      string  $type 设置的类型，分为用户和角色 
     *  @return     boolean     
     */ 
    function setAction($type ,$id ,$data)
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
            $this->db->update('admin' ,array('action_list'=>$actionStr) ,array('id'=>$id));          
            $affRow = $this->db->affected_rows();
        }else
        {
            $this->db->update('admin_role' ,array('action_list'=>$actionStr) ,array('id'=>$id));
            $affRow = $this->db->affected_rows();            
        }
        
        if($affRow > 0)
        {
            if($type == 'admin_user')
            {
                $data = $this->db->get_where('admin' ,array('id' => $id))->row_array();

                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '分派权限：'.$data['username']
                );
            }else
            {
                $data = $this->db->get_where('admin_role' ,array('id' => $id))->row_array();

                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '分派权限：'.$data['role_name']
                );
            }
            return true;
        }else
        {
            return false;
        }
    } 

}