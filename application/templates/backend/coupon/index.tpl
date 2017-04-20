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
                                    
                                    <{if check_priv('couponAdd')}>
                                    <a href="<{site_url uri=$backendDir|cat:'/coupon/couponEdit'}>?type=<{$type}>" id="sample_editable_1_new" class="btn green">

                                    添加<{$couponType[$type]}> <i class="icon-plus"></i>

                                    </a>
                                    <{/if}>
                                </div>
                                
							</div>
							<div class="tabbable tabbable-custom boxless">

								<ul class="nav nav-tabs">
                                
                                    <{foreach from=$couponType key=key item=v}>

									<li <{if $key == $type}> class="active" <{/if}>>
                                        <a href="/index.php/backend/coupon/index/<{$key}>.html"><{$v}></a>
                                    </li>
                                    
                                    <{/foreach}>

								</ul>

								<div class="tab-content">
                                    
									<div class="tab-pane active" id="tab_1">
                                    
										<table class="table table-striped table-bordered table-hover" id="sample_4">

											<thead>

												<tr>
		                                        
		                                            <th>NO</th>
		                                    
													<th>适用车型</th>

													<th>券金额</th>

													<th>券定金</th>

													<th>已售出</th>
                                                    
                                                    <{if $type==1 || $type==2}>
                                                        <th>口令</th>
                                                    <{elseif $type==3}>
                                                        <th>每期需参与人数</th>
                                                    <{/if}>

		                                            <th>发布时间</th>
                                                    
                                                    <{if $type==1 || $type==2}>
                                                        <th>开抢时间</th>
                                                    <{/if}>
                                                    
                                                    <th>排序</th>
                                                    
                                                    <th>状态</th>
		                                            
		                                            <th>操作</th>

												</tr>

											</thead>

											<tbody>
												<{if isset($datas.lists)}>
                                                    <{assign var='i' value="1"}>
    		                                        <{foreach from=$datas.lists item=v}>
        												<tr class="odd gradeX">
        		                                        
        		                                            <td><{$i++}></td>
        		                                            
        		                                            <td>
        		                                                <{foreach from=json_decode($v.series_id) item=s}>
                                                                    <{$seriesList[$s]['name']}><br />
                                                                <{/foreach}>
        		                                            </td>
        
        													<td>￥<{$v.price}></td>
        
        													<td>￥<{$v.sell_price}></td>
        
        													<td><{$v.totality-$v.stock}></td>
                                                            
                                                            <{if $type==1 || $type==2}>
                                                                <td><{$v.command}></td>
                                                            <{elseif $type==3}>
                                                                <td><{$v.need_user}></td>
                                                            <{/if}>
        		                                            
        		                                            <td><{date("Y-m-d ", $v.add_time)}></td>
                                                            
                                                            <{if $type==1 || $type==2}>
                                                                <td><{$v.grab}></td>
                                                            <{/if}>
                                                            
                                                            <td><{$v.sort}></td>
                                                            
                                                            <td>
                                                                <{if $v.status==0}>下架
                                                                <{elseif $v.status==1 && $v.end_time < time()}>已过期
                                                                <{elseif $v.status == 1 && $v.end_time > time()}>上架
                                                                <{/if}>
                                                            </td>
        		                                            
        		                                            <td>
        		                                            	 <{if check_priv('couponEdit')}>
                                                                 [<a href="<{site_url uri=$backendDir|cat:'/coupon/couponEdit/'|cat:$v.id}>?type=<{$type}>">编辑</a>]
                                                                 [<a href="<{site_url uri=$backendDir|cat:'/coupon/couponSave'}>?id=<{$v.id}>&status=<{1-$v.status}>"><{if $v.status==0}>上架<{elseif $v.status == 1}>下架<{/if}></a>]
        		                                                 <{/if}>
        		                                            </td>
        
        												</tr>
    		                                        
    		                                        <{/foreach}>
		                                        <{/if}>

											</tbody>

										</table>
                                        
                                        <ul class="pagination"><{$datas['multi']}></ul>
                                        
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

	<script src="<{$js_path}>table-managed.js"></script>     
	<script>
        jQuery(document).ready(function(e) {
            TableManaged.init();
            
		});
        
	</script>

</body>
<!-- END BODY -->

</html>