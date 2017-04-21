<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Log extends MY_Controller
{
	function __construct()
	{
		parent::__construct();
        //echo date('Y-m-d H:i:s', 1407402480720 /1000);exit;
        check_admin_is_login();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME . '/log');
        $this->load->model(BACKEND_MODEL_DIR_NAME . '/Log_model');
	}
	
    /**
     * 日志管理
     * @author  alan    2014.7.22   
     */ 
	function index()
	{
        noPrivShowMsg('adminLog');
        $datas = $this->Log_model->getRecords();
        $this->template->assign('datas', $datas);
        
        //商务列表
        $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_model');
        $adminUser = $this->Admin_model->getAdminItems();
        $this->template->assign('adminUser', $adminUser);
        
        $this->template->assign('breadCurumbs', $this->breadCurumbs['backend']['adminLog']);//位置信息
        $this->template->display('index.tpl');
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
            echoMsg(10005, site_url(BACKEND_DIR_NAME.'/admin'), 'yes');
        }else
        {
            echoMsg(10006);
        }
    }
}