<?php

if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * model for the database
 */

class Data_model extends CI_Model
{
    protected $_query;

    function __construct()
    {
        parent::__construct();
    }

    /**
     * @db string database
     * @table string table name
     * @data array
     */
    public function _insert($db, $table, $data)
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }
        $db = $this->load->database($db, TRUE);

        $insert = $db->insert($table, $data);

        $this->dblog($db);

        return $insert ? $db->insert_id() : 0;
    }

    /**
     * batch insert
     * @db string database
     * @table string table name
     * @field array table field name
     * @data array
     */
    public function _insert_batch($db, $table, $values)
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }
        $db = $this->load->database($db, TRUE);

        $result = $db->insert_batch($table, $values);

        $this->dblog($db);

        return $result;
    }

    /**
     * @db string database
     * @table string table name
     * @data array update data
     * @where array update condition
     */
    public function _update($db, $table, $data, $where)
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }

        $db = $this->load->database($db, TRUE);

        if (is_array($data))
        {
            $result = $db->update($table, $data, $where);
        }
        else
        {
            $result = $db->query("UPDATE `" . $db->dbprefix($table) . "` SET {$data} WHERE {$where}");
        }

        $this->dblog($db);

        return $result;
    }

    /**
     * @db string database
     * @table string table name
     * @data array update data
     * @where array update condition
     */
    public function _update_batch($db, $table, $values, $where)
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }

        $db     = $this->load->database($db, TRUE);
        $result = $db->update_batch($table, $values, $where);

        $this->dblog($db);

        return $result;
    }

    /**
     * @db string database
     * @table string table name
     * @where array delete condition
     */
    public function _delete($db, $table, $where)
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }

        $db     = $this->load->database($db, TRUE);
        $result = $db->delete($table, $where);

        $this->dblog($db);

        return $result;
    }

    /**
     * truncate table
     */
    public function _truncate($db, $table)
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }
        $db = $this->load->database($db, TRUE);
        $db->truncate($table);
    }

    /**
     * @func lists totals first
     */
    public function _select($db, $func, $table, $select = '', $params = array())
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }

        $db = $this->load->database($db, TRUE);

        // 初始化查询参数
        $params = $this->parseParams($params);

        $db->select($select, FALSE);

        $params['distinct'] && $db->distinct($params['distinct']);

        $params['where_in'] && $db->where_in($params['where_in'][0], $params['where_in'][1]);

        $params['where_not_in'] && $db->where_not_in($params['where_not_in'][0], $params['where_not_in'][1]);

        $params['where'] && $db->where($params['where']);

        $params['or_where'] && $db->or_where($params['or_where']);

        //改成支持多联表
        if (isset($params['join']) && count($params['join'], COUNT_RECURSIVE) > 3)
        {
            foreach ($params['join'] as $v)
            {
                $db->join($v['table'], $v['cond'], $v['type']);
            }
        }
        else
        {
            if (isset($params['join']))
            {
                $params['join'] && $db->join($params['join']['table'], $params['join']['cond'], $params['join']['type']);
            }
        }

        $params['order_by'] && $db->order_by($params['order_by']);

        $params['group_by'] && $db->group_by($params['group_by']);

        $params['limit'] && $db->limit($params['limit'][1], $params['limit'][0]);
        $this->_query = $db->get($table);

        //echo $func . ':' . $db->last_query() . "<br>";exit;

        $this->dblog($db);

        $funcName = '_' . $func;
        return $this->$funcName();
    }

    /**
     * select recorder for list
     */
    public function _lists()
    {
        if ($this->_query->num_rows())
        {
            return $this->_query->result_array();
        }
        else
        {
            return array();
        }
    }

    /**
     * select first recorder
     */
    public function _first()
    {
        if ($this->_query->num_rows())
        {
            return $this->_query->row_array();
        }
        else
        {
            return FALSE;
        }
    }

    /**
     * totals for select recorder condition
     */
    public function _totals($db, $table, $params)
    {
        if (empty($db) || empty($table))
        {
            return FALSE;
        }

        $db = $this->load->database($db, TRUE);

        // 初始化查询参数
        $params = $this->parseParams($params);

        $db->select('count(1) as totals');

        $params['distinct'] && $db->distinct($params['distinct']);

        $params['where_in'] && $db->where_in($params['where_in'][0], $params['where_in'][1]);

        $params['where_not_in'] && $db->where_not_in($params['where_not_in'][0], $params['where_not_in'][1]);

        $params['where'] && $db->where($params['where']);

        //$params['join'] && $db->join($params['join']['table'], $params['join']['cond'], $params['join']['type']);
        //改成支持多联表 alan改 2015.7.14
        if (isset($params['join']) && count($params['join'], COUNT_RECURSIVE) > 3)
        {
            foreach ($params['join'] as $v)
            {
                $db->join($v['table'], $v['cond'], $v['type']);
            }
        }
        else
            if (isset($params['join']))
            {
                $params['join'] && $db->join($params['join']['table'], $params['join']['cond'], $params['join']['type']);
            }

        $params['group_by'] && $db->group_by($params['group_by']);

        $result = $db->get($table)->row_array();

        $this->dblog($db);

        return $result['totals'];
    }

    /**
     * get cate lists
     * @table string table name
     * @key array key
     */
    public function _cates($db, $table, $indexKey, $select = '', $params = array())
    {
        $lists = $this->_select($db, 'lists', $table, $select, $params);
        $data = array();
        foreach ($lists as $item)
        {
            $data[$item[$indexKey]] = $item;
        }

        return $data;
    }

    /**
     * Gets two levels category data
     * key PRIMARY key cid or mid
     * Ord display order
     * @action string get delete
     * @table string class_table
     * @key PRIMARY
     * @parent int parent class cid
     * @return array
     */
    public function _category($db, $table, $indexKey, $prarentKey, $select = '', $params = array())
    {
        $data = array();
        $lists = $this->_select($db, 'lists', $table, $select, $params);
        foreach ($lists as $row)
        {
            if ($row[$prarentKey] == 0)
            {
                $row['child'] = array();
                // 子级
                foreach ($lists as $ch)
                {
                    if ($ch[$prarentKey] == $row[$indexKey])
                    {
                        $ch['child'] = array();

                        // 孙级
                        foreach ($lists as $son)
                        {
                            if ($son[$prarentKey] == $ch[$indexKey])
                            {
                                $ch['child'][$son[$indexKey]] = $son;
                            }
                        }

                        $row['child'][$ch[$indexKey]] = $ch;
                    }
                }

                $data[$row[$indexKey]] = $row;
            }
        }

        return $data;
    }

    /**
     * parse select  params
     */
    function parseParams($params)
    {
        $paramRange = array(
            'distinct',
            'where',
            'where_in',
            'where_not_in',
            'like',
            'join',
            'order_by',
            'group_by',
            'limit');

        foreach ($paramRange as $key)
        {
            if (isset($params[$key]) && $params[$key])
            {
                $data[$key] = $params[$key];
            }
            else
            {
                $data[$key] = '';
            }
        }

        return $data;
    }

    /**
     * mysql read and write log
     */
    function dblog($db)
    {
        if (ENVIRONMENT == 'development')
        {
            //file_put_contents(FCPATH . 'data/mysql_' . date('Y_m_d') . '.log', str_replace("\n", ' ', date('H:i:s') . "\t" . $db->last_query()) . "\n", FILE_APPEND);
        }
    }
}
