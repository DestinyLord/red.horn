<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--[if IE 8]> <html xmlns="http://www.w3.org/1999/xhtml" lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html xmlns="http://www.w3.org/1999/xhtml" lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html xmlns="http://www.w3.org/1999/xhtml" lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>
    <{include file= $backendViewDir|cat:'/common/head.tpl'}>

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="<{$css_path}>select2_metro.css" />
	
	<!-- END PAGE LEVEL STYLES -->
	<link rel="stylesheet" type="text/css" href="<{$css_path}>datepicker.css" />
	<link rel="stylesheet" type="text/css" href="<{$css_path}>bootstrap-fileupload.css" />
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

				<div class="row-fluid">

					<div class="span12">

						<!-- BEGIN EXAMPLE TABLE PORTLET-->

						<div class="tab-pane"  id="tab_5">

							<div class="portlet box blue ">

								<div class="portlet-title">

									<div class="caption"><i class="icon-reorder"></i><{$h3title}></div>

									<!--<div class="tools">

										<a href="javascript:;" class="collapse"></a>

										<a href="#portlet-config" data-toggle="modal" class="config"></a>

										<a href="javascript:;" class="reload"></a>

										<a href="javascript:;" class="remove"></a>

									</div>-->

								</div>

								<div class="portlet-body form">

									<!-- BEGIN FORM-->

									<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data" >
                                    
                                        <input type="hidden" name="id" value="<{$data.id}>" />
                                        <input type="hidden" name="oldType" value="<{$data.type}>" />
                                        
										<div class="control-group">

											<label class="control-label" for="type">短信编码<span class="required">*</span></label>

											<div class="controls">

												<input id="type" dataType="Require" msg="短信编码必须填写" name="type" value="<{$data.type}>" type="text" placeholder="短信编码" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="name">短信专题名<span class="required">*</span></label>

											<div class="controls">

												<input dataType="Require" msg="短信专题名必须填写" id="name" name="name" value="<{$data.name}>" type="text" placeholder="短信专题名" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="sms">Tae平台短信<span class="required">*</span></label>
                                            
                                            <div class="controls">

												<textarea dataType="Require" msg="Tae平台短信必须填写" id="sms" name="sms" type="text" placeholder="Tae平台短信" class="m-wrap span6" rows="6"><{$data.sms}></textarea>
                                                
                                                <span class="help-inline">
                                                    可使用参数：
                                                    <br />验证码($verify_code$)
                                                    <br />车系名称($series_name$) &nbsp;
                                                          经销商名称($dealer_name$)
                                                    <br />经销商电话($dealer_phone$) &nbsp;
                                                          经销商地址($dealer_address$)
                                                    <br />客户姓名($customerName$) &nbsp;
                                                          客户手机($customerTel$)                                                    
                                                </span>

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="sms_tmall">天猫宝贝短信</label>

											<div class="controls">

												<textarea id="sms_tmall" name="sms_tmall" type="text" placeholder="天猫宝贝短信" class="m-wrap span6" rows="6"><{$data.sms_tmall}></textarea>

											</div>

										</div>
                                        
										<div class="form-actions">

											<button type="submit" onclick="return submit_form();" class="btn blue"><i class="icon-ok"></i> 保存</button>

											<button type="reset" class="btn">重置</button>

										</div>

									</form>

									<!-- END FORM-->  

								</div>

							</div>

						</div>

						<!-- END EXAMPLE TABLE PORTLET-->

					</div>

				</div>

				<!-- END PAGE CONTENT-->

			</div>

			<!-- END PAGE CONTAINER-->

		</div>

		<!-- END PAGE -->

	</div>

	<!-- END CONTAINER -->

	<{include file=$backendViewDir|cat:'/common/footer.tpl'}>
    <{include file=$backendViewDir|cat:'/common/foot.tpl'}>

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script type="text/javascript" src="<{$js_path}>select2.min.js"></script>
    
    <script src="<{$js_path}>jquery.validate.min.js" type="text/javascript"></script>
    <script src="<{$js_path}>jquery.validate.messages_zh.js" type="text/javascript"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>form-samples.js"></script>    
    <script type="text/javascript" src="<{$js_path}>bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<{$js_path}>bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="<{$js_path}>validator.js"></script>

	<script type="text/javascript">

		jQuery(document).ready(function() {
		   FormSamples.init();
		});
        
        function submit_form(){
        	var form_ob=document.getElementById("dataform"); 
        	
        	if((!Validator.Validate(form_ob, 4)))
        	{
        		return false;
        	}
        
        	form_ob.submit();
        }

	</script>
    
</body>
<!-- END BODY -->

</html>