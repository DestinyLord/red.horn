<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<meta charset="utf-8" />

	<title>404 找不到页面</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<meta content="" name="description" />

	<meta content="" name="author" />

	<!-- BEGIN GLOBAL MANDATORY STYLES -->

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/uniform.default.css" rel="stylesheet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link href="/themes/<?php echo CURRENT_THEME; ?>/css/error.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->


</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-404-3">

	<div class="page-inner">

		<img src="/themes/<?php echo CURRENT_THEME; ?>/images/earth.jpg" alt=""/>

	</div>

	<div class="container error-404">

		<h1>404</h1>

		<h2>找不到这个页面</h2>

		<p>
			您想查看的页面飞到外太空去了^_^

		</p>

		<p>

			<a href="#" class="backup">返回</a>

			<br/>

		</p>

	</div>



<!-- END BODY -->

</html>
<script src="/themes/<?php echo CURRENT_THEME; ?>/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
    $('.backup').click(function(){
        history.go(-1);
    })
})
</script>