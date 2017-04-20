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
	<link rel="stylesheet" type="text/css" href="<{$css_path}>bootstrap-toggle-buttons.css" />
	<link rel="stylesheet" type="text/css" href="<{$css_path}>bootstrap-fileupload.css" />
	<link rel="stylesheet" type="text/css" href="<{$css_path}>multi-select-metro.css" />
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

								</div>

								<div class="portlet-body form">

									<!-- BEGIN FORM-->

									<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data" >
										
										<input type="hidden" name="main_id" value="<{$mainId}>" />

										<div class="control-group">

											<label class="control-label" for="name">奖品名称</label>

											<div class="controls">

												<input id="name" name="name" value="" dataType="Require" msg="奖品名称必须填写" type="text" placeholder="奖品名称" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="totality">总量</label>

											<div class="controls">

												<input id="totality" name="totality" value="" dataType="Number" msg="总量必须为正整数" type="text" placeholder="总量" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="rest">剩余数量</label>

											<div class="controls">

												<input id="rest" name="rest" value="" dataType="Number" msg="总量必须为正整数" type="text" placeholder="剩余数量" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="daily_limit">每日上限（0为无上限）</label>

											<div class="controls">

												<input id="daily_limit" name="daily_limit" value="" dataType="Number" msg="每日上限必须为整数" type="text" placeholder="每日上限" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="rate">概率</label>

											<div class="controls">

												<input id="rate" name="rate" value="" dataType="Double" msg="概率必须为浮点数" type="text" placeholder="概率" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="begin_time">有效期</label>

											<div class="controls">
												<div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="begin_time" name="begin_time" readonly size="16" type="text" value=""/><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
												<span class="help-inline">&nbsp;&nbsp; 至 &nbsp;&nbsp;</span>
												<div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value="" dataType="Require" msg="有效期必须填写完整"  /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
											</div>

										</div>


										<div class="control-group">

											<label class="control-label" for="daily_limit">奖项排序</label>

											<div class="controls">

												<input id="sort" name="sort" value="0" dataType="Integer" msg="排序必须为整数" type="text" placeholder="奖项排序" class="m-wrap span6" />

											</div>

										</div>
										
										<div class="control-group">

											<label class="control-label" for="module">抽奖模块位置</label>

											<div class="controls">

												<input id="module" name="module" value="" dataType="Require" msg="抽奖模块位置必须填写" type="text" placeholder="奖品名称" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label">允许参与的Key值</label>

											<div class="controls">

												<select multiple="multiple" id="my_multi_select1" name="leads_key[]">
													<{foreach from=$leadsKeyList item = v}>
													<option value="<{$v.leads_key}>"><{$v.leads_name}></option>

													<{/foreach}>

												</select>

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
	<script type="text/javascript" src="<{$js_path}>jquery.toggle.buttons.js"></script>

	<script type="text/javascript" src="<{$js_path}>jquery.multi-select.js"></script> 


	<script type="text/javascript">

		jQuery(document).ready(function() {       

		   	FormSamples.init();
		   	$('#my_multi_select1').multiSelect();
		   	if (jQuery().datepicker) {
            	$('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd' ,'minDate':'<{date("Y-m-d")}>'});
        	}

        	$('.status-box').toggleButtons({
        		width:200,
        		label: {
                	enabled: "上架",
                	disabled: "下架"
            	}
        	});

        	$('.enable-box').toggleButtons({
        		width:200,
        		label: {
                	enabled: "启用",
                	disabled: "停用"
            	}
        	});
		});

	</script>
    
<script type="text/javascript">


function submit_form(){
	var form_ob=document.getElementById("dataform"); 

	if((!Validator.Validate(form_ob,4)))
	{
		return false;
	}

	form_ob.submit();
}

</script>
    
</body>
<!-- END BODY -->

</html>