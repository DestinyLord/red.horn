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
										
										<input type="hidden" name="id" value="<{$editData.id}>" />

										<div class="control-group">

											<label class="control-label" for="number" >本期团购期号</label>

											<div class="controls">

												<input id="number" name="number" value="<{$editData.number}>" dataType="Require" msg="团购期号必须填写" type="text" placeholder="本期团购期号" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="groupon_name" >本期团购主题</label>

											<div class="controls">

												<input id="groupon_name" name="groupon_name" value="<{$editData.groupon_name}>" dataType="Require" msg="团购主题必须填写" type="text" placeholder="本期团购主题" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="start_time">有效期</label>

											<div class="controls">
												<div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="start_time" name="start_time" readonly size="16" type="text" value="<{$editData.start_time|date_format:'%Y-%m-%d'}>" placeholder="开始时间"/><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
												<span class="help-inline">&nbsp;&nbsp; 至 &nbsp;&nbsp;</span>
												<div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value="<{$editData.end_time|date_format:'%Y-%m-%d'}>" dataType="Require" msg="有效期必须填写完整"  placeholder="结束时间" /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="policy" >厂家团购政策</label>

											<div class="controls">

												<input id="policy" name="policy" value="<{$editData.policy}>" dataType="Require" msg="团购政策必须填写" type="text" placeholder="厂家团购政策" class="m-wrap span6" />

											</div>

										</div>

										
										<div class="control-group last">

											<label class="control-label">本期团购PC封面图片</label>

											<div class="controls">

												<div class="fileupload fileupload-new" data-provides="fileupload">

													<div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

														<img src="<{if $editData.pc_pic_path}>/<{$editData.pc_pic_path}><{else}><{$image_path}>backend/nopic.jpg<{/if}>" alt="" />

													</div>

													<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>

													<div>

														<span class="btn btn-file"><span class="fileupload-new">选择图片</span>

														<span class="fileupload-exists">更改</span>

														<input type="file" class="default" name="pc_pic_path" /></span>

														<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">清除</a>

													</div>

												</div>

												<span class="label label-important">注意!</span>

												<span>

												上传功能只支持Firefox、Chrome,Opera,Safari和ie10或以上浏览器 ,只允许上传 jpg,gif,png格式的图片

												</span>

											</div>

										</div>


										<div class="control-group last">

											<label class="control-label">本期团购WAP封面图片</label>

											<div class="controls">

												<div class="fileupload fileupload-new" data-provides="fileupload">

													<div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

														<img src="<{if $editData.wap_pic_path}>/<{$editData.wap_pic_path}><{else}><{$image_path}>backend/nopic.jpg<{/if}>" alt="" />

													</div>

													<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>

													<div>

														<span class="btn btn-file"><span class="fileupload-new">选择图片</span>

														<span class="fileupload-exists">更改</span>

														<input type="file" class="default" name="wap_pic_path" /></span>

														<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">清除</a>

													</div>

												</div>

												<span class="label label-important">注意!</span>

												<span>

												上传功能只支持Firefox、Chrome,Opera,Safari和ie10或以上浏览器 ,只允许上传 jpg,gif,png格式的图片

												</span>

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
		   	if (jQuery().datepicker) {
            	$('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd' ,'minDate':'<{date("Y-m-d")}>'});
        	}
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