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

<script src="<{$js_path}>jquery.cookie.min.js" type="text/javascript"></script>

<script src="<{$js_path}>jquery.uniform.min.js" type="text/javascript" ></script>

<!-- END CORE PLUGINS -->
<script src="<{$js_path}>app.js"></script>      

<script>

	jQuery(document).ready(function() {    

	   App.init();

	});

</script>

<!-- END JAVASCRIPTS -->