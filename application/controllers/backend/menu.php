<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Menu extends MY_Controller    
{
	function __construct()
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
	function index()
	{
        noPrivShowMsg('menuManage');
        $datas = $this->Admin_menu_model->getMenuItems();
        $this->template->assign('datas' ,$datas);
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['menu']);//位置信息
        $this->template->display('index.tpl');
	}
    
    /**
     * 菜单新增页面
     * @author  alan    2014.7.22   
     */ 
    function add()
    {
        noPrivShowMsg('menuAdd');
        $editData = array();
        
        $menuList = $this->Admin_menu_model->getMenuItems();
        $this->template->assign('menuList' ,$menuList);
        
        $this->template->assign('editData' ,$editData);
        $this->template->assign('formAction' ,site_url(BACKEND_DIR_NAME.'/menu/insert'));
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['menu_add']);//位置信息
        $this->template->display('info.tpl');
    }

    /**
     * 菜单修改页面
     *
     * @param $id
     */
    function edit($id)
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
            echo_msg(10002);
        }   
        
        $menuList = $this->Admin_menu_model->getMenuItems();

        $this->template->assign('menuList' ,$menuList);
        $this->template->assign('editData' ,$editData);
        $this->template->assign('formAction' ,site_url(BACKEND_DIR_NAME.'/menu/update'));
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['menu_edit']);//位置信息
        $this->template->display('info.tpl');
    }
    
    /**
     * 添加处理
     * @author  alan    2014.7.22
     */ 
    function insert()
    {
        noPrivShowMsg('menuAdd'); 
        $this->form_validation->set_rules("menu_title","菜单名称","trim|required");
        if($this->form_validation->run()==FALSE)
		{
			echo_msg(validation_errors());
		}    
        $res = $this->Admin_menu_model->insertRecord();
        if($res)
        {
            echo_msg(10003 ,site_url(BACKEND_DIR_NAME.'/menu') ,'yes');
        }else
        {
            echo_msg(10004 );
        }
    }
    
    /**
     * 修改处理
     * @author  alan    2014.7.22
     */ 
    function update()
    {
        noPrivShowMsg('menuEdit');   
        $this->form_validation->set_rules("menu_title","菜单名称","trim|required");
        if($this->form_validation->run()==FALSE)
		{
			echo_msg(validation_errors());
		}  
        $res = $this->Admin_menu_model->updateRecord();
        if($res)
        {
            echo_msg(10000 ,site_url(BACKEND_DIR_NAME.'/menu') ,'yes');
        }else
        {
            echo_msg(10001 );
        }
    }
    
    /**
     * 删除处理
     * @author  alan    2014.7.22
     */ 
    function delete()
    {
        noPrivShowMsg('menuDel');
        $res = $this->Admin_menu_model->deleteRecord();
        if($res)
        {
            echo_msg(10005, site_url(BACKEND_DIR_NAME.'/menu'), 'yes');
        }else
        {
            echo_msg(10006);
        }
    }
}