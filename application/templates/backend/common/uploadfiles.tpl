<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>上传图片</title>

<link href="<{$css_path}>bootstrap.min.css" rel="stylesheet" type="text/css"/>

<link href="<{$css_path}>bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

<link href="<{$css_path}>font-awesome.min.css" rel="stylesheet" type="text/css"/>

<link href="<{$css_path}>style-metro.css" rel="stylesheet" type="text/css"/>

<link href="<{$css_path}>style.css" rel="stylesheet" type="text/css"/>

<link href="<{$css_path}>style-responsive.css" rel="stylesheet" type="text/css"/>

<link href="<{$css_path}><{if $backendStyleColor}><{$backendStyleColor}><{else}>default<{/if}>.css" rel="stylesheet" type="text/css" id="style_color"/>


<link href="<{$css_path}>uniform.default.css" rel="stylesheet" type="text/css"/>


<link href="<{$css_path}>jquery.fileupload-ui.css" rel="stylesheet" />

<style type="text/css">
	html ,body{
		background: #fff;
	}
	#fileupload {
		background: #fff;
	}
</style>
</head>
<body>

<form id="fileupload" action="" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data" name="uploadform" >
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
			<{foreach from=$images key=k item=img}>
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

		            <button class="btn red" data-type="GET" data-url="<{site_url uri=$backendDir|cat:'/'|cat:$delUrl}>?id=<{$k}>">

		                <i class="icon-trash icon-white"></i>

		                <span>删除</span>

		            </button>

		            

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
</form>
</body>
</html>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<script type="text/javascript">
var baseUrl = '<{base_url}>';
var siteUrl = '<{site_url|rtrim:$urlSuffix}>';
var backendDir = '<{$backendDir}>';
var cssUrl = '<{$css_path}>';
var jsUrl = '<{$js_path}>';
var imageUrl = '<{$image_path}>';
var loadingImagePath=imageUrl+"loading.gif";
</script>

<!-- BEGIN CORE PLUGINS -->

<script src="<{$js_path}>jquery-1.10.1.min.js" type="text/javascript"></script>

<script src="<{$js_path}>jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

<script src="<{$js_path}>jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

<script src="<{$js_path}>bootstrap.min.js" type="text/javascript"></script>

<!--[if lt IE 9]>

<script src="<{$js_path}>excanvas.min.js"></script>

<script src="<{$js_path}>respond.min.js"></script>  

<![endif]-->   

<script src="<{$js_path}>jquery.slimscroll.min.js" type="text/javascript"></script>

<script src="<{$js_path}>jquery.blockui.min.js" type="text/javascript"></script>  


<script src="<{$js_path}>jquery.uniform.min.js" type="text/javascript" ></script>

<!-- END CORE PLUGINS -->
<script src="<{$js_path}>app.js"></script>      

<script>

	jQuery(document).ready(function() {    

	   App.init();
	});

</script>




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

	<!--[if gte IE 8]><script src="<{$js_path}>jquery.xdr-transport.js"></script><![endif]-->

	<!-- END:File Upload Plugin JS files-->

	<!-- END PAGE LEVEL PLUGINS -->

	<script src="<{$js_path}>form-fileupload.js"></script>

	<script type="text/javascript">

		jQuery(document).ready(function() {       
        	FormFileUpload.init({'sessionName':'<{$uploadName}>'});

		});

	</script>
