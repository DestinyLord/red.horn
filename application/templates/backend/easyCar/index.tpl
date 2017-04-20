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

					<div class="span12">
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
										<{if check_priv('easyCarAdd')}>
                                        <a href="<{site_url uri=$backendDir|cat:'/easyCar/easyCarEdit'}>" id="sample_editable_1_new" class="btn green" style="margin-right:10px;">

                                        新增活动 <i class="icon-plus"></i>

                                        </a>
										<{/if}>
                                    </div>
                                    
								</div>

								<table class="table table-striped table-bordered table-hover" id="sample_4">

									<thead>

										<tr>
                                        
                                            <th>NO</th>
                                                                                 
											<th>活动主题</th>
                                            
											<th>活动地区</th>

											<th>活动车型</th>

                                            <th>订金</th>

                                            <th>活动结束时间</th>
                                            
                                            <th>活动状态</th>
                                            
                                            <th>操作</th>

										</tr>

									</thead>

									<tbody>

                                        <{if $datas}>
                                            <{assign var='i' value="1"}>
                                            <{foreach from=$datas.lists item=v}>
        										<tr class="odd gradeX">
                                                
                                                    <td><{$i++}></td>
                                                    
                                                    <td><{$v.title}></td>
        
        											<td><{$v.area}></td>
        
        											<td><{$v.model}></td>
                                                    
                                                    <td>￥<{sprintf("%.2f", $v.earnest/100)}></td>
        
                                                    <td><{date('Y年m月d日',$v.end_date)}></td>
                                                    
                                                    <td><{if $v.status==0}>下架
                                                        <{elseif $v.status==1 && $v.end_date < time()}>已过期
                                                        <{elseif $v.status == 1 && $v.end_date > time()}>上架
                                                        <{/if}></td>
                                                    
                                                    <td>
                                                    	<{if check_priv('easyCarEdit')}>
                                                        <a href="<{site_url uri=$backendDir|cat:'/easyCar/easyCarEdit/'|cat:$v.id}>">编辑</a>&nbsp;&nbsp;
                                                        <{/if}>
                                                        <{if check_priv('easyCarStatusOperation')}>
                                                        <a href="<{site_url uri=$backendDir|cat:'/easyCar/easyCarSave/'}>?id=<{$v.id}>&status=<{1-$v.status}>"><{if $v.status==0}>上架<{elseif $v.status == 1}>下架<{/if}></a>
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