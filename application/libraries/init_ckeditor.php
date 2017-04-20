<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
include_once('ckeditor/ckeditor.php');
class Init_ckeditor extends CKEditor
{
	 function __construct()
     {  
        parent::__construct();
        $this->basePath = base_url('ckeditor/').'/';
        $this->config['skin'] = 'v2';
        $this->config['width'] = '100%';
        $this->config['height'] = 250;
        $this->config['font_names'] = '微软雅黑;宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;';
        $this->config['toolbar_Common'] = array(
            array("Bold","Underline","StrikeThrough","-"),
            array("JustifyLeft","JustifyCenter","JustifyRight","JustifyFull"),
            array("TextColor","BGColor"),
            //array("Link","Unlink","Anchor"),
            array("Image","Table","Rule","SpecialChar"),
            array("Undo","Redo"),
            array('Format','Font','FontSize'),
            //array('Source','-','Save','NewPage','Preview','-','Templates')
        );
        $this->config['toolbar'] = 'Common';

        $this->config['format_tags'] = 'p';
        
        include_once('ckeditor/ckfinder/ckfinder.php');
        
        CKFinder::SetupCKEditor($this,base_url('ckeditor/ckfinder'));
     }
}

/* end of file fck_model.php*/