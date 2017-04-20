<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once('smarty/Smarty.class.php');

class Template extends Smarty
{
    private $_floder;
    private $_theme;
	function __construct()
	{
		parent::__construct();
              
        $this->compile_check = true;	//设置是否重新编译, 开发过程中请设置为true，产品运行中请设置为false
        $this->debugging = 0;	//开发过程中请设置为true，产品运行中请设置为false
		$this->template_dir = APPPATH.'templates';
		$this->compile_dir = APPPATH.'templates_c';
        $this->cache_dir = APPPATH.'cache';
		$this->left_delimiter = '<{';
		$this->right_delimiter = '}>';
        $this->registerPlugin();

        //后台主要目录
        $this->assign('backendDir',BACKEND_DIR_NAME);
        $this->assign('backendViewDir',BACKEND_VIEW_DIR_NAME);
        $this->assign('backendModelDir',BACKEND_MODEL_DIR_NAME);
        
        $this->_theme = 'default'; //主题
        
        $this->assign('theme_path',base_url('themes/'.$this->_theme).'/');//后台样式路径
        $this->assign('css_path',base_url('themes/'.$this->_theme.'/css').'/');//后台样式路径
        $this->assign('js_path',base_url('themes/'.$this->_theme.'/js').'/');//后台JS路径
        $this->assign('image_path',base_url('themes/'.$this->_theme.'/images').'/');
        
        $this->assign('backendSiteTitle','红喇叭管理系统');
        $this->assign('serviceImgUrl' ,RED_HORN_SERVICE_IMG_URL);
        
        $CI = & get_instance();
        $this->assign('urlSuffix',$CI->config->item('url_suffix'));
        
        $this->assign('backendStyleColor' ,$CI->input->cookie('style_color')); //选择的颜色模板
        
        //管理员用户信息
        $this->assign('adminSurename' ,$CI->session->userdata('admin_surname'));//用户姓名
        $this->assign('adminUsername' ,$CI->session->userdata('admin_username'));//用户账号
        $this->assign('adminUserAvatar' ,$CI->session->userdata('admin_avatar'));//用户头像
	}
    function registerPlugin()
	{
		parent::registerPlugin('function','base_url','base_url');
		parent::registerPlugin('function','site_url','site_url');
		parent::registerPlugin('function','current_url','current_url');
	}
	function set_folder($floder)
	{
		$this->_floder = $floder;
	}
    function display($template)
	{
		if($this->_floder)
		{
			parent::display($this->_floder.'/'.$template);
		}
		else
		{
			parent::display($template);
		}
	}
}