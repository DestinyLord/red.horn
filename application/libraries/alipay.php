<?php

if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 适用于电脑端支付、手机端支付、冻结支付等功能
 */

class CI_alipay {
    // HTTPS形式消息验证地址
    var $https_verify_url = 'https://mapi.alipay.com/gateway.do?service=notify_verify&';

    // HTTP形式消息验证地址
    var $http_verify_url = 'http://notify.alipay.com/trade/notify_query.do?';

    // 支付宝网关地址（新）
    var $alipay_gateway_new = 'https://mapi.alipay.com/gateway.do?';

    var $alipay_config;

    function __construct($config) {
        $this->alipay_config = $config;
    }

    /**
     * 针对notify_url验证消息是否是支付宝发出的合法消息
     * @return 验证结果
     */
    function verifyNotify() {
        if (empty($_POST)) { //判断POST来的数组是否为空
            return false;
        } else {
            //生成签名结果
            $isSign = $this->getSignVeryfy($_POST, $_POST["sign"]);
            //获取支付宝远程服务器ATN结果（验证是否是支付宝发来的消息）
            $responseTxt = 'true';
            if (!empty($_POST["notify_id"])) {
                $responseTxt = $this->getResponse($_POST["notify_id"]);
            }

            //验证
            //$responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
            //isSign的结果不是true，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
            if (preg_match("/true$/i", $responseTxt) && $isSign) {
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * 针对return_url验证消息是否是支付宝发出的合法消息
     * @return 验证结果
     */
    function verifyReturn($GET) {
        if (empty($GET)) { //判断POST来的数组是否为空
            return false;
        } else {
            //生成签名结果
            $isSign = $this->getSignVeryfy($GET, $GET["sign"]);
            //获取支付宝远程服务器ATN结果（验证是否是支付宝发来的消息）
            $responseTxt = 'true';
            if (!empty($GET["notify_id"])) {
                $responseTxt = $this->getResponse($GET["notify_id"]);
            }

            //验证
            //$responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
            //isSign的结果不是true，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
            if (preg_match("/true$/i", $responseTxt) && $isSign) {
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * 获取返回时的签名验证结果
     * @param $para_temp 通知返回来的参数数组
     * @param $sign 返回的签名结果
     * @return 签名验证结果
     */
    function getSignVeryfy($para_temp, $sign) {
        //除去待签名参数数组中的空值和签名参数
        $para_filter = paraFilter($para_temp);

        //对待签名参数数组排序
        $para_sort = argSort($para_filter);

        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        $prestr = createLinkstring($para_sort);

        $isSgin = false;

        switch (strtoupper(trim($this->alipay_config['sign_type']))) {
            case "MD5":
                $isSgin = md5Verify($prestr, $sign, $this->alipay_config['key']);
                break;
            default:
                $isSgin = false;
        }

        return $isSgin;
    }

    /**
     * 获取远程服务器ATN结果,验证返回URL
     * @param $notify_id 通知校验ID
     * @return 服务器ATN结果
     * 验证结果集：
     * invalid命令参数不对 出现这个错误，请检测返回处理中partner和key是否为空
     * true 返回正确信息
     * false 请检查防火墙或者是服务器阻止端口问题以及验证时间是否超过一分钟
     */
    function getResponse($notify_id) {
        $transport = strtolower(trim($this->alipay_config['transport']));
        $partner = trim($this->alipay_config['partner']);
        $veryfy_url = '';
        if ($transport == 'https') {
            $veryfy_url = $this->https_verify_url;
        } else {
            $veryfy_url = $this->http_verify_url;
        }
        $veryfy_url = $veryfy_url . "partner=" . $partner . "&notify_id=" . $notify_id;
        $responseTxt = getHttpResponseGET($veryfy_url, $this->alipay_config['cacert']);

        return $responseTxt;
    }

    /**
     * 生成签名结果
     * @param $para_sort 已排序要签名的数组
     * return 签名结果字符串
     */
    function buildRequestMysign($para_sort) {
        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        $prestr = createLinkstring($para_sort);

        $mysign = "";
        switch (strtoupper(trim($this->alipay_config['sign_type']))) {
            case "MD5":
                $mysign = md5Sign($prestr, $this->alipay_config['key']);
                break;
            default:
                $mysign = "";
        }

        return $mysign;
    }

    /**
     * 生成要请求给支付宝的参数数组
     * @param $para_temp 请求前的参数数组
     * @return 要请求的参数数组
     */
    function buildRequestPara($para_temp) {
        //除去待签名参数数组中的空值和签名参数
        $para_filter = paraFilter($para_temp);

        //对待签名参数数组排序
        $para_sort = argSort($para_filter);

        //生成签名结果
        $mysign = $this->buildRequestMysign($para_sort);

        //签名结果与签名方式加入请求提交参数组中
        $para_sort['sign'] = $mysign;
        $para_sort['sign_type'] = strtoupper(trim($this->alipay_config['sign_type']));

        return $para_sort;
    }

    /**
     * 生成要请求给支付宝的参数数组
     * @param $para_temp 请求前的参数数组
     * @return 要请求的参数数组字符串
     */
    function buildRequestParaToString($para_temp) {
        //待请求参数数组
        $para = $this->buildRequestPara($para_temp);

        //把参数组中所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串，并对字符串做urlencode编码
        $request_data = createLinkstringUrlencode($para);

        return $request_data;
    }

    /**
     * 建立请求，以表单HTML形式构造（默认）
     * @param $para_temp 请求参数数组
     * @param $method 提交方式。两个值可选：post、get
     * @param $button_name 确认按钮显示文字
     * @return 提交表单HTML文本
     */
    function buildRequestForm($para_temp, $method, $button_name = '') {
        //待请求参数数组
        $para = $this->buildRequestPara($para_temp);

        $sHtml = "<form id='alipaysubmit' name='alipaysubmit' action='" . $this->alipay_gateway_new . "_input_charset=" . trim(strtolower($this->alipay_config['input_charset'])) . "' method='" . $method . "'>";
        while (list($key, $val) = each($para)) {
            $sHtml .= "<input type='hidden' name='" . $key . "' value='" . $val . "'/>";
        }

        if ($button_name) {
            $sHtml = $sHtml . "<input type='submit' value='" . $button_name . "'></form>";
        } else {
            $sHtml = $sHtml . "<script>document.forms['alipaysubmit'].submit();</script>";
        }
        return $sHtml;
    }
    
    /**
     * 建立请求，以表单HTML形式构造（默认）
     * @param $para_temp 请求参数数组
     * @param $method 提交方式。两个值可选：post、get
     * @param $button_name 确认按钮显示文字
     * @return 提交表单HTML文本
     */
    function buildRequestFormScan($para_temp, $method, $button_name = '') {
        //待请求参数数组
        $para = $this->buildRequestPara($para_temp);
        $query = '';
        while (list($key, $val) = each($para)) {
            $query .= $key . "=" . $val;
            $query .= "&";
        }
        $query = rtrim($query, "&");
        $sHtml = $this->alipay_gateway_new.$query;
        return $sHtml;
    }

    /**
     * 建立请求，以模拟远程HTTP的POST请求方式构造并获取支付宝的处理结果
     * @param $para_temp 请求参数数组
     * @return 支付宝处理结果
     */
    function buildRequestHttp($para_temp, $method = 'GET') {
        $sResult = '';

        //待请求参数数组字符串
        $request_data = $this->buildRequestPara($para_temp);

        //远程获取数据
        if ($method == 'GET') {
            $url = $this->alipay_gateway_new . http_build_query($request_data);
            $sResult = getHttpResponseGET($url);
        } else {

        }

        return $sResult;
    }

    /**
     * 建立请求，以模拟远程HTTP的POST请求方式构造并获取支付宝的处理结果，带文件上传功能
     * @param $para_temp 请求参数数组
     * @param $file_para_name 文件类型的参数名
     *
     * @param $file_name 文件完整绝对路径
     * @return 支付宝返回处理结果
     */
    function buildRequestHttpInFile($para_temp, $file_para_name, $file_name) {

        //待请求参数数组
        $para = $this->buildRequestPara($para_temp);
        $para[$file_para_name] = "@" . $file_name;

        //远程获取数据
        $sResult = getHttpResponsePOST($this->alipay_gateway_new, $this->alipay_config['cacert'], $para, trim(strtolower($this->alipay_config['input_charset'])));

        return $sResult;
    }

    /**
     * 用于防钓鱼，调用接口query_timestamp来获取时间戳的处理函数
     * 注意：该功能PHP5环境及以上支持，因此必须服务器、本地电脑中装有支持DOMDocument、SSL的PHP配置环境。建议本地调试时使用PHP开发软件
     * return 时间戳字符串
     */
    function query_timestamp() {
        $url = $this->alipay_gateway_new . "service=query_timestamp&partner=" . trim(strtolower($this->alipay_config['partner'])) . "&_input_charset=" . trim(strtolower($this->alipay_config['input_charset']));
        $encrypt_key = "";

        $doc = new DOMDocument();
        $doc->load($url);
        $itemEncrypt_key = $doc->getElementsByTagName("encrypt_key");
        $encrypt_key = $itemEncrypt_key->item(0)->nodeValue;

        return $encrypt_key;
    }

    /**
     * 支付宝解冻接口(返给用户)
     * @params 订单数据
    */
    function unfrezen($params){
        $apiparams = array(
            'service' => 'alipay.fund.auth.unfreeze',
            "partner" => trim($this->alipay_config['partner']),
            'amount' => moneyFormat(floatval($params['fee'])),
            'auth_no' => $params['auth_no'],
            'out_request_no' => $params['out_no'],
            'remark' => "解冻了" . moneyFormat(floatval($params['fee'])) . "元",
            "_input_charset" => strtolower($this->alipay_config['input_charset']));
        $api_result = $this->buildRequestHttp($apiparams);
        
        $p = xml_parser_create();
        xml_parse_into_struct($p, $api_result, $data, $index);
        xml_parser_free($p);
		
        foreach ($data as $row) {
            if ($row['tag'] == 'RESULT_CODE') {
                $result['SUCCESS'] = $row['value'];
            }
            if ($row['tag'] == 'RESULT_MESSAGE') {
                $result['RESULT_MESSAGE'] = $row['value'];
            }
        }

        if ($result['SUCCESS'] != 'SUCCESS') {
            return array('error' => true, 'msg' => $result['RESULT_MESSAGE']);
        }

        return array('error' => false, 'msg' => 'ok');
    }

    /**
     * 支付宝解冻接口(支付给商户)
     * @params 订单数据
    */
    function unfrezenTopay($params){
        $apiparams = array(
            'service' => 'alipay.acquire.createandpay',
            "partner" => trim($this->alipay_config['partner']),
            'buyer_id' => $params['buyer_id'],
            'amount' => moneyFormat(floatval($params['fee'])),
            'seller_email' => $params['seller_email'],//'657640113@qq.com'
            'auth_no' => $params['auth_no'],
            'out_trade_no' => $params['out_no'],
            'subject' => '冻结金额' . moneyFormat(floatval($params['fee'])) . '元转直接支付',
            'product_code' => 'FUND_TRADE_FAST_PAY',
            'total_fee' => moneyFormat(floatval($params['fee'])),
            "_input_charset" => strtolower($this->alipay_config['input_charset']));

        $api_result = $this->buildRequestHttp($apiparams);

        $p = xml_parser_create();
        xml_parse_into_struct($p, $api_result, $data, $index);
        xml_parser_free($p);

        file_put_contents(FCPATH . 'data/topay.log',date('Y-m-d H:i:s') . var_export($data,true) . FILE_APPEND);


        foreach ($data as $row) {
            if ($row['tag'] == 'RESULT_CODE') {
                $result['SUCCESS'] = $row['value'];
            }
            if ($row['tag'] == 'DETAIL_ERROR_DES') {
                $result['DETAIL_ERROR_DES'] = $row['value'];
            }
        }

        if ($result['SUCCESS'] != 'ORDER_SUCCESS_PAY_SUCCESS') {
            return array('error' => true, 'msg' => isset($result['DETAIL_ERROR_DES']) ? $result['DETAIL_ERROR_DES'] : '');
        }

        return array('error' => false, 'msg' => 'ok');
    }
}
