<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

function check_admin_is_login()
{
    $CI = &get_instance();
    //var_dump($CI->session->userdata("cps_admin_id"));
    if (!$CI->session->userdata("admin_username"))
    {
        echo '<html>';
        echo '<head>';
        echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
        echo "<script charset=\"utf-8\">\n";
        echo "alert(\"登陆超时，或者您还没登陆！\");\n";
        echo "if(self==top) {\n";
        echo "	document.location.href=\"" . site_url(BACKEND_DIR_NAME . "/login") . "\";\n";
        echo "} else {\n";
        echo "top.document.location.href=\"" . site_url(BACKEND_DIR_NAME . "/login") . "\";\n";
        echo "}\n";
        echo "</script>\n";
        echo '</head>';
        echo '</html>';
        exit();
    }
    else
        if ($CI->session->userdata('isAdminLockScreen'))
        {
            redirect(BACKEND_DIR_NAME . '/login/lock');
        }
}

/**
 * 后台提示函数
 *
 * @param $msgCode
 * @param string $rdr
 * @param string $infotype
 */
function echoMsg($msgCode, $rdr = '', $infotype = 'no')
{
    if (empty($rdr))
    {
        if (isset($_SERVER['HTTP_REFERER']))
        {
            $rdr = $_SERVER['HTTP_REFERER'];
        }
        else
        {
            $rdr = "javascript:window.history.back();";
        }
    }

    $CI  = &get_instance();
    $msg = getMessage($msgCode);
    $CI->template->assign('infotype', $infotype);
    $CI->template->assign('infos', $msg);
    $CI->template->assign('red_url', $rdr);
    die($CI->template->fetch("backend/common/msg.tpl"));
}

/**
 * 获取提示信息内容
 *
 * @param $msgCode
 * @return string
 */
function getMessage($msgCode)
{
    $CI = &get_instance();
    $CI->load->config('message');
    $msg = $CI->config->item('msg');

    if (isset($msg[$msgCode]))
    {
        return $msg[$msgCode];
    }
    else
    {
        return $msgCode;
    }
}

/**
 * 上传函数
 *
 * @param $up_config
 * @return array
 */
function doUpload($up_config)
{
    if (is_array($up_config))
    {
        foreach ($up_config as $key => $value)
        {
            $$key = $value;
        }
    }
    else
    {
        return array('status' => false, 'upload_errors' => "<li>配置参数有误</li>");
    }
    $up_path = rtrim($up_path, '/');
    $up_path .= '/' . date("Ymd", time()) . '/';
    if (!file_exists($up_path))
    {
        @mkdir($up_path, 0744, true);
    }
    $config['upload_path'] = $up_path;
    $config['allowed_types'] = $suffix;
    $config['encrypt_name'] = true;
    $CI = &get_instance();
    $CI->load->library('upload');
    $CI->upload->initialize($config);

    if (!$CI->upload->doUpload($form_name))
    {
        if (isset($_FILES[$form_name]['name']) && !empty($_FILES[$form_name]['name']))
        {
            $file_data = array('status' => false, 'upload_errors' => $CI->upload->display_errors('<li>', '</li>'));
        }
        else
        {
            $file_data = array('status' => true, 'file_path' => '');
        }
        return $file_data;
    }
    else
    {
        $data = $CI->upload->data();
        $file_data = array('status' => true, 'file_path' => $up_path . $data['file_name']);
        return $file_data;
    }
}

/**
 * 字符串截取
 *
 * @param $string
 * @param $length
 * @param string $dot
 * @param string $charset
 * @return bool|string
 */
function strcut($string, $length, $dot = '…', $charset = 'utf-8')
{
    $strlen = strlen($string);
    if ($strlen <= $length)
        return $string;
    $strcut = '';
    if (strtolower($charset) == 'utf-8')
    {
        $n = $tn = $noc = 0;
        while ($n < $strlen)
        {
            $t = ord($string[$n]);
            if ($t == 9 || $t == 10 || (32 <= $t && $t <= 126))
            {
                $tn = 1;
                $n++;
                $noc++;
            }
            elseif (194 <= $t && $t <= 223)
            {
                $tn = 2;
                $n += 2;
                $noc += 2;
            }
            elseif (224 <= $t && $t <= 239)
            {
                $tn = 3;
                $n += 3;
                $noc += 3;
            }
            elseif (240 <= $t && $t <= 247)
            {
                $tn = 4;
                $n += 4;
                $noc += 4;
            }
            elseif (248 <= $t && $t <= 251)
            {
                $tn = 5;
                $n += 5;
                $noc += 5;
            }
            elseif ($t == 252 || $t == 253)
            {
                $tn = 6;
                $n += 6;
                $noc += 6;
            }
            else
            {
                $n++;
            }
            if ($noc >= $length)
                break;
        }
        if ($noc > $length)
            $n -= $tn;
        $strcut = substr($string, 0, $n);
    }
    else
    {
        $dotlen = strlen($dot);
        $maxi = $length - $dotlen - 1;
        for ($i = 0; $i < $maxi; $i++)
        {
            $strcut .= ord($string[$i]) > 127 ? $string[$i] . $string[++$i] : $string[$i];
        }
    }
    return $strcut;
}

