<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->
<head>
    <{include file= $backendViewDir|cat:'/common/head.tpl'}>

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<{$css_path}>login.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->
</head>
<!-- END HEAD -->
<body class="login" onload="document.getElementById('username').focus()">

	<!-- BEGIN LOGO -->

	<div class="logo">

		<img src="<{$image_path}>logo.png" alt="" /> 

	</div>

	<!-- END LOGO -->

	<!-- BEGIN LOGIN -->

	<div class="content">

		<!-- BEGIN LOGIN FORM -->

		<form class="form-vertical login-form" action="<{site_url uri=$backendDir|cat:'/login/checkLogin'}>" method="post">

			<h3 class="form-title">登录</h3>
            <div class="clearfix bs-example error-info-box">
    			<div class="alert alert-error hide">
    
    				<button class="close" data-dismiss="alert"></button>
    
    				<span>请填写正确的用户名和密码</span>
    
    			</div>
            </div>
            
            <div class="clearfix bs-example login-loding-box">
    			<div class="alert alert-success hide">
    
    				<span>正在登录中...</span>
    
    			</div>
            </div>

			<div class="control-group">

				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

				<label class="control-label visible-ie8 visible-ie9">Username</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-user"></i>

						<input id="username" class="m-wrap placeholder-no-fix" type="text" placeholder="用户名" name="username"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">Password</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i>

						<input class="m-wrap placeholder-no-fix" type="password" placeholder="密码" name="password"/>

					</div>

				</div>

			</div>
            
            <div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">captcha_code</label>

				<div class="controls">

					<div class="input-icon left" style="width:291px;">
                        <div class="pull-left" style="margin:0 !important;width:40%;">
						<i class="icon-check"></i>

						<input class="m-wrap placeholder-no-fix" style="width:80px" style="" type="text" placeholder="验证码" name="captcha_code" maxlength="4"/>
                        </div>
                        <div class="pull-left" style="width:50%">
                            <img src="<{site_url uri=$backendDir|cat:'/login/getLoginCaptcha'}>" width="120" class="small" style="cursor:pointer;float:left;padding: 0 0 0 10px;" title="看不清楚？点击换下一张！" id="code" onclick="this.src+='/'" />
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>

			</div>

			<div class="form-actions">

				<label class="checkbox">

				<input type="checkbox" name="remember" value="1"/> 记住密码

				</label>

				<button type="submit" class="btn green pull-right">

				登录 <i class="m-icon-swapright m-icon-white"></i>

				</button>            

			</div>
            <!--
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

			</div>-->

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

		

	</div>

	<!-- END COPYRIGHT -->
    
    <{include file=$backendViewDir|cat:'/common/foot.tpl'}>

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="<{$js_path}>jquery.validate.min.js" type="text/javascript"></script>
    <script src="<{$js_path}>jquery.validate.messages_zh.js" type="text/javascript"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>app.js" type="text/javascript"></script>

	<script src="<{$js_path}>backend_login.js" type="text/javascript"></script>      

	<!-- END PAGE LEVEL SCRIPTS --> 
    <script type="text/javascript">
        //定义验证码AJAX验证路径 
        var captchaValidatePath = '<{site_url uri=$backendDir|cat:'/login/checkCaptchaIsRight'}>';
        var checkLoginPath = '<{site_url uri=$backendDir|cat:'/login/checkLogin'}>';
        var homeUrl = '<{site_url uri=$backendDir|cat:'/main'}>';
    </script>
	<script>

		jQuery(document).ready(function() {     
		  Login.init();

		});

	</script>

	<!-- END JAVASCRIPTS -->
</body>
 
<!-- END BODY -->
</html>