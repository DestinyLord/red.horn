<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
    <title><{$backendSiteTitle}></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <link href="<{$css_path}>bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="<{$css_path}>bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="<{$css_path}>font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="<{$css_path}>style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="<{$css_path}>style.css" rel="stylesheet" type="text/css"/>

	<link href="<{$css_path}>style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="<{$css_path}>default.css" rel="stylesheet" type="text/css" id="style_color"/>

	<link href="<{$css_path}>uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<{$css_path}>login.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->
</head>
<body class="login">

	<!-- BEGIN LOGO -->

	<div class="logo">

		<img src="media/image/logo-big.png" alt="" /> 

	</div>

	<!-- END LOGO -->

	<!-- BEGIN LOGIN -->

	<div class="content">

		<!-- BEGIN LOGIN FORM -->

		<form class="form-vertical login-form" action="index.html">

			<h3 class="form-title">Login to your account</h3>

			<div class="alert alert-error hide">

				<button class="close" data-dismiss="alert"></button>

				<span>Enter any username and password.</span>

			</div>

			<div class="control-group">

				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

				<label class="control-label visible-ie8 visible-ie9">Username</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-user"></i>

						<input class="m-wrap placeholder-no-fix" type="text" placeholder="Username" name="username"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">Password</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i>

						<input class="m-wrap placeholder-no-fix" type="password" placeholder="Password" name="password"/>

					</div>

				</div>

			</div>

			<div class="form-actions">

				<label class="checkbox">

				<input type="checkbox" name="remember" value="1"/> Remember me

				</label>

				<button type="submit" class="btn green pull-right">

				Login <i class="m-icon-swapright m-icon-white"></i>

				</button>            

			</div>

			<div class="forget-password">

				<h4>Forgot your password ?</h4>

				<p>

					no worries, click <a href="javascript:;" class="" id="forget-password">here</a>

					to reset your password.

				</p>

			</div>

			<div class="create-account">

				<p>

					Don't have an account yet ?&nbsp; 

					<a href="javascript:;" id="register-btn" class="">Create an account</a>

				</p>

			</div>

		</form>

		<!-- END LOGIN FORM -->        

		<!-- BEGIN FORGOT PASSWORD FORM -->

		<form class="form-vertical forget-form" action="index.html">

			<h3 class="">Forget Password ?</h3>

			<p>Enter your e-mail address below to reset your password.</p>

			<div class="control-group">

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-envelope"></i>

						<input class="m-wrap placeholder-no-fix" type="text" placeholder="Email" name="email" />

					</div>

				</div>

			</div>

			<div class="form-actions">

				<button type="button" id="back-btn" class="btn">

				<i class="m-icon-swapleft"></i> Back

				</button>

				<button type="submit" class="btn green pull-right">

				Submit <i class="m-icon-swapright m-icon-white"></i>

				</button>            

			</div>

		</form>

		<!-- END FORGOT PASSWORD FORM -->

		<!-- BEGIN REGISTRATION FORM -->

		<form class="form-vertical register-form" action="index.html">

			<h3 class="">Sign Up</h3>

			<p>Enter your account details below:</p>

			<div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">Username</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-user"></i>

						<input class="m-wrap placeholder-no-fix" type="text" placeholder="Username" name="username"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">Password</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i>

						<input class="m-wrap placeholder-no-fix" type="password" id="register_password" placeholder="Password" name="password"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">Re-type Your Password</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-ok"></i>

						<input class="m-wrap placeholder-no-fix" type="password" placeholder="Re-type Your Password" name="rpassword"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

				<label class="control-label visible-ie8 visible-ie9">Email</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-envelope"></i>

						<input class="m-wrap placeholder-no-fix" type="text" placeholder="Email" name="email"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<div class="controls">

					<label class="checkbox">

					<input type="checkbox" name="tnc"/> I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>

					</label>  

					<div id="register_tnc_error"></div>

				</div>

			</div>

			<div class="form-actions">

				<button id="register-back-btn" type="button" class="btn">

				<i class="m-icon-swapleft"></i>  Back

				</button>

				<button type="submit" id="register-submit-btn" class="btn green pull-right">

				Sign Up <i class="m-icon-swapright m-icon-white"></i>

				</button>            

			</div>

		</form>

		<!-- END REGISTRATION FORM -->

	</div>

	<!-- END LOGIN -->

	<!-- BEGIN COPYRIGHT -->

	<div class="copyright">

		2013 &copy; Metronic. Admin Dashboard Template.

	</div>

	<!-- END COPYRIGHT -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	<script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

	<script src="media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>

	<script src="media/js/excanvas.min.js"></script>

	<script src="media/js/respond.min.js"></script>  

	<![endif]-->   

	<script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="media/js/jquery.validate.min.js" type="text/javascript"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="media/js/app.js" type="text/javascript"></script>

	<script src="media/js/login.js" type="text/javascript"></script>      

	<!-- END PAGE LEVEL SCRIPTS --> 

	<script>

		jQuery(document).ready(function() {     

		  App.init();

		  Login.init();

		});

	</script>

	<!-- END JAVASCRIPTS -->

<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script>
</body>

<!-- END BODY -->
</html>

<!--<body onLoad="document.getElementById('user_name').focus()">
<table width="640" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="100" background="<?php echo BACKEND_IMAGES_URL;?>login_top.gif" style="padding-left:30px"><table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><span class="w20b">网站后台登陆管理</span></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="261" align="right" valign="top" style="padding:30px 30px 0px 0px; background-image:url(<?php echo BACKEND_IMAGES_URL;?>login_bg3.gif); background-repeat:no-repeat; background-position:top">
    <form name="loginform" id="loginform" method="post" action="<?php echo site_url(BACKEND_DIR_NAME.'/login/check_login')?>" onsubmit="return Validator.Validate(this,2)">
		<table width="270" border="0" cellpadding="0" cellspacing="0" class="b12">
          <tr>
            <td width="54" height="26" align="left">用户名：</td>
            <td width="216" height="26" align="left"><input name="username" type="text" class="userName box01" Id="user_name" size="25" dataType="Require" msg="用户名不能为空" /></td>
          </tr>
          <tr>
            <td height="26" align="left">密　码：</td>
            <td height="26" align="left"><input name="password" type="PassWord" class="PassWord box01" Id="password" size="25" dataType="Require" msg="密码不能为空"/></td>
          </tr>
          <tr>
            <td height="26" align="left">验证码：</td>
            <td height="26" align="left">
            <input name="captcha_code" type="text" class="box01" Id="validate_code"  maxlength="4" style="width:50px;height:16px;float:left;"  dataType="Require" msg="验证码不能为空"/> <img src="<?php echo site_url(BACKEND_DIR_NAME.'/login/getLoginCaptcha'); ?>" width="120" height="39" style="cursor:pointer;display:block;float:left;padding: 0 0 0 10px;" title="看不清楚？点击换下一张！" id="code" onclick="this.src+='/'" />
            </td>
          </tr>
          <tr>
            <td height="30" align="left">&nbsp;</td>
            <td height="26" align="left"><table width="130" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="68"><input type="submit" value="提 交" /></td>
                <td width="72" align="right"><input type="reset" value="重 置" /></td>
              </tr>
            </table>            </td>
          </tr>
    </table>
	  </form>
    </td>
  </tr>
</table>
</body>
</html>