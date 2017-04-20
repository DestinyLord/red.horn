<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Admin extends MY_Controller
{
    /**
     * Admin constructor.
     */
	function __construct()
	{
		parent::__construct();
        check_admin_is_login();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME.'/admin');
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_model');
	}

    /**
     * 菜单管理
     */
	function index()
	{
        noPrivShowMsg('adminUserManage');
        $datas = $this->Admin_model->getRecords();
        $this->template->assign('datas' ,$datas);
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['admin']);//位置信息
        $this->template->display('index.tpl');
	}

    /**
     * 用户信息页面
     */
    function info()
    {
        $userData = $this->Admin_model->getUserInfo();
        $this->template->assign('userData' ,$userData);
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['admin_user_profile']);//位置信息
        $this->template->display('user_profile.tpl');
    }


    /**
     * 添加页面
     */
    function add()
    {
        noPrivShowMsg('adminUserAdd');
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
        $editData = array();
        
        //上级用户
        $adminUserList = $this->Admin_model->getRecords();
        $this->template->assign('adminUserList' ,$adminUserList);
        
        //管理员角色
        $adminRole = $this->Admin_role_model->getRecords();
        $this->template->assign('adminRole' ,$adminRole);
        
        $this->template->assign('editData' ,$editData);
        $this->template->assign('formAction' ,site_url(BACKEND_DIR_NAME.'/admin/insert'));
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['admin_add']);//位置信息
        $this->template->display('info.tpl');
    }
    
    /**
     * 修改页面
     * @author  alan    2014.7.22
     * @param   $id     INT     表ID     
     */ 
    function edit($id)
    {
        noPrivShowMsg('adminUserEdit');
        if($id == 1 && !checkIsAdmin())
        {
            echo_msg(10008);
        }
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
        $editData = array();
        if($id)
        {
            $editData = $this->Admin_model->getRecord($id);
        }else
        {
            echo_msg(10002);
        }   
        
        $adminUserList = $this->Admin_model->getRecords();
        $this->template->assign('adminUserList' ,$adminUserList);//左边菜单的活动判断
        
        //管理员角色
        $adminRole = $this->Admin_role_model->getRecords();
        $this->template->assign('adminRole' ,$adminRole);
        
        $this->template->assign('editData' ,$editData);
        $this->template->assign('formAction' ,site_url(BACKEND_DIR_NAME.'/admin/update'));
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['admin_edit']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 更改个人信息
     */
    function updateUserInfo()
    {
        $options = array();
        //头像上传处理
        if(isset($_FILES['avatar_path']))
        {
            $uploadData = do_upload(
                [
                    'up_path'   => UPLOAD_BASE_PATH.'admin/avatar/',
                    'form_name' => "avatar_path",
                    'suffix'    => UP_IMAGE_EXT
                ]
            );

            if(!$uploadData['status'])
    		{
    			echo_msg($uploadData['upload_errors']);
    		}
            
            if($uploadData['file_path'])
            {
                $options['avatar_path'] = $uploadData['file_path'];
            }
            
        }
        if($this->Admin_model->updateUserInfo($options))
        {
            if($this->input->post('new_password'))
            {
                $redirect = site_url(BACKEND_DIR_NAME.'/login/logout');
            }
            else
            {
                $redirect = '';
            }

            echo_msg(10000, $redirect, 'yes');
        }
        else
        {
            echo_msg(10001);
        }
    }
    
    /**
     * 校验当前用户密码是否正确
     * @author  alan    2014.7.28
     */
    function checkPasswordIsRight()
    {
        $password = $this->input->post('current_password'); 
        echo json_encode($this->Admin_model->checkPasswordIsRight($password));
    } 
    /**
     * 添加处理
     * @author  alan    2014.7.22
     */ 
    function insert()
    {
        noPrivShowMsg('adminUserAdd');   
        $this->form_validation->set_rules("username","用户名","trim|required|min_length[6]|max_length[18]");
		$this->form_validation->set_rules("password","密码","trim|required|min_length[8]|max_length[18]");

		if($this->form_validation->run()==FALSE)
		{
			echo_msg(validation_errors());
		}
        $res = $this->Admin_model->insertRecord();

        if($res == 2)
        {
            echo_msg(10010);
        }
        elseif($res == 1)
        {
            echo_msg(10003, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
        }
        elseif($res == 0)
        {
            echo_msg(10004);
        }
    }
    
    /**
     * 检查用户名是否存在
     * @author  alan    2014.8.6
     * @return  Json    true or false
     */
    function checkUserIsExist() 
    {
       $res = $this->Admin_model->checkUserIsExist();
       
       if($res)
       {
            echo json_encode(false);
       }else
       {
            echo json_encode(true);
       }
    }
    /**
     * 修改处理
     * @author  alan    2014.7.22
     */ 
    function update()
    {
        noPrivShowMsg('adminUserEdit');  
        $this->form_validation->set_rules("username","用户名","trim|required|min_length[6]|max_length[18]");
        $this->form_validation->set_rules("password","密码","trim|min_length[8]|max_length[18]");
        if($this->form_validation->run()==FALSE)
		{
			echo_msg(validation_errors());
		} 
        $res = $this->Admin_model->updateRecord();
        
        if($res == 2)
        {
            echo_msg(10010);
        }elseif($res == 1)
        {
            echo_msg(10000, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
        }else
        {
            echo_msg(10001);
        }
    }
    
    /**
     * 删除处理
     * @author  alan    2014.7.22
     */ 
    function delete()
    {
        noPrivShowMsg('adminUserDel');

        $res = $this->Admin_model->deleteRecord();
        if($res)
        {
            echo_msg(10005, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
        }else
        {
            echo_msg(10006);
        }
    }
}