/**
 * 获取用户真实 IP
 */
function getIP()
{
    static $realip;

    if (isset($_SERVER) && empty($realip))
    {
        if (isset($_SERVER["HTTP_X_FORWARDED_FOR"]))
        {
            $realip = $_SERVER["HTTP_X_FORWARDED_FOR"];
        }
        else
            if (isset($_SERVER["HTTP_CLIENT_IP"]))
            {
                $realip = $_SERVER["HTTP_CLIENT_IP"];
            }
            else
            {
                $realip = $_SERVER["REMOTE_ADDR"];
            }
    }
    else
    {
        if (getenv("HTTP_X_FORWARDED_FOR"))
        {
            $realip = getenv("HTTP_X_FORWARDED_FOR");
        }
        else
            if (getenv("HTTP_CLIENT_IP"))
            {
                $realip = getenv("HTTP_CLIENT_IP");
            }
            else
            {
                $realip = getenv("REMOTE_ADDR");
            }
    }
    return $realip;
}

/**
 * 判断管理员对某一个操作是否有权限
 *
 * @param $privStr
 * @return bool
 */
function check_priv($privStr)
{
    $CI = &get_instance();
    if (trim($CI->session->userdata('admin_action_list'), ',') == 'all')
    {
        return true;
    }

    if (strpos(',' . $CI->session->userdata('admin_action_list') . ',', ',' . $privStr . ',') === false)
    {
        return false;
    }
    else
    {
        return true;
    }
}

/**
 * 检查管理员权限
 *
 * @access  public
 * @param   string  $authz
 * @return  boolean
 */
function checkAuthz($authz)
{
    return (preg_match('/,*' . $authz . ',*/', $_SESSION['admin_action_list']) || $_SESSION['admin_action_list'] == 'all');
}

/**
 * 检查是否是管理员
 *
 * @return bool
 */
function checkIsAdmin()
{
    $CI = &get_instance();
    if (trim($CI->session->userdata('admin_action_list'), ',') == 'all')
    {
        return true;
    }
    else
    {
        return false;
    }
}


/**
 * 如果不存在权限，跳转地址回上一步
 *
 * @param $actionCode
 */
function noPrivShowMsg($actionCode)
{
    if (!check_priv($actionCode))
    {
        echoMsg(10009);
    }
}

/**
 * 获取用户的所有的权限信息
 *
 * @param $actionList
 * @return bool
 */
function getAdminUserActionInfo($actionList)
{
    $actionArr = explode(',', trim($actionList, ','));
    $CI = &get_instance();

    $CI->db->from('admin_action');
    $CI->db->where_in('action_code', $actionArr);
    $query = $CI->db->get();
    if ($query->num_rows() > 0)
    {
        return $query->result_array();
    }
    else
    {
        return false;
    }
}

/**
 * 获取后台位置
 *
 * @param $breadCrumbsArr
 * @param string $homeDirName
 * @return string
 */
function getBackendBreadCrumbs($breadCrumbsArr, $homeDirName = BACKEND_DIR_NAME)
{
    if ($homeDirName == BACKEND_DIR_NAME) //因为前面没主页，所以区分
    {
        $breadCrumbs = '<ul class="breadcrumb">
                    <li>
            
        				<i class="icon-home"></i>
        
        				<a href="' . site_url($homeDirName . '/main') . '">主页</a> 
        
        				<i class="icon-angle-right"></i>
        
        			</li>
        ';
    }
    else
    {
        $breadCrumbs = '<ul class="breadcrumb">';
    }
    $i = 1;
    $count = count($breadCrumbsArr);
    foreach ($breadCrumbsArr as $key => $row)
    {
        if (is_numeric($key) || $key == '#')
        {
            $menuUrl = '#';
        }
        else
            if (empty($key))
            {
                $menuUrl = current_url();
            }
            else
            {
                $menuUrl = site_url($homeDirName . '/' . $key);
            }
            $breadCrumbs .= '<li>
    
    				<a href="' . $menuUrl . '">' . $row . '</a>
                ';
        if ($i != $count)
        {
            $breadCrumbs .= '<i class="icon-angle-right"></i>';
        }
        $breadCrumbs .= '</li>';
        $i++;
    }

    $breadCrumbs .= '</ul>';

    return $breadCrumbs;
}

