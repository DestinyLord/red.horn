<?php  
/** 
 * 安全验证码 
 *  
 * 安全的验证码要：验证码文字扭曲、旋转，使用不同字体，添加干扰码。 
 * 如果用中文做验证码(我这里不是哦，有兴趣你来改成用中文的)，安全度会更好些，但验证码扭曲和旋转是王道，用了字体也算是已经给字体扭曲了，我就不再去给他添一只扭曲的足了。 
 * 可配置的属性都是一些简单直观的变量，我就不用弄一堆的setter/getter了 
 * 
 * @author Alan 改自 （流水孟春 <cmpan(at)qq.com>） 
 * @copyright NEW BSD 
 * @link http://labs.yulans.cn/YL_Security_Secoder 
 * @link http://wiki.yulans.cn/docs/yl/security/secoder 
 */  
class Captcha{  
    /** 
     * 验证码的session的下标 
     *  
     * @var string 
     */  
    public $seKey;  
    public $expire;     // 验证码过期时间（s）  
    /** 
     * 验证码中使用的字符，01IO容易混淆，建议不用 
     * 
     * @var string 
     */  
    public $codeSet;  
    public $fontSize;     // 验证码字体大小(px)  
    public $useCurve;   // 是否画混淆曲线  
    public $useNoise;   // 是否添加杂点   
    public $imageH;        // 验证码图片宽  
    public $imageL;        // 验证码图片长  
    public $length;        // 验证码位数  
    public $bg;  // 背景  
      
    public $_image;     // 验证码图片实例  
    public $_color;     // 验证码字体颜色  
    
    
    function __construct($config)
    {
        $this->seKey = 'loginVcode';  
        $this->expire = 3000;     // 验证码过期时间（s）  
        $this->codeSet = '346789ABCDEFGHJKLMNPQRTUVWXY';  
        $this->fontSize = 25;     // 验证码字体大小(px)  
        $this->useCurve = true;   // 是否画混淆曲线  
        $this->useNoise = true;   // 是否添加杂点   
        $this->imageH = 0;        // 验证码图片宽  
        $this->imageL = 0;        // 验证码图片长  
        $this->length = 4;        // 验证码位数  
        $this->bg = array(243, 251, 254);  // 背景  
          
        $this->_image = null;     // 验证码图片实例  
        $this->_color = null;     // 验证码字体颜色 
        
        if(is_array($config))
		{
			foreach($config as $key => $value)
			{
				if (isset($this->$key))
				{
					$this->$key = $value;
				}
			}
		}
    }  
    /** 
     * 输出验证码并把验证码的值保存的session中 
     * 验证码保存到session的格式为： $_SESSION[self::$seKey] = array('code' => '验证码值', 'time' => '验证码创建时间'); 
     */  
    public function entry() {   
        // 图片宽(px)   
        $this->imageL || $this->imageL = $this->length * $this->fontSize * 1.5 + $this->fontSize*1.5;  
        // 图片高(px)   
        $this->imageH || $this->imageH = $this->fontSize * 2;            
        // 建立一幅 self::$imageL x self::$imageH 的图像   
        $this->_image = imagecreate($this->imageL, $this->imageH);     
        // 设置背景         
        imagecolorallocate($this->_image, $this->bg[0], $this->bg[1], $this->bg[2]);    
        // 验证码字体随机颜色   
        $this->_color = imagecolorallocate($this->_image, mt_rand(1,120), mt_rand(1,120), mt_rand(1,120));   
        // 验证码使用随机字体，保证目录下有这些字体集
        $ttf = dirname(__FILE__) . '/ttfs/t' . mt_rand(1, 9) . '.ttf';//多字体
        if ($this->useNoise) {   
            // 绘杂点   
            $this->_writeNoise();   
        }    
        if ($this->useCurve) {   
            // 绘干扰线   
            $this->_writeCurve();   
        }   
           
        // 绘验证码   
        $code = array(); // 验证码   
        $codeNX = 0; // 验证码第N个字符的左边距   
        for ($i = 0; $i<$this->length; $i++) {   
            $code[$i] = $this->codeSet[mt_rand(0, 27)];   
            $codeNX += mt_rand($this->fontSize*1.2, $this->fontSize*1.6);   
            // 写一个验证码字符   
            imagettftext($this->_image, $this->fontSize, mt_rand(-40, 70), $codeNX, $this->fontSize*1.5, $this->_color, $ttf, $code[$i]);   
        }   
        // 保存验证码   
        //isset($_SESSION) || session_start(); 
        $CI =& get_instance();
        $session_array = array(
                'code'  => implode('', $code),
                'time'  => time()
        );
        $CI->session->set_userdata($this->seKey,$session_array); 
        header('Pragma: no-cache');        
        header("content-type: image/JPEG");   
       
        // 输出图像   
        imageJPEG($this->_image);    
        imagedestroy($this->_image);   
    }
      
