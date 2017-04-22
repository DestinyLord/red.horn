<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Permission extends MY_Controller
{
	function __construct()
	{
		parent::__construct();
        check_admin_is_login();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME.'/permission');
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_action_model');
	}

    /**
     * 权限管理
     */
	function index()
	{
        noPrivShowMsg('permissionManage');
        $datas = $this->Admin_action_model->getActionItems();

        $this->template->assign('datas', $datas);
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['permission']);//位置信息
        $this->template->display('index.tpl');
	}

    /**
     * 权限新增页面
     */
    function add()
    {
        noPrivShowMsg('permissionAdd');
        $editData = [];
        
        $permissionList = $this->Admin_action_model->getActionItems();

        $this->template->assign('permissionList', $permissionList);
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/permission/insert'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['permission_add']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 权限修改页面
     *
     * @param $id
     */
    function edit($id)
    {
        noPrivShowMsg('permissionEdit');
        $editData = [];

        if($id)
        {
            $editData = $this->Admin_action_model->getActionItem(
                ['where' => ['action_id' => $id]]
            );
        }
        else
        {
            echoMsg(10002);
        }   
        
        $permissionList = $this->Admin_action_model->getActionItems();

        $this->template->assign('permissionList', $permissionList);
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/permission/update'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['permission_edit']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 权限新增操作
     */
    function insert()
    {
        noPrivShowMsg('permissionAdd');
        $this->form_validation->set_rules("action_title","权限名称","trim|required");

        if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}

        $parentId    = $this->input->post('parent_id');
        $actionTitle = $this->input->post('action_title');
        $insertData  = [
            'parent_id'      => $parentId,
            'action_title'   => $actionTitle,
            'action_code'    => $this->input->post('action_code'),
            'relevance_code' => $this->input->post('relevance_code'),
            'has_child'      => 0,
        ];
        $res        = $this->Admin_action_model->insertAction($parentId, $actionTitle, $insertData);

        if($res)
        {
            echoMsg(10003, site_url(BACKEND_DIR_NAME.'/permission'), 'yes');
        }
        else
        {
            echoMsg(10004);
        }
    }
    
    /**
     * 修改处理
     * @author  alan    2014.7.22
     */ 
    function update()
    {
        noPrivShowMsg('permissionEdit');
        $this->form_validation->set_rules("action_title","权限名称","trim|required");
        if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}    
        $res = $this->Admin_action_model->updateRecord();
        if($res)
        {
            echoMsg(10000, site_url(BACKEND_DIR_NAME.'/permission'), 'yes');
        }else
        {
            echoMsg(10001);
        }
    }
    
    /**
     * 删除处理
     * @author  alan    2014.7.22
     */ 
    function delete()
    {
        noPrivShowMsg('permissionDel');  
        $res = $this->Admin_action_model->deleteRecord();
        if($res)
        {
            echoMsg(10005, site_url(BACKEND_DIR_NAME.'/permission'), 'yes');
        }else
        {
            echoMsg(10006);
        }
    }
    
    /**
     * 分派权限页面
     * @author  alan    2014.8.8
     * @param   String  $type   分派类型
     * @param   INT     $id     分派ID
     */
    function assignPriv($type, $id)
    {
        noPrivShowMsg('assignPriv');
        if(empty($type) || ($type != 'admin_user' && $type != 'role') || empty($id))
        {
            echoMsg(10007);
        }
        
        if($type == 'admin_user')
        {
            $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_model');
            //检查是否是本人的子账号，防止修改其他人的账号
            if(!checkIsAdmin())
            {
                $childIdList = $this->Admin_model->parseRecords($this->session->userdata('cps_admin_id'));

                $idArr = array();
                if($childIdList)
                {
                    foreach($childIdList as $childId)
                    {
                        $idArr[] = $childId['id'];
                    }
                }
                if(!in_array($id, $idArr))
                {
                    echoMsg(10007);
                }
            }
            //检查 END

            // 获取要分派的人的信息
            $userData = $this->Admin_model->getAdminItem(
                ['where' => ['id' => $id]]
            );
            $curData  = explode(',',$userData['action_list']);
        }
        elseif($type == 'role')
        {
            $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_role_model');
            $roleData = $this->Admin_role_model->getRoleItem(
                ['where' => ['id' => $id]]
            );
            $curData = explode(',',$roleData['action_list']);       
        }

        $this->template->assign('curData', $curData);
        $this->template->assign('type', $type);
        $this->template->assign('id', $id);
        if($type == 'admin_user')
        {
            $this->template->assign('name', $userData['surname'] ? $userData['surname'] : $userData['username']);
        }else
        {
            $this->template->assign('name', $roleData['role_name']);
        }
        $list = $this->Admin_action_model->getActionItems();
        $newList = array();
        //显示存在权限的列表
        foreach($list as $v)
        {
            if(check_priv($v['action_code']))
            {
                $newList[] = $v;
            }
        }
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['permission_assign_priv']);//位置信息
        $this->template->assign('actionList', $newList);
        $this->template->display('assign_priv.tpl');
    }
    
    
    /**
     * 设置权限处理
     * @author  alan    2014.8.8
     */ 
    function setAction()
    {
        $id = $this->input->post('id');
        $type = $this->input->post('type');
        $data = $this->input->post('actionList');
        $status = $this->Admin_action_model->setAction($type,$id, $data);
        if($status)
        {
            if($type == 'admin_user')
            {
                echoMsg(10011, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
            }else
            {
                echoMsg(10011, site_url(BACKEND_DIR_NAME.'/role'), 'yes');
            }
            
        }else
        {
            echoMsg(10012);
        }
    }
    
    
}