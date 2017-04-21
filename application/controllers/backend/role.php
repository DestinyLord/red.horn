<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Role extends MY_Controller
{
	function __construct()
	{
		parent::__construct();
        check_admin_is_login();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME.'/role');
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
	}
	
    /**
     * 角色管理
     * @author  alan    2014.7.22   
     */ 
	function index()
	{
        noPrivShowMsg('roleManage');
        $datas = $this->Admin_role_model->getRoleItems();
        $this->template->assign('datas', $datas);
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['role']);//位置信息
        $this->template->display('index.tpl');
	}

    /**
     * 角色新增页面
     */
    function add()
    {
        noPrivShowMsg('roleAdd');
        $editData = [];
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/role/insert'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['role_add']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 角色修改页面
     *
     * @param $id
     */
    function edit($id)
    {
        if($id == 1 && !checkIsAdmin())
        {
            echoMsg(10008);
        }
        noPrivShowMsg('roleEdit');
        $editData = array();
        if($id == 1)
        {
            echoMsg(10007);
        }
        if($id)
        {
            $editData = $this->Admin_role_model->getRoleItem(
                ['where' => ['id' => $id]]
            );
        }else
        {
            echoMsg(10002);
        }   
        
        
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/role/update'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['role_edit']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 新增角色操作
     */
    function insert()
    {
        noPrivShowMsg('roleAdd');
        $this->form_validation->set_rules("role_name","角色名称","trim|required"); 
        
        if($this->form_validation->run() == FALSE)
		{
			echoMsg(validation_errors());
		}

        $insertData = [
            'role_name'     => $this->input->post('role_name'),
            'role_code'     => $this->input->post('role_code'),
            'role_describe' => $this->input->post('role_describe'),
        ];
        $res        = $this->Admin_role_model->insertRole($insertData);

        if($res)
        {
            echoMsg(10003, site_url(BACKEND_DIR_NAME.'/role'), 'yes');
        }
        else
        {
            echoMsg(10004);
        }
    }

    /**
     * 修改角色操作
     */
    function update()
    {
        noPrivShowMsg('roleEdit');  
        $this->form_validation->set_rules("role_name","角色名称","trim|required"); 
        
        if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}

        $id         = intval($this->input->post("id"));
        $updateData = [
            'role_name'     => $this->input->post('role_name'),
            'role_code'     => $this->input->post('role_code'),
            'role_describe' => $this->input->post('role_describe'),
        ];
        $res = $this->Admin_role_model->updateRole($id, $updateData);

        if($res)
        {
            echoMsg(10000, site_url(BACKEND_DIR_NAME.'/role'), 'yes');
        }
        else
        {
            echoMsg(10001);
        }
    }

    /**
     * 删除角色操作
     */
    function delete()
    {
        noPrivShowMsg('roleDel');

        $id  = intval($this->input->get('id'));
        $res = $this->Admin_role_model->deleteRole($id);

        if($res)
        {
            echoMsg(10005, site_url(BACKEND_DIR_NAME.'/role'), 'yes');
        }
        else
        {
            echoMsg(10006);
        }
    }
}