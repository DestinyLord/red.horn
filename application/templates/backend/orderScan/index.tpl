<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--[if IE 8]> <html xmlns="http://www.w3.org/1999/xhtml" lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html xmlns="http://www.w3.org/1999/xhtml" lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html xmlns="http://www.w3.org/1999/xhtml" lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>
    <{include file= $backendViewDir|cat:'/common/head.tpl'}>

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="<{$css_path}>select2_metro.css" />
    
	<link rel="stylesheet" href="<{$css_path}>DT_bootstrap.css" />
    
    <link rel="stylesheet" type="text/css" href="<{$css_path}>jquery-ui-1.10.1.custom.min.css"/>
    
    <link rel="stylesheet" type="text/css" href="<{$css_path}>pagination-style.css"/>
    <script src="//cdn.bootcss.com/jquery/1.8.3/jquery.min.js"></script>

    <script src="//cdn.bootcss.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
  
    <script src="//cdn.bootcss.com/bootbox.js/4.4.0/bootbox.min.js"></script>
	<!-- END PAGE LEVEL STYLES -->

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

						</h3>

						<{$breadCurumbs|getBackendBreadCrumbs}>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">

					
					<!-- BEGIN EXAMPLE TABLE PORTLET-->

					<div class="portlet box light-grey">

						<div class="portlet-title">

							<div class="caption">
                            
                                <i class="icon-globe"></i>
                                
                                <{$h3title}>列表
                                
                            </div>
                            

						</div>

						<div class="portlet-body">

							<div class="clearfix">
                                
                                <div class="btn-group">
                                    <div class="col-sm-3">
                                    </div>
                                    
                                        
                                    
                                    <div class="col-sm-3">
                                        
                                          
                                    </div>
                                </div>
                                
							</div>
							<div class="tabbable tabbable-custom boxless">
                                <ul class="nav nav-tabs">
                                    <{foreach from=$scan_status key=sanKey item=sanItem }>
<li <{if $act == $sanKey}>class="active"<{/if}>><a href="?act=<{$sanKey}>"><{$sanItem}></a></li>

                                          <{/foreach}>
								</ul>
								

								<div class="tab-content">
                                    
									<div class="tab-pane active" id="tab_1">
                                        <table class="table table-hover table-bordered" style="margin-top: 10px;">
                                          <thead>
                                            <tr>
                                              <th>&nbsp;</th>
                                              <th>门店编码</th>
                                              <th>买家帐号</th>
                                              <th>收款帐号</th>
                                              <th>支付金额</th>
                                              <th>订单状态</th>
                                              <th>下单时间</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                        
                                        <{foreach from=$data['lists'] item=listItem}>
                                            <tr>
                                                <td class="text-center"><{$listItem['id']}></td>
                                                <td><{$listItem['identifier']}></td>
                                                <td><{$listItem['buyer_email']}></td>
                                                <td><{$listItem['seller_email']}></td>
                                                <td>￥<{moneyFormat($listItem['fee'])}></td>
                                                <td class="text-center"><{$scan_status[$listItem['status']]}></td>
                                                <td class="text-center"><{date('Y-m-d H:i:s',$listItem['dateline'])}></td>
                                            </tr>
                                        <{/foreach}>
                                        </tbody>
                                        </table>
									
                                        
                                       <ul class="pagination"><{$data['multi']}></ul>
                                        
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

	<script type="text/javascript" src="<{$js_path}>jquery.dataTables.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->



</body>
<!-- END BODY -->

</html>