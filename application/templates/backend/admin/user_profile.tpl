<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<{include file=$backendViewDir|cat:'/common/head.tpl'}>
	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="<{$css_path}>bootstrap-fileupload.css" rel="stylesheet" type="text/css" />

	<link href="<{$css_path}>chosen.css" rel="stylesheet" type="text/css" />

	<link href="<{$css_path}>profile.css" rel="stylesheet" type="text/css" />

	<!-- END PAGE LEVEL STYLES -->

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

	<{include file=$backendViewDir|cat:'/common/header.tpl'}>

	<!-- BEGIN CONTAINER -->   

	<div class="page-container row-fluid">

		<{include file=$backendViewDir|cat:'/common/leftMenu.tpl'}>

		<!-- BEGIN PAGE -->

		<div class="page-content">

			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<div id="portlet-config" class="modal hide">

				<div class="modal-header">

					<button data-dismiss="modal" class="close" type="button"></button>

					<h3>portlet Settings</h3>

				</div>

				<div class="modal-body">

					<p>Here will be a configuration form</p>

				</div>

			</div>

			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<!-- BEGIN PAGE CONTAINER-->

			<div class="container-fluid">

				<!-- BEGIN PAGE HEADER-->

				<div class="row-fluid">

					<div class="span12">

						<{include file=$backendViewDir|cat:'/common/color_panel.tpl'}>

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->

						<h3 class="page-title">

							<{assign var="breadCurumbsBackup" value=$breadCurumbs}>
                            <{assign var="h3title" value=$breadCurumbsBackup|array_pop}>
							<{$h3title}> 

						</h3>

						<{$breadCurumbs|getBackendBreadCrumbs}>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid profile">

					<div class="span12">

						<!--BEGIN TABS-->

						<div class="tabbable tabbable-custom tabbable-full-width">

							<ul class="nav nav-tabs">

								<li class="active"><a href="#tab_1_1" data-toggle="tab">个人信息</a></li>

								<li><a href="#tab_1_2" data-toggle="tab">账号信息</a></li>

							</ul>

							<div class="tab-content">


								<div class="tab-pane profile-classic row-fluid active" id="tab_1_1">

									<div class="span2">
                                        <img src="<{if $userData.avatar_path}><{base_url uri=$userData.avatar_path}><{else}><{$image_path}>nopic.jpg<{/if}>" alt="" /> 
                                        <!--<a href="#" class="profile-edit">edit</a>-->
                                    </div>

									<ul class="unstyled span10">

										<li><span>账 号:</span> <{$userData.username}></li>

										<li><span>姓 名:</span> <{$userData.surname}></li>

										<li><span>上级账号:</span> <{if $userData.psurname}><{$userData.psurname}><{else}><{$userData.pusername}><{/if}></li>

										<li><span>邮箱:</span> <{$userData.email}></li>

										<li><span>角 色:</span> <{$userData.role_name}></li>

                                        <li><span>登录次数:</span> <{$userData.hits}></li>

										<li><span>最近更改时间:</span> <{$userData.create_time|date_format:'%Y-%m-%d %H:%M:%S'}></li>

                                        <li><span>最后登录IP:</span> <{$userData.last_login_ip}></li>
                                        
                                        <li><span>最后登录时间:</span> <{$userData.last_login_time|date_format:'%Y-%m-%d %H:%M:%S'}></li>
                                        
										<li><span>账号状态:</span> <{if $userData.is_trash}>已停止<{else}>使用中<{/if}></li>
									    
                                        <li><span>用户权限:</span> 
                                            <{if $userData.action_list == 'all'}>
                                            所有
                                            <{else}>
                                                <{assign var='actionList' value=$userData.action_list|getAdminUserActionInfo}>
                                                <{if $actionList}>
                                                    <{foreach from = $actionList item=action name='actionF'}>
                                                        <{$action.action_title}><{if !$smarty.foreach.actionF.last}> ,<{/if}>
                                                    <{/foreach}>
                                                <{/if}>
                                            <{/if}>
                                        </li>
                                    </ul>

								</div>
                                <!--end tab-pane-->
                                
								<!--tab_1_2-->

								<div class="tab-pane row-fluid profile-account" id="tab_1_2">
                                    
									<div class="row-fluid">

										<div class="span12">

											<div class="span3">

												<ul class="ver-inline-menu tabbable margin-bottom-10">

													<li class="active">

														<a data-toggle="tab" href="#tab_1-1">

														<i class="icon-cog"></i> 

														基本信息

														</a> 

														<span class="after"></span>                                    

													</li>

													<li class=""><a data-toggle="tab" href="#tab_2-2"><i class="icon-picture"></i> 更改头像</a></li>

													<li class=""><a data-toggle="tab" href="#tab_3-3"><i class="icon-lock"></i> 更改密码</a></li>

												</ul>

											</div>

											<div class="span9">

												<div class="tab-content">

													<div id="tab_1-1" class="tab-pane active">

														<div style="height: auto;" id="accordion1-1" class="accordion collapse">

															<form action="<{site_url uri=$backendDir|cat:'/admin/updateUserInfo'}>" id="user_form1" method="post">
                                                                <div class="control-group">
																    <label class="control-label">姓 名</label>
                                                                    <div class="controls">    
    																    <input id="surname" type="text" name="surname" value="<{$userData.surname}>" placeholder="Surname" class="m-wrap span8" />
                                                                    </div>
                                                                </div>    
                                                                <div class="control-group">
																    <label class="control-label">Email</label>
                                                                    <div class="controls">    
																        <input id="email" type="text" name="email" value="<{$userData.email}>" placeholder="Email" class="m-wrap span8" />
                                                                    </div>
                                                                </div>
																
																<div class="submit-btn">

																	<button type="submit" class="btn green">保 存</button>

																	<button type="reset" class="btn">重 置</button>

																</div>

                                                            </form>
														</div>

													</div>

													<div id="tab_2-2" class="tab-pane">

														<div style="height: auto;" id="accordion2-2" class="accordion collapse">

                                                            <form action="<{site_url uri=$backendDir|cat:'/admin/updateUserInfo'}>" id="user_form2" method="post" enctype="multipart/form-data">
                                                                
																<p>用户头像</p>

																<br />

																<div class="controls">

																	<div class="thumbnail" style="width: 291px; height: 170px; overflow:hidden;">

																		<img width="291" height="170" src="<{base_url uri=$userData.avatar_path}>" alt="用户头像" />

																	</div>

																</div>

																<div class="space10"></div>

																<div class="fileupload fileupload-new" data-provides="fileupload">

																	<div class="input-append">

																		<div class="uneditable-input">

																			<i class="icon-file fileupload-exists"></i> 

																			<span class="fileupload-preview"></span>

																		</div>

																		<span class="btn btn-file">

																		<span class="fileupload-new">选择文件</span>

																		<span class="fileupload-exists">更 改</span>
                                                                        
																		<input id="avatar_path" type="file" name="avatar_path" class="default" />

																		</span>

																		<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">清 除</a>

																	</div>

																</div>

																<div class="clearfix"></div>


																<div class="space10"></div>

																<div class="submit-btn">

																	<button type="submit" class="btn green">保 存</button>

																	<button type="reset" class="btn">重 置</button>

																</div>

                                                            </form>
														</div>

													</div>

													<div id="tab_3-3" class="tab-pane">
                                                        <form action="<{site_url uri=$backendDir|cat:'/admin/updateUserInfo'}>" id="user_form3" method="post">
                                                        
														<div style="height: auto;" id="accordion3-3" class="accordion collapse">

                                                                <div class="control-group">

																    <label for="current_password" class="control-label">原密码</label>
                                                                
                                                                    <div class="controls">
    																    <input id="current_password" type="password" name="current_password" placeholder="Current password" class="m-wrap span8" />
                                                                    </div>
                                                                </div>
                                                                <div class="control-group">
																    <label class="control-label">新密码</label>
                                                                    <div class="controls">    
																        <input id="new_password" type="password" name="new_password" placeholder="New password" class="m-wrap span8" />
                                                                    </div>
                                                                </div>
                                                                <div class="control-group">
    																<label class="control-label">确认新密码</label>
                                                                    <div class="controls">    
    																    <input id="confirm_new_password" type="password" name="confirm_new_password" placeholder="Confirm new password" class="m-wrap span8" />
                                                                    </div>
                                                                </div>    
																<div class="submit-btn">

																	<button type="submit" class="btn green">保 存</button>

																	<button type="reset" class="btn">重 置</button>

																</div>

                                                            </form>
														</div>

													</div>

													

												</div>

											</div>

											<!--end span9-->                                   

										</div>

									</div>
								</div>

								<!--end tab-pane-->

							</div>

						</div>

						<!--END TABS-->

					</div>

				</div>

				<!-- END PAGE CONTENT-->

			</div>

			<!-- END PAGE CONTAINER--> 

		</div>

		<!-- END PAGE -->    

	</div>

	<!-- END CONTAINER -->

	<!-- BEGIN FOOTER -->

	<{include file=$backendViewDir|cat:'/common/footer.tpl'}>

	<!-- END FOOTER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<{include file=$backendViewDir|cat:'/common/foot.tpl'}>
    
	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript" src="<{$js_path}>bootstrap-fileupload.js"></script>

	<script type="text/javascript" src="<{$js_path}>chosen.jquery.min.js"></script>

    <script type="text/javascript" src="<{$js_path}>jquery.validate.min.js"></script>
    <script src="<{$js_path}>jquery.validate.messages_zh.js" type="text/javascript"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->      

	<!-- END PAGE LEVEL SCRIPTS -->


	<!-- END JAVASCRIPTS -->
    <!--表单验证-->
    <script type="text/javascript">
    var passwordValidatePath = '<{site_url uri=$backendDir|cat:'/admin/checkPasswordIsRight'}>';//密码验证地址
    </script>
    <script type="text/javascript" src="<{$js_path}>user_profile_validation.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function() {
            userProfileValidation.init();
        }); 
    </script>
<!-- END BODY -->
</html>