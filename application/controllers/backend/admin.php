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
     * 管理员管理
     */
	function index()
	{
        noPrivShowMsg('adminUserManage');
        $datas = $this->Admin_model->getAdminItems();
        $this->template->assign('datas', $datas);
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['admin']);//位置信息
        $this->template->display('index.tpl');
	}

    /**
     * 管理员信息页面
     */
    function info()
    {
        $userData = $this->Admin_model->getUserInfo();
        $this->template->assign('userData', $userData);
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['admin_user_profile']);//位置信息
        $this->template->display('user_profile.tpl');
    }


    /**
     * 管理员新增页面
     */
    function add()
    {
        noPrivShowMsg('adminUserAdd');
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
        $editData = [];
        
        //上级用户
        $adminUserList = $this->Admin_model->getAdminItems();
        $this->template->assign('adminUserList', $adminUserList);
        
        //管理员角色
        $adminRole = $this->Admin_role_model->getRoleItems();
        $this->template->assign('adminRole', $adminRole);
        
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/admin/insert'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['admin_add']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 管理员修改页面
     *
     * @param $id
     */
    function edit($id)
    {
        noPrivShowMsg('adminUserEdit');

        if($id == 1 && !checkIsAdmin())
        {
            echoMsg(10008);
        }

        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
        $editData = [];

        if($id)
        {
            $editData = $this->Admin_model->getAdminItem(
                ['where' => ['id' => $id]]
            );
        }
        else
        {
            echoMsg(10002);
        }   
        
        $adminUserList = $this->Admin_model->getAdminItems();
        // 左边菜单的活动判断
        $this->template->assign('adminUserList', $adminUserList);
        // 管理员角色
        $adminRole = $this->Admin_role_model->getRoleItems();

        $this->template->assign('adminRole', $adminRole);
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/admin/update'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['admin_edit']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 更改个人信息
     */
    function updateUserInfo()
    {
        $options = [];

        //头像上传处理
        if(isset($_FILES['avatar_path']))
        {
            $uploadData = doUpload(
                [
                    'up_path'   => UPLOAD_BASE_PATH.'admin/avatar/',
                    'form_name' => "avatar_path",
                    'suffix'    => UP_IMAGE_EXT
                ]
            );

            if(!$uploadData['status'])
    		{
    			echoMsg($uploadData['upload_errors']);
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

            echoMsg(10000, $redirect, 'yes');
        }
        else
        {
            echoMsg(10001);
        }
    }

    /**
     * 校验当前用户密码是否正确
     */
    function checkPasswordIsRight()
    {
        $password = $this->input->post('current_password'); 
        echo json_encode($this->Admin_model->checkPasswordIsRight($password));
    }

    /**
     * 管理员新增处理
     */
    function insert()
    {
        noPrivShowMsg('adminUserAdd');   
        $this->form_validation->set_rules("username","用户名","trim|required|min_length[6]|max_length[18]");
		$this->form_validation->set_rules("password","密码","trim|required|min_length[8]|max_length[18]");

		if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}
        $res = $this->Admin_model->insertRecord();

        if($res == 2)
        {
            echoMsg(10010);
        }
        elseif($res == 1)
        {
            echoMsg(10003, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
        }
        elseif($res == 0)
        {
            echoMsg(10004);
        }
    }

    /**
     * 检查用户名是否存在
     */
    function checkUserIsExist() 
    {
       $res = $this->Admin_model->checkUserIsExist();
       
       if($res)
       {
           jsonEcho(FALSE);
       }
       else
       {
           jsonEcho(TRUE);
       }
    }

    /**
     * 管理员修改处理
     */
    function update()
    {
        noPrivShowMsg('adminUserEdit');  
        $this->form_validation->set_rules(
            "username","用户名","trim|required|min_length[6]|max_length[18]"
        );
        $this->form_validation->set_rules(
            "password","密码","trim|min_length[8]|max_length[18]"
        );

        if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}

        $res = $this->Admin_model->updateRecord();
        
        if($res == 2)
        {
            echoMsg(10010);
        }
        elseif($res == 1)
        {
            echoMsg(10000, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
        }
        else
        {
            echoMsg(10001);
        }
    }

    /**
     * 管理员删除处理
     */
    function delete()
    {
        noPrivShowMsg('adminUserDel');

        $res = $this->Admin_model->deleteRecord();

        if($res)
        {
            echoMsg(10005, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
        }
        else
        {
            echoMsg(10006);
        }
    }
}