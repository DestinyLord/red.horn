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

    <link rel="stylesheet" type="text/css" href="<{$css_path}>datepicker.css" />

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
                                
	                                 <{if check_priv('articleAdd')}>
									<div class="btn-group">

										<a href="<{site_url uri=$backendDir|cat:'/article/add'}>" class="btn green">

										添 加 <i class="icon-plus"></i>

										</a>
                                        
									</div>
                                    <{/if}>
	                                
								</div>

								<table class="table table-striped table-bordered table-hover" id="sample_3">

									<thead>

										<tr>
                                        	<th>ID</th>
                                        	
                                            <th class="hidden-480">文章标题</th>
                                                                                 
											<th>主图</th>
                                            
											<th>成交台数</th>

											<th>喜欢数量</th>

											<th>没劲数量</th>

                                            <th class="hidden-480">发布时间</th>
                                            
                                            <th class="hidden-480">添加日期</th>

                                            <th>操作</th>

										</tr>

									</thead>

									<tbody>

                                        <{if $datas.lists}>
                                            <{assign var='i' value="1"}>
                                            <{foreach from=$datas.lists item=v}>
        										<tr class="odd gradeX">
                                                
                                                    <td class="hidden-480"><{$i++}></td>
                                                    
                                                    <td><{$v.title|urldecode}></td>
        
        											<td><img width="80" height="50" alt="主图" src="<{base_url uri=$v.main_picture}>" /></td>
        
        											<td><{$v.deal_num}></td>
        											
        											<td><{$v.praise}></td>

                                                    <td class="hidden-480"><{$v.derogatory}></td>
                                                   
                                                    <td class="hidden-480"><{$v.issue_time|date_format:'%Y-%m-%d'}></td>
                                                    
                                                    <td class="hidden-480"><{$v.add_time|date_format:'%Y-%m-%d'}></td>

                                                    <td>
														<{if check_priv('articleEdit')}>
                                                    	<a href="<{site_url uri=$backendDir|cat:'/article/edit/'|cat:$v.id}>">修改</a> 
                                                    	<{/if}>
                                                    	<{if check_priv('articleDel')}>
                                                    	| <a class=" confirm_opener"  href="<{site_url uri=$backendDir|cat:'/article/delete?id='|cat:$v.id}>">删除</a>
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
                        <!-- DIALOG BOX BEGIN  -->
                        <div class="portlet-body form">
                            <div id="dialog_confirm" title="删除菜单" class="hide">

								<p><span class="icon icon-warning-sign"></span>

									确定要删除吗？

								</p>

							</div>
                        </div>
                        <!-- DIALOG BOX END  -->                                                 
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

	<script type="text/javascript" src="<{$js_path}>bootstrap-datepicker.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>table-managed.js"></script> 
	<script src="<{$js_path}>ui-jqueryui.js"></script>     
	<script>
        jQuery(document).ready(function(e) {
            TableManaged.init();
            UIJQueryUI.init();

            $('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd' ,'minDate':'<{date("Y-m-d")}>'});
            
		});
        
	</script>

</body>
<!-- END BODY -->

</html>