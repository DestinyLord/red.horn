<{if $infotype == 'yes'}>
    <{assign var='icon_src' $image_path|cat:"backend/infosuccess.gif"}>
<{elseif $infotype == 'no'}>
    <{assign var='icon_src' $image_path|cat:"backend/infoerror.gif"}>
<{elseif $infotype == 'msg'}>
    <{assign var='icon_src' $image_path|cat:"backend/infonotice.gif"}>
<{/if}>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'
'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>网站信息提示</title>
<style type='text/css'>
a {
	color: #555555;
}
#div_msg{
	font-size:14px;
    <{if $infotype=="no"}>
    color: #FF0000;
    <{else}>
    color:#006600;
    <{/if}>
	width:600px;
	height:auto;
	border:#999 1px solid;
	margin-top: 50px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
	padding-top: 20px;
	padding-right: 5px;
	padding-bottom: 20px;
	padding-left: 5px;
}
#div_msg .img_box{
	width:55px;
	height:50px;
	margin-left:20px;
	text-align:center;
	float:left;
}
#div_msg .div_ct{
	margin-left:10px;
	text-align:left;
	float:left;
}
#div_msg .div_ct ul{
	list-style:square;
}
.clear {clear: both;font-size: 0;line-height: 0;height: 0;}
</style>
</head>

<body>
    <div id='div_msg'>
        <div class='img_box'><img src='<{$icon_src}>'></div>
        <div class='div_ct'>
            <ul>
                <{$infos}>
                <div class="clear"></div>
            </ul>
            <p style="text-align:center">
             <span id="counter"></span>秒后,页面将跳转... <a href="<{$red_url}>">点击这里返回</a>
            </p>
        </div>
        <div class="clear"></div>
    </div>

</body>
</html>
<script language="javascript">
	var i=3;
	var clock=0;//3秒后跳转
	function redirect(){
		document.getElementById("counter").innerHTML=i;
		if(i<=clock) 
		{
			document.location.href='<{$red_url}>';
			return ;
		}
        i-=1;	
		setTimeout("redirect()",1000);
	}
	redirect();
</script>