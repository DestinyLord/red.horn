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
	<link href="<{$css_path}>jquery.fileupload-ui.css" rel="stylesheet" />
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

								<li><a class="" href="#tab_2" data-toggle="tab">广告图片</a></li>

							</ul>

							<div class="tab-content">

								<div class="tab-pane active" id="tab_1">

									<div class="portlet box blue">

										<div class="portlet-title">

											<div class="caption"><i class="icon-reorder"></i>基本信息</div>

										</div>

										<div class="portlet-body form">

											<!-- BEGIN FORM-->

											<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form">
		                                        <input type="hidden" name="id" value="<{$editData.id}>" />
												<div class="control-group">

													<label class="control-label" >广告位置</label>

													<div class="controls">

														<div class="select2-wrapper">

															<select name="channel_id" class="span3 select2_category" tabindex="1">

																<option value="">所属业务领域</option>
																<{foreach from=$channelList item=cha}>
																<option <{if $editData.channel_id == $cha.channel_id}>selected="true"<{/if}> value="<{$cha.channel_id}>"><{$cha.channel_name}></option>
																<{/foreach}>
																
															</select>

															<select name="page_id" class="span3 select2_category" tabindex="1">

																<option value="">请选择所在页面</option>
																<{foreach from=$pageList item=page}>
																<option <{if $editData.page_id == $page.page_id}>selected="true"<{/if}> value="<{$page.page_id}>"><{$page.page_name}></option>
																<{/foreach}>

															</select>

															<select name="position_id" class="span3 select2_category" tabindex="1" dataType="Require" msg="点位必须选择">

																<option value="">请选择广告点位</option>
																<{foreach from=$positionList item=pos}>
																<option <{if $editData.position_id == $pos.position_id}>selected="true"<{/if}> value="<{$pos.position_id}>"><{$pos.position_name}></option>
																<{/foreach}>

															</select>
															
														</div>

													</div>

												</div>
		                                        
		                                        <div class="control-group">

													<label class="control-label" for="width">图片尺寸</label>

													<div class="controls">

														<input dataType="Number" msg="长度必须为正整数" id="width" name="width" value="<{$editData.width}>" type="text" placeholder="长度" class="m-wrap span1" />
														&nbsp;&nbsp;*&nbsp;&nbsp;

														<input dataType="Number" msg="宽度必须为正整数" id="height" name="height" value="<{$editData.height}>" type="text" placeholder="宽度" class="m-wrap span1" />
													</div>

												</div>
		                                        
		                                        <div class="control-group">

													<label class="control-label" for="ad_name">广告名称</label>

													<div class="controls">

														<input dataType="Require" msg="广告名称必须填写" id="ad_name" name="ad_name" value="<{$editData.ad_name}>" type="text" placeholder="广告名称" class="m-wrap span6" />

													</div>

												</div>
		                                        <!--<div class="control-group ">

													<label class="control-label" for="pic_info">图片描述</label>

													<div class="controls">

														<input id="pic_info" name="pic_info" value="" type="text" placeholder="图片描述" class="m-wrap span6" />
		   
													</div>           

												</div>-->

												<div class="control-group ">

													<label class="control-label" for="link">点击链接</label>

													<div class="controls">

														<input id="link" name="link" value="<{$editData.link}>" type="text" placeholder="点击链接" class="m-wrap span6" />
		   
													</div>           

												</div>

												<div class="control-group ">

													<label class="control-label">目标窗口</label>

													<div class="controls">

														<div class="basic-toggle-button">

															<input type="checkbox" class="toggle" name="target" value="1" <{if $editData.target == 1}>checked="checked"<{/if}> />

														</div>

													</div>          

												</div>

												<div class="control-group">

													<label class="control-label" for="end_time">有效期</label>

													<div class="controls">
														
														<span class="help-inline">即日起至 &nbsp;&nbsp;</span>
														<div class="input-append date date-picker" >

															<input class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value="<{$editData.end_time|date_format:"%Y-%m-%d"}>" /><span class="add-on" ><i class="icon-calendar"></i></span>

														</div>

														<span class="help-inline">不填默认为长期有效</span>

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
												<{if $images}>
												<{foreach from=$images item=img}>
												<tr class="template-download ">

										            <td class="preview">
										                <a class="fancybox-button" data-rel="fancybox-button" href="<{base_url uri=$img.pic_path}>" title="<{substr($img.pic_path ,-36)}>">

										                <img src="<{base_url uri=$img.pic_path}>" width="100" height="60">

										                </a>

										            </td>

										            <td class="name">

										                <a href="<{base_url uri=$img.pic_path}>" title="<{substr($img.pic_path ,-36)}>" data-gallery="<{base_url uri=$img.pic_path}>" download="<{substr($img.pic_path ,-36)}>"><{substr($img.pic_path ,-36)}></a>

										            </td>

										            <td class="size"><span></span></td>

										            <td colspan="2"></td>

											        <td class="delete">

											            <button class="btn red" data-type="GET" data-url="<{site_url uri='backend/ad/delImage'}>?id=<{$img.id}>">

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
	<script type="text/javascript" src="<{$js_path}>jquery.toggle.buttons.js"></script>

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

	<script src="<{$js_path}>ad-form-fileupload.js"></script>

	<script type="text/javascript">

		jQuery(document).ready(function() {       

		   	FormSamples.init();
		   	if (jQuery().datepicker) {
            	$('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd'});
        	}
        	$('.basic-toggle-button').toggleButtons({
        		width:200,
        		label: {
                enabled: "新窗口",
                disabled: "原窗口"
            	}
        	});

        	FormFileUpload.init();
		});

	</script>
    
    <script type="text/javascript">
        jQuery(function(){
            $('select[name="channel_id"]').change(function(){
            	var channel_id = $(this).val();
            	$('select[name="page_id"]').html('<option value="">请选择所在页面</option>');
            	$('select[name="position_id"]').html('<option value="">请选择广告点位</option>');
            	$('#s2id_autogen3 a.select2-choice span').html('请选择所在页面');
            	$('#s2id_autogen5 a.select2-choice span').html('请选择广告点位')
            	$.post(
            			'/index.php/<{$backendDir}>/ad/getPageList/'+channel_id ,
            			{} ,
            			function(res){
            				if(res.datas != '')
            				{
            					var html = '<option value="">请选择所在页面</option>';
            					for(var i in res.datas)
            					{
            						html += '<option value="'+res.datas[i].page_id+'">'+res.datas[i].page_name+'</option>'
            					}

            					$('select[name="page_id"]').html(html);
            				}
            			} ,
            			'json'
            	);
            });
            
            $('select[name="page_id"]').change(function(){
            	$('select[name="position_id"]').html('<option value="">请选择广告点位</option>');
            	$('#s2id_autogen5 a.select2-choice span').html('请选择广告点位');
            	var page_id = $(this).val();
            	$.post(
            		'/index.php/<{$backendDir}>/ad/getPositionList/'+page_id ,
            		{} ,
            		function(res)
            		{
            			if(res.datas != '')
            			{            		
            				var html = '';
            				
            				for(var i in res.datas)
            				{
            					html += '<option value="'+res.datas[i].position_id+'">'+res.datas[i].position_name+'</option>'
            				}
            				$('select[name="position_id"]').html(html);
            				
            			}
            		} ,
            		'json'
            	);
            });



        });



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