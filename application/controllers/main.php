<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Main extends MY_Controller
{
	function __construct()
	{
		parent::__construct();
        check_admin_is_login();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME.'/main');
	}
	
	function index()
	{
        $this->template->display('index.tpl');
	}
    
}