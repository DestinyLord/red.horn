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

								<li><a class="" href="#tab_2" data-toggle="tab">车系图片</a></li>

							</ul>

							<div class="tab-content">

								<div class="tab-pane active" id="tab_1">

									<div class="portlet box blue">

										<div class="portlet-title">

											<div class="caption"><i class="icon-reorder"></i>基本信息</div>

										</div>

										<div class="portlet-body form">

											<!-- BEGIN FORM-->

											<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data">
		                                        
												<div class="control-group">

													<label class="control-label" >品牌</label>

													<div class="controls">

														<div class="select2-wrapper">

															<select name="brand_id" class="span6 select2_category" tabindex="1" dataType="Require" msg="品牌必须选择">

																<option value="">请选择品牌</option>
																<option value="1">日产</option>
																<option value="2">启辰</option>
																<option value="6">进口</option>
																
															</select>
															
														</div>

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" >类型</label>

													<div class="controls">

														<div class="select2-wrapper">

															<select name="level" class="span6 select2_category" tabindex="1" dataType="Require" msg="品牌必须选择">

																<option value="">请选择类型</option>
																<option value="1">三厢车</option>
																<option value="2">两厢车</option>
																<option value="3">SUV</option>
																<option value="4">原装进口</option>
																
															</select>
															
														</div>

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="name">车系名称</label>

													<div class="controls">

														<input dataType="Require" msg="车系名称必须填写" id="name" name="name" value="" type="text" placeholder="车系名称" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="en_name">车系英文名称</label>

													<div class="controls">

														<input dataType="Require" msg="车系英文名称必须填写" id="en_name" name="en_name" value="" type="text" placeholder="车系英文名称" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="banner_link">车系首页图链接</label>

													<div class="controls">

														<input id="banner_link" name="banner_link" value="" type="text" placeholder="车系首页图链接" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="discount_max">最大优惠(分)</label>

													<div class="controls">

														<input id="discount_max" name="discount_max" value="" type="text" placeholder="最大优惠" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="discount_max_pid">最大优惠车型id</label>

													<div class="controls">

														<input id="discount_max_pid" name="discount_max_pid" value="" type="text" placeholder="最大优惠车型id" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="discount_min">最小优惠(分)</label>

													<div class="controls">

														<input id="discount_min" name="discount_min" value="" type="text" placeholder="最小优惠" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="discount_min_pid">最小优惠车型id</label>

													<div class="controls">

														<input id="discount_min_pid" name="discount_min_pid" value="" type="text" placeholder="最小优惠车型id" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="price_min">车型最低指导价(分)</label>

													<div class="controls">

														<input id="price_min" name="price_min" value="" type="text" placeholder="车型最低指导价" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="price_max">车型最高指导价(分)</label>

													<div class="controls">

														<input id="price_max" name="price_max" value="" type="text" placeholder="车型最高指导价" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="description">车系简介</label>

													<div class="controls">

														<input id="description" name="description" value="" type="text" placeholder="车系简介" class="m-wrap span6" />

													</div>

												</div>
												
												<div class="control-group policyBox">

													<label class="control-label" for="policy">优惠政策</label>

													<div class="controls">
														<input id="policy" name="policy[0][policy_name]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span3 policy_input" />

														<input name="policy[0][policy_name_min]" value="" type="text" placeholder="优惠政策短标10个字以内" class="m-wrap span3 policy_input" />

														<input name="policy[0][url]" value="" type="text" placeholder="跳转地址" class="m-wrap span3" />
														<input name="pic_path0" type="file" class="default" />
														<div class="clearfix"></div><br/>

														<input name="policy[1][policy_name]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span3 policy_input" />
														
														<input name="policy[1][policy_name_min]" value="" type="text" placeholder="优惠政策短标10个字以内" class="m-wrap span3 policy_input" />

														<input name="policy[1][url]" value="" type="text" placeholder="跳转地址" class="m-wrap span3" />
														<input name="pic_path1" type="file" placeholder="" class="default" />
														<div class="clearfix"></div><br/>

														<input name="policy[2][policy_name]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span3 policy_input" />

														<input name="policy[2][policy_name_min]" value="" type="text" placeholder="优惠政策短标10个字以内" class="m-wrap span3 policy_input" />

														<input name="policy[2][url]" value="" type="text" placeholder="跳转地址" class="m-wrap span3" />
														<input name="pic_path2" type="file" placeholder="" class="default" />
														<span class="help-inline">&nbsp;<a class="icon-plus" onclick="return addPolicy(this);" style="font-size: 16px; " href=""> </a></span>
														
														<span class="help-inline hide policyErrorText">优惠政策必须最少填写3个,并在2-10个字之间</span>
													</div>

												</div>

												<div class="control-group">

													<label class="control-label" for="rec_index">排序</label>

													<div class="controls">

														<input id="rec_index" name="rec_index" value="0" type="text" placeholder="排序" class="m-wrap span6" />

													</div>

												</div>

												<div class="control-group">

													<label class="control-label" >状态</label>

													<div class="controls">

														<div class="select2-wrapper">

															<select name="isactive" class="span3 select2_category" tabindex="1">

																<option value="1">启用</option>
																<option value="0">禁用</option>
																<option value="2">下架</option>
																
															</select>
															
														</div>

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

											<tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody>

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

	<script src="<{$js_path}>form-fileupload.js"></script>

	<script type="text/javascript">

		jQuery(document).ready(function() {       

		   	FormSamples.init();

        	FormFileUpload.init({'sessionName':'series'});
		});

	</script>
    
 <script type="text/javascript">