/**
 * 数据传输
 *
 * @param $url
 * @param $data
 * @return mixed
 */
function doPost($url, $data)
{
    if (empty($data))
        $data = array();
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
    curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // 模拟用户使用的浏览器
    curl_setopt($ch, CURLOPT_ENCODING, 'gzip,deflate');
    curl_setopt($ch, CURLOPT_URL, $url);
    $ret = curl_exec($ch);
    curl_close($ch);
    return $ret;
}

/**
 * 数组过滤空值
 * @param $arr
 * @return bool|array
 */
function unsetEmptyValueByArray($arr)
{
    if (!is_array($arr))
    {
        return false;
    }

    foreach ($arr as $key => $value)
    {
        if (empty($value) && $value !== 0 && $value != '0')
        {
            unset($arr[$key]);
        }
    }

    return $arr;
}

/**
 * 生成二维码
 *
 * @param $url
 * @param string $dirName
 * @param string $fileName
 * @return string
 */
function createQRcode($url, $dirName = '', $fileName = '')
{
    $CI = &get_instance();
    $CI->load->library('qrcode');

    $filePath = 'uploads/images/QRCode';
    if (!empty($dirName))
    {
        $filePath .= '/' . $dirName;
    }

    if (!file_exists($filePath))
    {
        mkdir($filePath, 0755, true);
    }

    if (empty($fileName))
    {
        $fileName = md5(time() + rand(999));
    }

    $filePath .= '/' . $fileName . '.png';


    QRcode::png($url, $filePath, 'L', 6);

    return $filePath;
}

/**
 * 人民币分转换元、万元格式
 *
 * @param $money
 * @param int $type
 * @param int $unit
 * @return float|string
 */
function moneyFormat($money, $type = 0, $unit = 1)
{
    switch ($unit)
    {
        case 1: //元
            $rate = 100;
            break;
        case 2: // 万元
            $rate = 1000000;
            break;
    }

    if (empty($rate))
    {
        return 0;
    }

    if ($type)
    { // 元转分
        return round($money * $rate, 2);
    }
    else
    {
        $moneys = round((int)$money / $rate, 2);
        if ($unit == 1)
        {
            $moneys = number_format($moneys, 2, '.', false);
        }

        return $moneys;
    }
}

/**
 * @param $string
 * @return mixed
 */
function unserialized($string)
{
    return @unserialize(preg_replace('!s:(\d+):"(.*?)";!se', "'s:'.strlen('$2').':\"$2\";'", $string));
}

/**
 * Send string and Exit
 *
 * @param string $msg
 */
function dexit($msg = '')
{
    echo is_array($msg) ? json_encode($msg) : $msg;
    exit();
}

/**
 * 获取首字母
 *
 * @param $s0
 * @return null|string
 */
