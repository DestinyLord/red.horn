<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Login extends CI_Controller
{
    /**
     * @var array
     */
    private $captchaConfig = array();

    /**
     * Login constructor.
     */
	public function __construct()
	{
		parent::__construct();
		$this->load->library('form_validation');
		$this->load->model(BACKEND_MODEL_DIR_NAME."/Admin_model");
        $this->_setCaptchaConfig();
        $this->template->set_folder(BACKEND_VIEW_DIR_NAME.'/login/');
	}

    /**
     * 首页
     */
	public function index()
	{
        $this->template->display("index.tpl");
	}

    /**
     * 验证码图片输出
     */
    function getLoginCaptcha()
    {
        $this->load->library('captcha',$this->_getCaptchaConfig());
        jsonEcho($this->captcha->entry());
   	}

    /**
     * 检查登录
     */
    function checkLogin()
	{
		$this->form_validation->set_rules('username','管理员账号','required');
		$this->form_validation->set_rules('password','管理员密码','required');
        $this->form_validation->set_rules('captcha_code','验证码','required');
		$msg = "";

		if($this->form_validation->run()==FALSE)
		{
			$msg .= validation_errors();
		}

		if($msg != "")
		{
            jsonEcho(FALSE);
		}

        $captchaCode = $this->input->post('captcha_code');
        $this->load->library('captcha',$this->_getCaptchaConfig());

        //保留页面验证码验证，防止伪造表单绕开AJAX验证码验证提交
        if(!$this->captcha->check($captchaCode))
		{
            jsonEcho(FALSE);
		}

		$status = $this->Admin_model->checkUser(
		    strtolower($this->input->post("username")),
            $this->input->post("password")
        );

		if($status)
		{
            //如果账号登录成功，删除锁屏状态
		    $this->session->unset_userdata('isAdminLockScreen');
            jsonEcho(TRUE);
		}
		else
		{
            jsonEcho(FALSE);
		}
	}

    /**
     * 检查验证码
     */
    function checkCaptchaIsRight()
    {
        $captchaCode = $this->input->post('captcha_code');
        $this->load->library('captcha',$this->_getCaptchaConfig());

        if(!$this->captcha->check($captchaCode))
		{
            jsonEcho(FALSE);
		}
		else
        {
            jsonEcho(TRUE);
        }
    }

    /**
     * 退出登录
     */
    function logout()
	{
		$session_data=array(
			'admin_id'=>'',
			'admin_username'=>'',
            'admin_surname'=>'',
			'admin_last_login_time'=>'',
			'admin_login_ip'=>'',
			'admin_role_id'=>'',
			'admin_hits'=>'',
            'admin_action_list' => '',
            'isAdminLockScreen' => '',
		);
        
		$this->session->unset_userdata($session_data);
		redirect(BACKEND_DIR_NAME.'/login');
	}

    /**
     * 屏锁
     */
    function lock()
    {
        $adminId = $this->session->userdata('admin_id');

        if(empty($adminId))
        {
            $this->session->unset_userdata('isAdminLockScreen');//清除锁屏状态
            redirect(BACKEND_DIR_NAME.'/login');
        }

        $this->session->set_userdata('isAdminLockScreen',true);

        //用户信息
        $userData = $this->Admin_model->getAdminItem(
            ['where' => ['id' => $adminId]]
        );

        $this->template->assign('userData' ,$userData);

        //验证错误初始化
        $validationErrors = '';

        if($this->input->post())
        {
            $this->form_validation->set_rules('password','管理员密码','required');

            if($this->form_validation->run()==FALSE)
    		{
    			$validationErrors = validation_errors();
    		}
    		else
            {
                $password = $this->input->post('password');

                //如果密码相同，就返回上一个页面
                if(md5(strtolower($userData['salt'].$password)) == $userData['password'])
                {
                    //清除锁屏状态
                    $this->session->unset_userdata('isAdminLockScreen');
                    $returnUrl = $this->input->get('returnUrl');//返回的地址

                    if($returnUrl)//如果存在之前的一个路径就返回这个路径否则返回主页
                    {
                       header("location:".$returnUrl);
                    }
                    else
                    {
                       redirect(BACKEND_DIR_NAME.'/main');
                    }
                }
                else
                {
                    $validationErrors = '密码错误';
                }
            }
            
        }

        $this->template->assign('validationErrors' ,$validationErrors);
        $this->template->display('lock.tpl');
    }

    /**
     * 获取验证码配置
     *
     * @return array
     */
    private function _getCaptchaConfig()
    {
        return $this->captchaConfig;
    }

    /**
     * 设置验证码配置
     */
    private function _setCaptchaConfig()
    {
        $this->captchaConfig = array(
            'seKey' => 'adminUserLoginVcode'
        );
    }
}
