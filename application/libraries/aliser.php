<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * 适用于服务窗、卡券包、扫码支付、条码支付、声波支付、店铺管理、商品管理、广告管理、集分宝、口碑服务市场订购信息等功能
 * https://doc.open.alipay.com/doc2/detail?treeId=54&articleId=103419&docType=1
 */

class CI_aliser
{
    // HTTPS形式消息验证地址
    public $https_verify_url = 'https://mapi.alipay.com/gateway.do?service=notify_verify&';

    // HTTP形式消息验证地址
    public $http_verify_url = 'http://notify.alipay.com/trade/notify_query.do?';

    // 支付宝网关地址（新）
    protected $alipay_gateway = 'https://openapi.alipay.com/gateway.do';

    // 支付宝网关地址（开发）
    //protected $alipay_gateway = 'http://openapi.stable.dl.alipaydev.com/gateway.do';

    // 支付宝网关地址（测试）
    //protected $alipay_gateway = 'http://oepnapi.eco.dl.alipaydev.com/gateway.do';

    //返回数据格式
    protected $format = "json";

    //api版本
    protected $version = "1.0";

    //签名类型
    protected $signType = "RSA";

    protected $charset = 'GBK';

    public function __construct($config)
    {
        foreach ($config as $key => $val)
        {
            $val && $this->$key = $val;
        }
    }

    /**
     * 获取开发者公钥、私钥
     * 生成钥文件用以布署本地环境
     */
    public function getrsa()
    {
        // 本地环境使用已经生成的文件
        if (ENVIRONMENT == 'development')
        {
            $data['public_key'] = file_get_contents(FCPATH . 'data/public.pem');
            $data['private_key'] = file_get_contents(FCPATH . 'data/private.pem');
        }
        else
        {
            $config = array(
                "digest_alg" => "sha1",
                "private_key_bits" => 1024,
                "private_key_type" => OPENSSL_KEYTYPE_RSA,
                "encrypt_key" => false);

            $res = openssl_pkey_new($config);
            openssl_pkey_export($res, $privatekey, randStr(8), $config);
            $data['private_key'] = $privatekey;

            $publickey = openssl_pkey_get_details($res);
            $data['public_key'] = $publickey["key"];

            // 生成钥文件，用以本地布署
            file_put_contents(FCPATH . 'data/public.pem', $data['public_key']);
            file_put_contents(FCPATH . 'data/private.pem', $data['private_key']);
        }

        // 过滤公钥多余的换行、字符
        $data['public_key'] = $this->getKeyStr($data['public_key']);
        $data['private_key'] = $data['private_key']; // 保存原始数据
        return $data;
    }

    /**
     * 签名验证
     */
    public function rsaCheck($params)
    {
        $sign = $params['sign'];
        unset($params['sign']);

        $signContent = $this->getSignContent($params);

        // 支付宝公钥
        $pubKey = $this->getPublicKeySource($this->app_key);

        // 转换为openssl格式密钥，php5以后有区别
        $res = openssl_get_publickey($pubKey);

        // 调用openssl内置方法验签，返回bool值
        $result = (bool)openssl_verify($signContent, base64_decode($sign), $res);

        // 释放资源
        openssl_free_key($res);

        return $result;
    }

    /**
     * 网关验证
     */
    public function verifyGateway($is_sign_success)
    {
        $biz_content = $this->getRequest('biz_content');

        $xml = simplexml_load_string($biz_content);
        $EventType = (string )$xml->EventType;
        if ($EventType == 'verifygw')
        {
            if ($is_sign_success)
            {
                $response_xml = "<biz_content>" . $this->public_key . "</biz_content><success>true</success>";
            }
            else
            {
                $response_xml = "<biz_content>" . $this->public_key . "</biz_content><success>false</success><error_code>VERIFY_FAILED</error_code>";
            }
            return $this->sign_response($response_xml);
        }
    }

    /**
     * 返回数据
     */
    private function sign_response($bizContent, $charset = 'GBK')
    {
        $sign = $this->rsa_sign($bizContent);
        $response = "<?xml version=\"1.0\" encoding=\"$charset\"?><alipay><response>{$bizContent}</response><sign>{$sign}</sign><sign_type>RSA</sign_type></alipay>";
        return $response;
    }

    /**
     * 生成签名
     */
    private function rsa_sign($data)
    {
        $res = openssl_pkey_get_private($this->private_key);
        openssl_sign($data, $sign, $res);
        openssl_free_key($res);
        $sign = base64_encode($sign);
        return $sign;
    }