    /**   
     * 画一条由两条连在一起构成的随机正弦函数曲线作干扰线(你可以改成更帅的曲线函数)   
     *      正弦型函数解析式：y=Asin(ωx+φ)+b  
     *      各常数值对函数图像的影响：  
     *        A：决定峰值（即纵向拉伸压缩的倍数）  
     *        b：表示波形在Y轴的位置关系或纵向移动距离（上加下减）  
     *        φ：决定波形与X轴位置关系或横向移动距离（左加右减）  
     *        ω：决定周期（最小正周期T=2π/∣ω∣）  
     */  
    public function _writeCurve() {   
        $A = mt_rand(1, $this->imageH/2);                  // 振幅   
        $b = mt_rand(-$this->imageH/4, $this->imageH/4);   // Y轴方向偏移量   
        $f = mt_rand(-$this->imageH/4, $this->imageH/4);   // X轴方向偏移量   
        $T = mt_rand($this->imageH*1.5, $this->imageL*2);  // 周期   
        $w = (2* M_PI)/$T;   
                           
        $px1 = 0;  // 曲线横坐标起始位置   
        $px2 = mt_rand($this->imageL/2, $this->imageL * 0.667);  // 曲线横坐标结束位置              
        for ($px=$px1; $px<=$px2; $px=$px+ 0.9) {   
            if ($w!=0) {   
                $py = $A * sin($w*$px + $f)+ $b + $this->imageH/2;  // y = Asin(ωx+φ) + b   
                $i = (int) (($this->fontSize - 6)/4);   
                while ($i > 0) {    
                    imagesetpixel($this->_image, $px + $i, $py + $i, $this->_color);  
					//这里画像素点比imagettftext和imagestring性能要好很多                     
                    $i--;   
                }   
            }   
        }   
           
        $A = mt_rand(1, $this->imageH/2);                  // 振幅           
        $f = mt_rand(-$this->imageH/4, $this->imageH/4);   // X轴方向偏移量   
        $T = mt_rand($this->imageH*1.5, $this->imageL*2);  // 周期   
        $w = (2* M_PI)/$T;         
        $b = $py - $A * sin($w*$px + $f) - $this->imageH/2;   
        $px1 = $px2;   
        $px2 = $this->imageL;   
        for ($px=$px1; $px<=$px2; $px=$px+ 0.9) {   
            if ($w!=0) {   
                $py = $A * sin($w*$px + $f)+ $b + $this->imageH/2;  // y = Asin(ωx+φ) + b   
                $i = (int) (($this->fontSize - 8)/4);   
                while ($i > 0) {            
                    imagesetpixel($this->_image, $px + $i, $py + $i, $this->_color); 
					//这里(while)循环画像素点比imagettftext和imagestring用字体大小一次画出
					//的（不用while循环）性能要好很多       
                    $i--;   
                }   
            }   
        }   
    }   
       
    /**  
     * 画杂点  
     * 往图片上写不同颜色的字母或数字  
     */  
    public function _writeNoise() {   
        for($i = 0; $i < 10; $i++){   
            //杂点颜色   
            $noiseColor = imagecolorallocate(   
                              $this->_image,    
                              mt_rand(150,225),    
                              mt_rand(150,225),    
                              mt_rand(150,225)   
                          );   
            for($j = 0; $j < 5; $j++) {   
                // 绘杂点   
                imagestring(   
                    $this->_image,   
                    5,    
                    mt_rand(-10, $this->imageL),    
                    mt_rand(-10, $this->imageH),    
                    $this->codeSet[mt_rand(0, 27)], // 杂点文本为随机的字母或数字   
                    $noiseColor  
                );   
            }   
        }   
    }
      
    /** 
     * 验证验证码是否正确 
     * 
     * @param string $code 用户验证码 
     * @return bool 用户验证码是否正确 
     */  
    public function check($code) {
        $CI =& get_instance();
        $captcha = $CI->session->userdata($this->seKey); 
        // 验证码不能为空  
        if(empty($code) || empty($captcha)) { 
            return false;  
        }  
        // session 过期  
        if(time() - $captcha['time'] > $this->expire) {  
            unset($captcha);
            return false;  
        }  
        
        if(strtolower($code) == strtolower($captcha['code'])) { 
            return true;  
        } 
        return false;  
    }  
}  
  
  
// useage  
/* 
YL_Security_Secoder::$useNoise = false;  // 要更安全的话改成true 
YL_Security_Secoder::$useCurve = true; 
YL_Security_Secoder::entry(); 
*/  
  
/* 
// 验证验证码 
if (!YL_Security_Secoder::check(@$_POST['secode'])) { 
    print 'error secode'; 
} 
*/  