function getFirstChar($s0)
{
    $fchar = ord($s0{0});
    if ($fchar >= ord("A") and $fchar <= ord("z"))
        return strtoupper($s0{0});
    $s1 = iconv("UTF-8", "gb2312", $s0);
    $s2 = iconv("gb2312", "UTF-8", $s1);
    if ($s2 == $s0)
    {
        $s = $s1;
    }
    else
    {
        $s = $s0;
    }
    $asc = ord($s{0}) * 256 + ord($s{1}) - 65536;
    if ($asc >= -20319 and $asc <= -20284)
        return "A";
    if ($asc >= -20283 and $asc <= -19776)
        return "B";
    if ($asc >= -19775 and $asc <= -19219)
        return "C";
    if ($asc >= -19218 and $asc <= -18711)
        return "D";
    if ($asc >= -18710 and $asc <= -18527)
        return "E";
    if ($asc >= -18526 and $asc <= -18240)
        return "F";
    if ($asc >= -18239 and $asc <= -17923)
        return "G";
    if ($asc >= -17922 and $asc <= -17418)
        return "H";
    if ($asc >= -17417 and $asc <= -16475)
        return "J";
    if ($asc >= -16474 and $asc <= -16213)
        return "K";
    if ($asc >= -16212 and $asc <= -15641)
        return "L";
    if ($asc >= -15640 and $asc <= -15166)
        return "M";
    if ($asc >= -15165 and $asc <= -14923)
        return "N";
    if ($asc >= -14922 and $asc <= -14915)
        return "O";
    if ($asc >= -14914 and $asc <= -14631)
        return "P";
    if ($asc >= -14630 and $asc <= -14150)
        return "Q";
    if ($asc >= -14149 and $asc <= -14091)
        return "R";
    if ($asc >= -14090 and $asc <= -13319)
        return "S";
    if ($asc >= -13318 and $asc <= -12839)
        return "T";
    if ($asc >= -12838 and $asc <= -12557)
        return "W";
    if ($asc >= -12556 and $asc <= -11848)
        return "X";
    if ($asc >= -11847 and $asc <= -11056)
        return "Y";
    if ($asc >= -11055 and $asc <= -10247)
        return "Z";
    return null;
}

/**
 * 模拟登录网页
 *
 * @param $url
 * @param string $method
 * @param array $params
 * @param bool $multi
 * @param array $extheaders
 * @param bool $isjson
 * @param bool $https
 * @return array|mixed
 */
function http($url, $method = 'GET', $params = array(), $multi = false, $extheaders = array(), $isjson = false, $https = false)
{
    if (!function_exists('curl_init'))
        exit('Need to open the curl extension');
    $method = strtoupper($method);
    $ci = curl_init();
    curl_setopt($ci, CURLOPT_USERAGENT, 'PHP-SDK OAuth2.0');
    curl_setopt($ci, CURLOPT_CONNECTTIMEOUT, 3);
    curl_setopt($ci, CURLOPT_TIMEOUT, 30);
    curl_setopt($ci, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ci, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ci, CURLOPT_HEADER, false);
    curl_setopt($ci, CURLOPT_FOLLOWLOCATION, 1);
    if ($https)
    {
        curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ci, CURLOPT_SSL_VERIFYHOST, false);
    }
    $headers = (array )$extheaders;
    switch ($method)
    {
        case 'POST':
            curl_setopt($ci, CURLOPT_POST, true);
            if (!empty($params))
            {
                if ($multi)
                {
                    $multi = (array)$multi;

                    foreach ($multi as $key => $file)
                    {
                        $params[$key] = '@' . $file;
                    }
                    curl_setopt($ci, CURLOPT_POSTFIELDS, $params);
                    $headers[] = 'Expect: ';
                } else
                {
                    curl_setopt($ci, CURLOPT_POSTFIELDS, $isjson ? json_encode($params) : http_build_query($params));
                }
            }
            break;
        case 'DELETE':
        case 'GET':
            $method == 'DELETE' && curl_setopt($ci, CURLOPT_CUSTOMREQUEST, 'DELETE');
            if (!empty($params))
            {
                $url = $url . (strpos($url, '?') ? '&' : '?') . (is_array($params) ? http_build_query($params) : $params);
            }
            break;
    }
    curl_setopt($ci, CURLINFO_HEADER_OUT, true);
    curl_setopt($ci, CURLOPT_URL, $url);
    if ($headers)
    {
        curl_setopt($ci, CURLOPT_HTTPHEADER, $headers);
    }

    $response = curl_exec($ci);

    $curl_info = curl_getinfo($ci);

    if (isset($curl_info['redirect_url']) && $curl_info['redirect_url'])
    {
        $response = array('error' => true, 'redirect_url' => $curl_info['redirect_url']);
    }

    curl_close($ci);

    return $response;
}

/**
 * json_encode输出
 *
 * @param $value
 */
function jsonEcho($value)
{
    echo json_encode($value);
    exit;
}

/**
 * 递归获取数组，类树结构排序
 *
 * @param $data
 * @param $pid
 * @param $result
 */
function getTreeData($data, $pid, &$result)
{
    array_map(function($item) use (&$result, $pid, $data)
    {
        if ($item['parent_id'] == $pid)
        {
            $result[] = $item;

            if(!empty($item['has_child']))
            {
                getTreeData($data, $item['id'], $result);
            }
        }
    }, $data);
}
