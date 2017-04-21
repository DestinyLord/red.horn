<?php   if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Ad extends MY_Controller
{
	function __construct()
	{
		parent::__construct();
        //echo date('Y-m-d H:i:s' ,1407402480720 /1000);exit;
        check_admin_is_login();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME.'/ad');
        $this->load->model(BACKEND_MODEL_DIR_NAME.'/Ad_model');
	}
	
    /**
     * 菜单管理
     * @author  alan    2014.7.22   
     */ 
	function index()
	{
        noPrivShowMsg('adManage');
        $datas = $this->Ad_model->getRecords();
        $this->template->assign('datas' ,$datas);
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['adManage']);//位置信息
        $this->template->display('index.tpl');
	}
    
    /**
     * 添加页面
     * @author  alan    2014.7.22   
     */ 
    function add()
    {
        noPrivShowMsg('adAdd');

        //清除上传图片缓存，当刷新页面的时候，把原来的上传数据删除，主要避免上传插件出现混乱
        $uploadData = $this->session->userdata('uploadData') ? $this->session->userdata('uploadData') : array();
        if(isset($uploadData['ad']) && !empty($uploadData['ad']))
        {
            unset($uploadData['ad']);
            $this->session->set_userdata(array('uploadData' => $uploadData));
        }     

        $editData = array();
        $channelList = $this->Ad_model->getChannelList();
        $this->template->assign('channelList' ,$channelList);

        
        $this->template->assign('editData' ,$editData);
        $this->template->assign('formAction' ,site_url(BACKEND_DIR_NAME.'/ad/insert'));
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['adAdd']);//位置信息
        $this->template->display('add.tpl');
    }
    
    /**
     * 修改页面
     * @author  alan    2014.7.22
     * @param   $id     INT     表ID     
     */ 
    function edit($id)
    {
        noPrivShowMsg('adEdit');

        //清除上传图片缓存，把原来的上传数据删除，主要避免上传插件上传数据出现混乱
        $uploadData = $this->session->userdata('uploadData') ? $this->session->userdata('uploadData') : array();
        if(isset($uploadData['ad']) && !empty($uploadData['ad']))
        {
            unset($uploadData['ad']);
            $this->session->set_userdata(array('uploadData' => $uploadData));
        }

        $editData = array();
        if($id)
        {
            $editData = $this->Ad_model->getRecord($id);
        }else
        {
            echoMsg(10002);
        }
        if(empty($editData))
        {
            show_404();
        }   
        
        $channelList = $this->Ad_model->getChannelList();
        $this->template->assign('channelList' ,$channelList);

        $pageList = $this->Ad_model->getAdPagelList($editData['channel_id']);
        $this->template->assign('pageList' ,$pageList);

        $positionList = $this->Ad_model->getAdPositionList($editData['page_id']);
        $this->template->assign('positionList' ,$positionList);

        $images = $this->Ad_model->getAdImages($editData['id']);
        $this->template->assign('images' ,$images);

        $this->template->assign('editData' ,$editData);
        $this->template->assign('formAction' ,site_url(BACKEND_DIR_NAME.'/ad/update'));
        $this->template->assign('breadCurumbs' ,$this->breadCurumbs['backend']['adEdit']);//位置信息
        $this->template->display('edit.tpl');
    }
    
    
    /**
     * 添加处理
     * @author  alan    2014.7.22
     */ 
    function insert()
    {
        noPrivShowMsg('adAdd');   
        $this->form_validation->set_rules("ad_name","广告名称","trim|required");
		$this->form_validation->set_rules("position_id","广告点位","trim|required");
        $this->form_validation->set_rules("width","广告长度","trim|required|is_natural_no_zero");
        $this->form_validation->set_rules("height","广告宽度","trim|required|is_natural_no_zero");

		if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}
        $res = $this->Ad_model->insertRecord();
        if($res)
        {
            echoMsg(10003, site_url(BACKEND_DIR_NAME.'/ad'), 'yes');
        }else
        {
            echoMsg(10004 );
        }
    }
    

    /**
     * 修改处理
     * @author  alan    2014.7.22
     */ 
    function update()
    {
        noPrivShowMsg('adEdit');  
        $this->form_validation->set_rules("ad_name","广告名称","trim|required");
        $this->form_validation->set_rules("position_id","广告点位","trim|required");
        $this->form_validation->set_rules("width","广告长度","trim|required|is_natural_no_zero");
        $this->form_validation->set_rules("height","广告宽度","trim|required|is_natural_no_zero");
        if($this->form_validation->run()==FALSE)
		{
			echoMsg(validation_errors());
		}
        //echo '<pre>';print_r($this->session->userdata('uploadData'));exit; 
        $res = $this->Ad_model->updateRecord();
        if($res)
        {
            echoMsg(10000, site_url(BACKEND_DIR_NAME.'/ad'), 'yes');
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
        noPrivShowMsg('adDel');
        $res = $this->Ad_model->deleteRecord();
        if($res)
        {
            echoMsg(10005, site_url(BACKEND_DIR_NAME.'/ad'), 'yes');
        }else
        {
            echoMsg(10006);
        }
    }

    /**
     * 删除广告图片
     * @return Boolean
     */
    public function delImage()
    {
        $ids = $this->input->get('id');
        $res = $this->Ad_model->delImage($ids);
        return true;
    }

    /**
     * 获取所有页面
     * @param  INT $channelId 频道ID
     * @return Array
     */
    public function getPageList($channelId = '')
    {
        if(empty($channelId))
        {
            echo '';
            exit;
        }
        $list = $this->Ad_model->getAdPagelList($channelId);

        echo json_encode(array('datas'=>$list));
        exit;
    }

    /**
     * 获取所有页面
     * @param  INT $channelId 频道ID
     * @return Array
     */
    public function getPositionList($pageId = '')
    {
        if(empty($pageId))
        {
            echo '';
            exit;
        }
        $list = $this->Ad_model->getAdPositionList($pageId);
        echo json_encode(array('datas'=>$list));
        exit;
    }
}