var startInt = 3;
function addPolicy(obj)
{
	var $this = $(obj);
	var addTtml = '<div class="clearfix"></div><br/><input id="policy" name="policy['+startInt+'][policy_name]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span3 policy_input inputList'+startInt+'" /> <input name="policy['+startInt+'][policy_name_min]" value="" type="text" placeholder="优惠政策短标10个字以内" class="m-wrap span3 policy_input inputList'+startInt+'" /> <input name="policy['+startInt+'][url]" value="" type="text" placeholder="跳转地址" class="m-wrap span3 inputList'+startInt+'" /> <input name="pic_path'+startInt+'" type="file" placeholder="" class="default inputList'+startInt+'" /> <span class="help-inline">&nbsp;<a class="icon-plus" onclick="return addPolicy(this);" style="font-size: 16px; " href=""> </a>&nbsp;&nbsp;<a class="icon-minus" onclick="return removePolicy(this ,'+startInt+');" href=""> </a></span>';
	startInt++;
	$this.parents('div.controls').append(addTtml);
	return false;
}

function removePolicy(obj ,tindex)
{
	var $this = $(obj);
	
	$this.parent('span.help-inline').prev('input').prev('input').prev('input').prev('input').prev('br').prev('div.clearfix').remove();
	$this.parent('span.help-inline').prev('input').prev('input').prev('input').prev('input').prev('br').remove();
	$('.inputList'+tindex).remove();
	$this.parent('span.help-inline').remove();

	return false;
}



function submit_form(){
	var form_ob=document.getElementById("dataform");
	var policy_check = true;

	var policyObj = $('input.policy_input');

	policyObj.each(function(){
		var tv = $(this).val();
		if(tv == '' || (tv != '' && (tv.length > 10 || tv.length < 2)))
		{
			policy_check = false;
			return false;
		}
	});

	if((!Validator.Validate(form_ob,4)))
	{
		return false;
	}	

	if(policy_check == false)
	{
		$('.policyErrorText').show();
		$('.policyBox').addClass('error');
		return false;
	}else
	{
		$('.policyErrorText').hide();
		$('.policyBox').removeClass('error');
	}	

	form_ob.submit();
}


</script>
    
</body>
<!-- END BODY -->

</html>