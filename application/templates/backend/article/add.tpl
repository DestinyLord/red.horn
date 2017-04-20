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

								<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data">
                                    
									<div class="control-group">

										<label class="control-label" for="title">文章标题</label>

										<div class="controls">

											<input dataType="Require" msg="文章标题必须填写" id="title" name="title" value="" type="text" placeholder="文章标题" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="deal_num">成交台数</label>

										<div class="controls">

											<input dataType="Number" msg="台数必须为正整数" id="deal_num" name="deal_num" value="" type="text" placeholder="成交台数" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="praise">喜欢数量</label>

										<div class="controls">

											<input dataType="Integer" msg="数量必须为整数" id="praise" name="praise" value="" type="text" placeholder="喜欢数量" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="derogatory">没劲数量</label>

										<div class="controls">

											<input dataType="Integer" msg="数量必须为整数" id="derogatory" name="derogatory" value="" type="text" placeholder="没劲数量" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="issue_time">发布时间</label>

										<div class="controls">
											
											<div class="input-append date date-picker" >

												<input dataType="Require" msg="发布时间必须填写" class="m-wrap m-ctrl-medium date-picker" id="issue_time" name="issue_time" readonly size="16" type="text" value="" placeholder="发布时间" /><span class="add-on" ><i class="icon-calendar"></i></span>

											</div>

										</div>

									</div>

									<div class="control-group">

											<label class="control-label">主题图片</label>

											<div class="controls">

												<div class="fileupload fileupload-new" data-provides="fileupload">

													<div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

														<img src="<{$image_path}>backend/nopic.jpg" alt="" />

													</div>

													<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>

													<div>

														<span class="btn btn-file"><span class="fileupload-new">选择图片</span>

														<span class="fileupload-exists">更改</span>

														<input type="file" class="default" name="pic_path" /></span>

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

										<label class="control-label" for="leads_key">内容</label>

										<div class="controls">

											<{$ckeditor->editor('content')}>

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
	<script type="text/javascript" src="<{$js_path}>validator.js"></script>
	<script type="text/javascript" src="<{$js_path}>bootstrap-fileupload.js"></script>

	<script type="text/javascript">

		jQuery(document).ready(function() {       

		   FormSamples.init();
		   if (jQuery().datepicker) {
            $('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd'});
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