    /**
     * 按顺序要求处理签名数据
     */
    protected function getSignContent($params)
    {
        ksort($params);
        $stringToBeSigned = "";
        $i = 0;
        foreach ($params as $k => $v)
        {
            if (false === $this->checkEmpty($v) && "@" != substr($v, 0, 1))
            {
                if ($i == 0)
                {
                    $stringToBeSigned .= "$k" . "=" . "$v";
                }
                else
                {
                    $stringToBeSigned .= "&" . "$k" . "=" . "$v";
                }
                $i++;
            }
        }
        unset($k, $v);
        return $stringToBeSigned;
    }

    /**
     * 校验$value是否非空
     */
    protected function checkEmpty($value)
    {
        if (!isset($value))
            return true;
        if ($value === null)
            return true;
        if (trim($value) === "")
            return true;

        return false;
    }

    /**
     * 将公钥格式化为字符串
     */
    private function getKeyStr($content)
    {
        $content = str_replace(array(
            '-----BEGIN PUBLIC KEY-----',
            '-----END PUBLIC KEY-----',
            '-----BEGIN PRIVATE KEY-----',
            '-----END PRIVATE KEY-----'), '', $content);
        $content = str_replace("\n", '', $content);
        return $content;
    }

    /**
     * 将字符串公钥还原
     */
    private function getPublicKeySource($content)
    {
        $cons = "-----BEGIN PUBLIC KEY-----\n";
        for ($i = 0; $i < 256; $i++)
        {
            if (isset($content[$i]))
            {
                if ($i && $i % 64 == 0)
                    $cons .= "\n";
                $cons .= $content[$i];
            }
            else
            {
                break;
            }
        }
        $cons .= "\n-----END PUBLIC KEY-----";
        return $cons;
    }

    /**
     * 获取浏览器参数值
     */
    public function getRequest($key)
    {
        $request = null;
        if (isset($_GET[$key]) && !empty($_GET[$key]))
        {
            $request = $_GET[$key];
        }
        elseif (isset($_POST[$key]) && !empty($_POST[$key]))
        {
            $request = $_POST[$key];
        }
        elseif (isset($_REQUEST[$key]) && !empty($_REQUEST[$key]))
        {
            $request = $_REQUEST[$key];
        }
        return $request;
    }

    public function gatewayHttp($method, $authToken, $apiParams = array())
    {
        //组装系统参数
        $sysParams['app_id'] = $this->app_id;
        $sysParams['version'] = $this->version;
        $sysParams['format'] = $this->format;
        $sysParams['sign_type'] = $this->signType;
        $sysParams['method'] = $method;
        $sysParams['timestamp'] = date('Y-m-d H:i:s');
        $sysParams["auth_token"] = $authToken;

        // 生成签名
        $params = array_merge($sysParams, $apiParams);

        $signContent = $this->getSignContent($params);
        $sysParams['sign'] = $this->rsa_sign($signContent);

        //系统参数放入GET请求串
        $requestUrl = $this->alipay_gateway . "?";
        foreach ($sysParams as $sysParamKey => $sysParamValue)
        {
            $requestUrl .= "$sysParamKey=" . urlencode($sysParamValue) . "&";
        }
        $requestUrl = substr($requestUrl, 0, -1);

        // 请求支付宝接口，使用JSON格式
        $result = $this->sendPostRequst($requestUrl, $apiParams);

        $result = iconv("GB2312", "UTF-8//IGNORE", $result);
        $result = json_decode($result, true);

        if (isset($result['error_response']))
        {
            $result = array('error' => true, 'msg' => $result['error_response']['sub_msg']);
        }
        else
        {
            $result['error'] = false;
        }
        return $result;
    }

    private function sendPostRequst($url, $data)
    {
        $postdata = http_build_query($data);
        $opts = array('http' => array(
                'method' => 'POST',
                'header' => 'Content-type: application/x-www-form-urlencoded',
                'content' => $postdata));

        $context = stream_context_create($opts);
        $result = file_get_contents($url, false, $context);
        return $result;
    }

    /**
     * ************************************************
     * 支付宝服务窗方法
     * ************************************************
     */

    /**
     * 修改4S订单状态 alipay.eco.mycar.maintain.orderstatus.update
     * @author 超 2016.6.19
     * @param $param array 请求参数
     * order_no 订单号
     * order_status 单状态
     * industry_code 行业类目标识
     * ext_param 扩展参数
     */
    public function orderUpdate($param = array())
    {
        $params['biz_content'] = json_encode($param);
        $resp = $this->gatewayHttp('alipay.eco.mycar.maintain.orderstatus.update', '', $params);

        if ($resp['error'])
        {
            return $resp;
        }
        else
        {
            $result = $resp['alipay_eco_mycar_maintain_orderstatus_update_response'];
            if ($result['code'] != '10000')
            {
                $result['error'] = $result['code'];
            }
            else
            {
                $result['error'] = false;
            }
            return $result;
        }
    }
}
