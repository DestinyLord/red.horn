<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<{include file= $backendViewDir|cat:'/common/head.tpl'}>

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<{$css_path}>lock.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body onload="document.getElementById('password').focus()">

	<div class="page-lock">

		<div class="page-logo">

			<a class="brand" href="">

			<img src="<{$image_path}>logo.png" alt="logo" />

			</a>

		</div>

		<div class="page-body">

			<img class="page-lock-img" src="<{if $adminUserAvatar}><{base_url uri=$adminUserAvatar}><{else}><{$image_path}>nopic.jpg<{/if}>" alt="" />

			<div class="page-lock-info">

				<h1><{if $userData.surname}><{$userData.surname}><{else}><{$userData.username}><{/if}></h1>
                
				<span><{$userData.email}></span>

				<span><em>Locked</em></span>

				<form class="form-search" action="" method="post">
					<div class="control-group <{if $validationErrors}>error<{/if}>">
                        <div class="input-append">
    
    						<input id="password" type="password" name="password" class="m-wrap" placeholder="Password">
    
    						<button type="submit" class="btn blue icn-only"><i class="m-icon-swapright m-icon-white"></i></button>
                                
    					</div>
                        <{if $validationErrors}>
                        <label for="password" class="help-inline help-small no-left-padding"><{$validationErrors}></label>
                        <{/if}>
                    </div>
					<div class="relogin">

						<a href="<{site_url uri = $backendDir|cat:'/login'}>">其他账号登录</a>

					</div>

				</form>

			</div>

		</div>

		<div class="page-footer">

			

		</div>

	</div>

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<{include file=$backendViewDir|cat:'/common/foot.tpl'}>

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="<{$js_path}>jquery.backstretch.min.js" type="text/javascript"></script>
    
    <script src="<{$js_path}>lock.js"></script>   
    
	<!-- END PAGE LEVEL PLUGINS -->   


	   

	<script>

		jQuery(document).ready(function() {    

		   Lock.init();

		});

	</script>

	<!-- END JAVASCRIPTS -->

<!-- END BODY -->

</html>