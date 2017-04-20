<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Core_model extends Data_Model
{
    protected $database = 'default';

    /**
     * 按条件获取单条记录
     *
     * @param $table
     * @param array $params
     * @return array
     */
    function getItem($table, $params = [])
    {
        $data = [];

        if (empty($data))
        {
            $data = $this->_select(
                $this->database, 'first', $table, '', $params
            );
        }

        return $data;
    }

    /**
     * 按条件获取记录
     *
     * @param $table
     * @param $select
     * @param array $params
     * @return array
     */
    function getItems($table, $select, $params = [])
    {
        $data = [];

        if (empty($data))
        {
            $data = $this->_select(
                $this->database, 'lists', $table, $select, $params
            );
        }

        return $data;
    }

    /**
     * 获取总数
     *
     * @param $table
     * @param $params
     * @return mixed
     */
    function getTotals($table, $params)
    {
        $data = [];

        if (empty($data))
        {
            $data = $this->_totals($this->database, $table, $params);
        }

        return $data;
    }

    /**
     * 按条件获取多条记录并按键名索引
     *
     * @param $table
     * @param $indexKey
     * @param string $select
     * @param array $params
     * @return array
     */
    function getCates($table, $indexKey, $select = '', $params = [])
    {
        $data = [];

        if (empty($data))
        {
            $data = $this->_cates(
                $this->database, $table, $indexKey, $select, $params
            );
        }

        return $data;
    }

    /**
     * 按照键值返回目录树结构数据
     *
     * @param $table
     * @param $indexKey
     * @param $parentKey
     * @param string $select
     * @param array $params
     * @return array
     */
    function getCategory($table, $indexKey, $parentKey, $select = '', $params = [])
    {
        $data = [];

        if (empty($data))
        {
            $data = $this->_category(
                $this->database, $table, $indexKey, $parentKey, $select, $params
            );
        }
        return $data;
    }

    /**
     * 获取内容列表
     *
     * @param $table
     * @param $select
     * @param array $params
     * @param $path
     * @param int $page
     * @param int $offset
     * @return array
     */
    function getList($table, $select, $params = [], $path, $page = 1, $offset = 10)
    {
        $data = [];

        if (empty($data))
        {
            $total = $this->getTotals($table, $params);

            $this->load->library('pagination');
            $config['base_url']    = $path;
            $config['total_rows']  = $total;
            $config['per_page']    = $offset;
            $config['cur_page']    = $page;
            $config['num_links']   = 10;
            $config['page_static'] = !strchr($path, '?');
            $this->pagination->initialize($config);
            $data['multi'] = $this->pagination->create_links();

            $offset && $params['limit'] = array(
                $this->pagination->page_start, $this->pagination->per_page
            );
            $data['total'] = $total;
            $data['lists'] = $this->_select($this->database, 'lists', $table, $select, $params);
        }
        return $data;
    }

    /**
     * 单条数据插入
     *
     * @param $table
     * @param $data
     * @return bool|int
     */
    function insert($table, $data)
    {
        return $this->_insert($this->database, $table, $data);
    }

    /**
     * 批量插入数据
     * @param $table
     * @param $values
     * @return bool
     */
    function insert_batch($table, $values)
    {
        return $this->_insert_batch($this->database, $table, $values);
    }

    /**
     * 更新单条数据
     *
     * @param $table
     * @param $data
     * @param $where
     * @return bool
     */
    function update($table, $data, $where)
    {
        return $this->_update($this->database, $table, $data, $where);
    }

    /**
     * 更新多条数据
     *
     * @param $table
     * @param $data
     * @param $where
     * @return bool
     */
    function update_batch($table, $data, $where)
    {
        return $this->_update_batch($this->database, $table, $data, $where);
    }

    /**
     * 删除数据
     *
     * @param $table
     * @param $where
     * @return bool
     */
    function delete($table, $where)
    {
        return $this->_delete($this->database, $table, $where);
    }

    /**
     * truncate数据表
     * @param $table
     */
    public function truncate($table)
    {
        $this->_truncate($this->database, $table);
    }

    /**
     * The query is converted to a string of keys for the cache
     *
     * @param $params
     * @return string
     */
    function paramsToCacheKey($params)
    {
        $string = $params;
        if ($params && is_array($params))
        {
            foreach ($params as $key => $val)
            {
                if (is_array($val))
                {
                    ksort($val);
                    $params[$key] = $val;
                }
            }
            ksort($params);

            $string = json_encode($params, JSON_NUMERIC_CHECK);
        }

        return $string ? $string : '';
    }
}
