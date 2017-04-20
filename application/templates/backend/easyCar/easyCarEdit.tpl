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
                                        <input type="hidden" name="status" value="1" />
                                        
										<div class="control-group">

											<label class="control-label" for="title">活动主题</label>

											<div class="controls">

												<input id="title" dataType="Require" msg="活动主题必须填写" name="title" value="<{$data.title}>" type="text" placeholder="活动主题" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="area">活动地区</label>

											<div class="controls">

												<input dataType="Require" msg="活动地区必须填写" id="area" name="area" value="<{$data.area}>" type="text" placeholder="活动地区" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="model">活动车型</label>

											<div class="controls">

												<input dataType="Require" msg="活动车型必须填写" id="model" name="model" value="<{$data.model}>" type="text" placeholder="活动车型" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group ">

											<label class="control-label" for="end_date">活动时间</label>

											<div class="controls">
                                                
                                                <span class="help-inline">即日起至</span>
                                                
												<div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="end_date" name="end_date" readonly size="16" type="text" value="<{$data.end_date}>"  dataType="Require" msg="活动时间必须填写" /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
												<span class="help-inline">活动时间结束，自动下架</span>
											</div>

										</div>
										
										<div class="control-group">

											<label class="control-label" for="earnest">订金（元）</label>

											<div class="controls">

												<input dataType="Require" msg="订金必须填写" id="earnest" name="earnest" value="<{$data.earnest}>" type="text" placeholder="订金" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="url">宝贝地址</label>

											<div class="controls">

												<input dataType="Require" msg="宝贝地址必须填写" id="url" name="url" value="<{$data.url}>" type="text" placeholder="宝贝地址" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group">
                                        
                                            <label class="control-label" for="img">图片</label>

											<div class="controls">

												<div class="fileupload fileupload-new" data-provides="fileupload">

													<div class="fileupload-new thumbnail" style="width: 260px; height: 125px;">

														<img src="<{if $data.img}><{base_url uri=$data.img}><{else}><{$image_path}>backend/nopic.jpg<{/if}>" alt="" />

													</div>

													<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 260px; max-height: 125px; line-height: 20px;"></div>

													<div>

														<span class="btn btn-file">
                                                            
                                                            <span class="fileupload-new">选择图片</span>
                                                        
                                                            <span class="fileupload-exists">更改</span>
                                                            
                                                            <input type="file" class="default" name="img" />
                                                            
                                                        </span>

														<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">清除</a>
                                                        
                                                        <span class="help-inline">尺寸：520px * 250px</span>

													</div>

												</div>

												<span class="label label-important help-inline">注意!</span>

												<span class="help-inline">

												上传功能只支持Firefox、Chrome,Opera,Safari和ie10或以上浏览器 ,只允许上传 jpg,gif,png格式的图片

												</span>

											</div>

										</div>

										<div class="control-group">

											<label class="control-label" for="order">排序</label>

											<div class="controls">

												<input dataType="Require" msg="排序必须填写" id="order" name="order" value="<{$data.order}>" type="text" placeholder="排序" class="m-wrap span6" />
                                                
                                                <span class="help-inline">数字越大越靠前</span>

											</div>

										</div>
                                        
										<div class="form-actions">

											<button type="submit" onclick="return submit_form();" class="btn blue"><i class="icon-ok"></i> 发布</button>

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