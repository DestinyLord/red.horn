<?php

class MY_Controller extends CI_Controller
{
    //protected $page_title;
    public $siteTitle;
    public $siteBackendTitle;
    public $breadCurumbs;

    function __construct()
    {
        parent::__construct();

        $this->uri->segment(1);
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Admin_menu_model');
        $adminMenu = $this->Admin_menu_model->getMenuItems();
        $this->template->assign('adminMenu', $adminMenu); //菜单列表

        $currentMenuUrl = $this->uri->segment(2);
        if($this->uri->segment(3))
        {
            $currentMenuUrl .= '/'.$this->uri->segment(3);
        }

        $currentMenuUrl = $currentMenuUrl ? $currentMenuUrl : 'main';
        $queue = $this->Admin_menu_model->getMenuItem(
            ['where' => ['menu_url' => $currentMenuUrl]],
            'queue'
        );

        if (empty($queue))
        {
            /*如果现在的菜单没查得出，那就是这是添加、修改操作或者其他不在菜单里面的链接，
            就以控制器的名称为准*/
            $currentMenuUrlArr = explode('/', $currentMenuUrl);
            $queue = $this->Admin_menu_model->getMenuItem(
                ['where' => ['menu_url' => $currentMenuUrlArr[0]]],
                'queue'
            );
        }

        $this->template->assign('queue', $queue);
        $this->template->assign('currentMenuUrl', $currentMenuUrl);

        //位置信息 BEGIN
        $this->load->config('bread_crumbs'); //别载位置信息配置
        $this->breadCurumbs = $this->config->item('bread_crumbs'); //位置信息
        //位置信息 END

        //$this->output->enable_profiler(true);
    }
}
