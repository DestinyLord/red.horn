<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Menu extends MY_Controller    
{
	public function __construct()
	{
		parent::__construct();
        check_admin_is_login();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME.'/menu');
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_menu_model');
	}
	
    /**
     * 菜单管理
     * @author  alan    2014.7.22
     */
	public function index()
	{
        noPrivShowMsg('menuManage');
        $datas = $this->Admin_menu_model->getMenuItems();
        $this->template->assign('datas', $datas);
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['menu']);//位置信息
        $this->template->display('index.tpl');
	}

    /**
     * 菜单新增页面
     */
    public function add()
    {
        noPrivShowMsg('menuAdd');
        $editData = [];
        
        $menuList = $this->Admin_menu_model->getMenuItems();
        $this->template->assign('menuList', $menuList);
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/menu/insert'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['menu_add']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 菜单修改页面
     *
     * @param $id
     */
    public function edit($id)
    {
        noPrivShowMsg('menuEdit');
        $editData = [];

        if($id)
        {
            $editData = $this->Admin_menu_model->getMenuItem(
                ['where' => ['id' => $id]]
            );
        }
        else
        {
            echoMsg(10002);
        }   
        
        $menuList = $this->Admin_menu_model->getMenuItems();

        $this->template->assign('menuList', $menuList);
        $this->template->assign('editData', $editData);
        $this->template->assign('formAction', site_url(BACKEND_DIR_NAME.'/menu/update'));
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['menu_edit']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 菜单新增处理
     */
    public function insert()
    {
        noPrivShowMsg('menuAdd'); 
        $this->form_validation->set_rules("menu_title","菜单名称","trim|required");

        if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}

        $parentId  = $this->input->post('parent_id');
        $menuTitle = $this->input->post('menu_title');
        $options   = [
            'parent_id'   => $parentId,
            'menu_title'  => $menuTitle,
            'icon_class'  => $this->input->post('icon_class'),
            'menu_url'    => $this->input->post('menu_url'),
            'action_code' => $this->input->post('action_code'),
            'seqorder'    => $this->input->post('seqorder'),
            'has_child'   => 0,
        ];
        $res       = $this->Admin_menu_model->insertMenu(
            $parentId, $menuTitle, $options
        );

        if($res)
        {
            echoMsg(10003, site_url(BACKEND_DIR_NAME.'/menu'), 'yes');
        }
        else
        {
            echoMsg(10004);
        }
    }

    /**
     * 菜单修改处理
     */
    public function update()
    {
        noPrivShowMsg('menuEdit');
        $this->form_validation->set_rules(
            "menu_title", "菜单名称", "trim|required"
        );

        if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}

        $id          = intval($this->input->post("id"));
        $menuTitle   = $this->input->post('menu_title');
        $parentId    = $this->input->post("parent_id");
        $oldParentId = $this->input->post("old_parent_id");
        $updateData  = [
            'parent_id'   => $parentId,
            'menu_title'  => $menuTitle,
            'icon_class'  => $this->input->post('icon_class'),
            'menu_url'    => $this->input->post('menu_url'),
            'action_code' => $this->input->post('action_code'),
            'seqorder'    => $this->input->post('seqorder'),
        ];

        $res = $this->Admin_menu_model->updateMenu(
            $id, $menuTitle, $parentId, $oldParentId, $updateData
        );

        if($res)
        {
            echoMsg(10000, site_url(BACKEND_DIR_NAME.'/menu'), 'yes');
        }
        else
        {
            echoMsg(10001);
        }
    }

    /**
     * 菜单删除处理
     */
    public function delete()
    {
        noPrivShowMsg('menuDel');
        $id     = $this->input->get('id');
        $isUsed = $this->Admin_menu_model->getMenuItem(
            ['where' => ['parent_id' => $id]]
        );

        if (!empty($isUsed))
        {
            echoMsg(10014);
        }
        else
        {
            $res = $this->Admin_menu_model->deleteMenu($id);

            if($res)
            {
                echoMsg(10005, site_url(BACKEND_DIR_NAME.'/menu'), 'yes');
            }
            else
            {
                echoMsg(10006);
            }
        }
    }
}