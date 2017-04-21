<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Admin_role_model extends Core_model
{
    /**
     * @var string
     */
    public $_tableName = 'backend_admin_role';

    /**
     * Admin_role_model constructor.
     */
	function __construct()
	{
		parent::__construct();
	}

    /**
     * 根据条件获取某个角色数据
     *
     * @param array $params
     * @param string $keyWord
     * @return array
     */
    public function getRoleItem($params =[], $keyWord = '')
    {
        $result = $this->getItem($this->_tableName, $params);

        if (!empty($result) && !empty($keyWord) && isset($result[$keyWord]))
        {
            return $result[$keyWord];
        }
        else
        {
            return $result;
        }
    }

    /**
     * 根据条件获取多个角色数据，除了超级管理员
     *
     * @param array $params
     * @return array
     */
    public function getRoleItems($params =[])
    {
        $params['order_by'] = 'id ASC';
        // 超级管理员不允许显示
        $params['where']['id !='] = 1;

        $result = $this->getItems(
            $this->_tableName, '*', $params
        );

        return $result;
    }

    /**
     * 新增角色操作
     *
     * @param $insertData
     * @return bool
     */
    function insertRole($insertData)
	{
        // 判断权限名称或者CODE是否已存在
        $isExist = $this->getTotals(
            $this->_tableName,
            [
                'or_where' => [
                    'role_name' => $insertData['role_name'],
                    'role_code' => $insertData['role_code'],
                ]
            ]
        );

        if ($isExist > 0)
        {
            echoMsg(10017);
        }

	    $result = $this->insert($this->_tableName, $insertData);
        
		if(!empty($result))
		{
            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '添加角色：' . $insertData['role_name']
            );
			return TRUE;
		}
		else
		{
			return FALSE;
		}
	}

    /**
     * 修改角色操作
     *
     * @param $id
     * @param $updateData
     * @return bool
     */
    function updateRole($id, $updateData)
	{
        if($id == 1 && !checkIsAdmin())
        {
            echoMsg(10008);
        }

        // 判断权限名称或者CODE是否已存在
        $isExistSQL = "SELECT id FROM " . DBPREFIX . $this->_tableName .
            " WHERE `id` != {$id} AND" .
            " (role_code = '{$updateData['role_code']}' OR role_name = '{$updateData['role_name']}')";
        $isExist    = $this->db->query($isExistSQL)->num_rows();

        if ($isExist > 0)
        {
            echoMsg(10017);
        }

        $result = $this->update($this->_tableName, $updateData, ['id' => $id]);
  
        if($result > 0)
        {
            // 添加操作日志
            $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
            $this->Admin_log_model->setAdminLog(
                '修改角色：' . $updateData['role_name']
            );
            return TRUE;
        }
        else
        {
            return FALSE;
        }
		
	}


    /**
     * 删除角色操作
     *
     * @param $id
     * @return bool
     */
    function deleteRole($id)
    {
        $data   = $this->getRoleItem(['where' => ['id' => $id]]);
        $result = FALSE;

        if (!empty($data))
        {
            $result = $this->delete($this->_tableName, ['id' => $id]);

            if (!empty($result))
            {
                // 添加操作日志
                $this->load->model(BACKEND_MODEL_DIR_NAME . '/Admin_log_model');
                $this->Admin_log_model->setAdminLog(
                    '删除角色：'.$data['role_name']
                );
            }
        }

        return $result;
    } 

}