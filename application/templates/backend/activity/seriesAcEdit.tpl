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
	<link type="text/css" href="<{$css_path}>jquery.fileupload-ui.css" rel="stylesheet" />
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

					<div class="tabbable tabbable-custom boxless">

							<ul class="nav nav-tabs">

								<li class="active"><a href="#tab_1" data-toggle="tab">基本信息</a></li>

								<li><a class="" href="#tab_2" data-toggle="tab">上传多图</a></li>

							</ul>

							<div class="tab-content">

								<div class="tab-pane active" id="tab_1">

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

											<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data" >
		                                    
		                                        <input type="hidden" name="id" value="<{$data.id}>" />
		                                        <input type="hidden" name="status" value="1" />
		                                        
												<div class="control-group">

													<label class="control-label" for="activity_name">活动主题</label>

													<div class="controls">

														<input id="activity_name" dataType="Require" msg="活动主题必须填写" name="activity_name" value="<{$data.activity_name}>" type="text" placeholder="活动主题" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="type">类型</label>

													<div class="controls">

														<select name="type" class="span3 select2_category" tabindex="1">

															<option value="1">PC端</option>
															<option <{if $data.type == 2}>selected="true"<{/if}> value="2">WAP端</option>
															
														</select>

													</div>

												</div>

		                                        
		                                        <div class="control-group">

													<label class="control-label" for="title">留资标题</label>

													<div class="controls">

														<input id="title" dataType="Require" msg="留资标题必须填写" name="title" value="<{$data.title}>" type="text" placeholder="留资标题" class="m-wrap span6" />

													</div>

												</div>
		                                        
		                                        <div class="control-group">

													<label class="control-label" for="button_name">按钮名称</label>

													<div class="controls">

														<input id="button_name" dataType="Require" msg="按钮名称必须填写" name="button_name" value="<{$data.button_name}>" type="text" placeholder="按钮名称" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="postfix">服务内容</label>

													<div class="controls">

														<input id="postfix" name="postfix" value="<{$data.postfix}>" type="text" placeholder="服务内容" class="m-wrap span6" />

													</div>

												</div>
		                                        
		                                        <div class="control-group seriesBox">

													<label class="control-label" for="series_id">活动车系</label>
		                                            
		                                            <div class="controls">

														<{foreach from=$seriesList item=seriesData name=sl}>
															<{if $smarty.foreach.sl.index % 4 == 0}>
															<div class="row-fluid">
															<{/if}>
																<div class="span3">

																	<label class="checkbox line">

																	<input type="checkbox" <{if in_array($seriesData.series_id ,$data.series_id )}>checked="true"<{/if}> name="series_id[]" value="<{$seriesData.series_id}>" /> <{$seriesData.name}>

																	</label>
																</div>
															<{if $smarty.foreach.sl.index % 4 == 3 || $smarty.foreach.sl.last}>	
															</div>
															<{/if}>
		   												<{/foreach}>
		   
													</div>

												</div>
		                                        
		                                        <div class="control-group ">

													<label class="control-label" for="begin_time">启止时间</label>

													<div class="controls">
		                                                
		                                                <div class="input-append date date-picker" >

															<input class="m-wrap m-ctrl-medium date-picker" id="begin_time" name="begin_time" readonly size="16" type="text" value="<{$data.begin_time}>"  dataType="Require" msg="启止时间必须填写" /><span class="add-on" ><i class="icon-calendar"></i></span>

														</div>
		                                                
														<div class="input-append date date-picker" >

															<input class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value="<{$data.end_time}>"  dataType="Require" msg="启止时间必须填写" /><span class="add-on" ><i class="icon-calendar"></i></span>

														</div>
														<span class="help-inline">活动结束，自动下架</span>
													</div>

												</div>
												
												<div class="control-group">

													<label class="control-label" for="apply_user">报名基数</label>

													<div class="controls">

														<input id="apply_user" name="apply_user" value="<{$data.apply_user}>" type="text" placeholder="报名基数" class="m-wrap span6" />

													</div>

												</div>
		                                        
		                                        <div class="control-group">

													<label class="control-label" for="leads_key">留资Key值</label>

													<div class="controls">

														<input dataType="Require" msg="留资Key值必须填写" id="leads_key" name="leads_key" value="<{$data.leads_key}>" type="text" placeholder="留资Key值" class="m-wrap span6" />

													</div>

												</div>
                                                
                                                <div class="control-group">

													<label class="control-label" for="leave_attr">附加留资属性</label>

													<div class="controls">
                                                    
                                                        <label class="checkbox line">
                                                        
														  <input type="checkbox" <{if in_array("bank", $data.leave_attr)}>checked="true"<{/if}> name="leave_attr[]" value="bank" /> 六大金融机构
                                                        
                                                        </label>

													</div>

												</div>
		                                        
		                                        <div class="control-group">

													<label class="control-label" for="url">留资成功跳转地址</label>

													<div class="controls">

														<input id="url" name="url" value="<{$data.url}>" type="text" placeholder="留资成功跳转地址" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">
		                                        
		                                            <label class="control-label" for="main_picture">图片</label>

													<div class="controls">

														<div class="fileupload fileupload-new" data-provides="fileupload">

															<div class="fileupload-new thumbnail" style="width: 260px; height: 125px;">

																<img src="<{if $data.main_picture}><{base_url uri=$data.main_picture}><{else}><{$image_path}>backend/nopic.jpg<{/if}>" alt="" />

															</div>

															<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 260px; max-height: 125px; line-height: 20px;"></div>

															<div>

																
   
		                                                         <input type="file" class="default" name="main_picture" />
		                                                            
		                                                        
		                                                        
		                                                        <span class="help-inline">尺寸：高度425px，长度620px~990px</span>

															</div>

														</div>

														<span class="label label-important help-inline">注意!</span>

														<span class="help-inline">

														上传功能只支持Firefox、Chrome,Opera,Safari和ie10或以上浏览器 ,只允许上传 jpg,gif,png格式的图片

														</span>

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
								<!-- END EXAMPLE TABLE PORTLET-->
								</div>

								<div class="tab-pane" id="tab_2">
									
									<form id="fileupload" method="POST" enctype="multipart/form-data">

										<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->

										<div class="row-fluid fileupload-buttonbar">

											<div class="span7">

												<!-- The fileinput-button span is used to style the file input field as button -->

												<span class="btn green fileinput-button">

												<i class="icon-plus icon-white"></i>

												<span>添加图片...</span>

												<input type="file" name="Filedata" multiple>

												</span>

												<button type="submit" class="btn blue start">

												<i class="icon-upload icon-white"></i>

												<span>开始上传</span>

												</button>

												<button type="reset" class="btn yellow cancel">

												<i class="icon-ban-circle icon-white"></i>

												<span>取消上传</span>

												</button>

												<button type="button" class="btn red delete">

												<i class="icon-trash icon-white"></i>

												<span>删除</span>

												</button>

												<input type="checkbox" class="toggle fileupload-toggle-checkbox">

											</div>

											<!-- The global progress information -->

											<div class="span5 fileupload-progress fade">

												<!-- The global progress bar -->

												<div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">

													<div class="bar" style="width:0%;"></div>

												</div>

												<!-- The extended global progress information -->

												<div class="progress-extended">&nbsp;</div>

											</div>

										</div>

										<!-- The loading indicator is shown during file processing -->

										<div class="fileupload-loading"></div>

										<br>

										<!-- The table listing the files available for upload/download -->

										<table role="presentation" class="table table-striped">
												
										    <tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery">
										    	<{if $data.wapImages}>
												<{foreach from=$data.wapImages item=img key=k}>
												<tr class="template-download ">

										            <td class="preview">
										                <a class="fancybox-button" data-rel="fancybox-button" href="<{base_url uri=$img}>" title="<{substr($img ,-36)}>">

										                <img src="<{base_url uri=$img}>" width="100" height="60">

										                </a>

										            </td>

										            <td class="name">

										                <a href="<{base_url uri=$img}>" title="<{substr($img ,-36)}>" data-gallery="<{base_url uri=$img}>" download="<{substr($img ,-36)}>"><{substr($img ,-36)}></a>

										            </td>

										            <td class="size"><span></span></td>

										            <td colspan="2"></td>

											        <td class="delete">

											            <button class="btn red" data-type="GET" data-url="<{site_url uri='backend/activity/delWapImage'}>?id=<{$data.id}>&imageKey=<{$k}>">

											                <i class="icon-trash icon-white"></i>

											                <span>删除</span>

											            </button>

											            <input type="checkbox" class="fileupload-checkbox hide" name="delete" value="1">

											        </td>

										    	</tr>
										    	<{/foreach}>
										    	<{/if}>

										    </tbody>
										</table>

									

									<br>

									<div class="well">

										<h3>操作提示</h3>

										<ul>

											<li>最大文件大小上传<strong>5 MB</strong>。</li>

											<li>只能上传  (<strong>JPG, GIF, PNG</strong>) 格式的图片。</li>

											<li>可以从电脑的桌面直接拖文件上传或把图片从列表删除文件 。</li>

										</ul>

									</div>

									<div class="row-fluid">

										<div class="span12">

											<script id="template-upload" type="text/x-tmpl">

												{% for (var i=0, file; file=o.files[i]; i++) { %}

												    <tr class="template-upload fade">

												        <td class="preview"><span class="fade"></span></td>

												        <td class="name"><span>{%=file.name%}</span></td>

												        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>

												        {% if (file.error) { %}

												            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>

												        {% } else if (o.files.valid && !i) { %}

												            <td>

												                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>

												            </td>

												            <td class="start">{% if (!o.options.autoUpload) { %}

												                <button class="btn">

												                    <i class="icon-upload icon-white"></i>

												                    <span>开始</span>

												                </button>

												            {% } %}</td>

												        {% } else { %}

												            <td colspan="2"></td>

												        {% } %}

												        <td class="cancel">{% if (!i) { %}

												            <button class="btn red">

												                <i class="icon-ban-circle icon-white"></i>

												                <span>取消</span>

												            </button>

												        {% } %}</td>

												    </tr>

												{% } %}

											</script>

											<!-- The template to display files available for download -->

											<script id="template-download" type="text/x-tmpl">

												{% for (var i=0, file; file=o.files[i]; i++) { %}

												    <tr class="template-download fade">

												        {% if (file.error) { %}

												            <td></td>

												            <td class="name"><span>{%=file.name%}</span></td>

												            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>

												            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>

												        {% } else { %}

												            <td class="preview">

												            {% if (file.thumbnail_url) { %}

												                <a class="fancybox-button" data-rel="fancybox-button" href="{%=file.url%}" title="{%=file.name%}">

												                <img src="{%=file.thumbnail_url%}" width="100" height="60">

												                </a>

												            {% } %}</td>

												            <td class="name">

												                <a href="{%=file.url%}" title="{%=file.name%}" data-gallery="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>

												            </td>

												            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>

												            <td colspan="2"></td>

												        {% } %}

												        <td class="delete">

												            <button class="btn red" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}"{% if (file.delete_with_credentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>

												                <i class="icon-trash icon-white"></i>

												                <span>删除</span>

												            </button>

												            <input type="checkbox" class="fileupload-checkbox hide" name="delete" value="1">

												        </td>

												    </tr>

												{% } %}

											</script>

										</div>

									</div>
								</div>

								
							</div>

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

		<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="<{$js_path}>jquery.fancybox.pack.js"></script>

	<!-- BEGIN:File Upload Plugin JS files-->

	<script src="<{$js_path}>jquery.ui.widget.js"></script>

	<!-- The Templates plugin is included to render the upload/download listings -->

	<script src="<{$js_path}>tmpl.min.js"></script>

	<!-- The Load Image plugin is included for the preview images and image resizing functionality -->

	<script src="<{$js_path}>load-image.min.js"></script>

	<!-- The Canvas to Blob plugin is included for image resizing functionality -->

	<script src="<{$js_path}>canvas-to-blob.min.js"></script>

	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->

	<script src="<{$js_path}>jquery.iframe-transport.js"></script>

	<!-- The basic File Upload plugin -->

	<script src="<{$js_path}>jquery.fileupload.js"></script>

	<!-- The File Upload file processing plugin -->

	<script src="<{$js_path}>jquery.fileupload-fp.js"></script>

	<!-- The File Upload user interface plugin -->

	<script src="<{$js_path}>jquery.fileupload-ui.js"></script>

	<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->

	<!--[if gte IE 8]><script src="media/js/jquery.xdr-transport.js"></script><![endif]-->

	<!-- END:File Upload Plugin JS files-->

	<!-- END PAGE LEVEL PLUGINS -->

	<script src="<{$js_path}>form-fileupload.js"></script>


	<script type="text/javascript">

		jQuery(document).ready(function() {
		   FormSamples.init();

		   FormFileUpload.init({'sessionName':'series_activity'});
		   if (jQuery().datepicker) {
            $('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd' ,'minDate':'<{date("Y-m-d")}>'});
        }
		});
        
        function submit_form(){
        	var form_ob=document.getElementById("dataform"); 
        	var series_check = false;  //  判断是否有勾选车系
            
            $('input[name="series_id[]"]').each(function(){
        		if($(this).attr('checked'))
        		{
        			series_check = true;
        			return false; //跳出循环
        		}
        	});
            
        	if((!Validator.Validate(form_ob, 4)))
        	{
        		return false;
        	}
            
            if(series_check == false)
        	{
        		$('.seriesBox').addClass('error');
        		return false;
        	}else
        	{
        		$('.seriesBox').removeClass('error');
        	}
        
        	form_ob.submit();
        }

	</script>
    
</body>
<!-- END BODY -->

</html>