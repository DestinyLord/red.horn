<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Admin_log_model extends Core_model
{
    /**
     * @var string
     */
    public $_tableName = 'backend_admin_log';

    /**
     * Admin_log_model constructor.
     */
	function __construct()
	{
		parent::__construct();
	}

    /**
     * 增加后台管理员操作日志
     *
     * @param string $logInfo
     * @return bool|int
     */
	public function setAdminLog($logInfo = '')
    {
        $adminId = $this->session->userdata('admin_id');
        $ip      = $this->input->ip_address();
        $logTime = time();

        $data = [
            'user_id'    => $adminId,
            'log_info'   => $logInfo,
            'ip_address' => $ip,
            'log_time'   => $logTime,
        ];
        $result = $this->insert($this->_tableName, $data);

        return $result;
    }
}