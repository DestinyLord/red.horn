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
                                
                                <{$mainInfo.title}> - <{$h3title}>列表
                                
                            </div>
                            

						</div>

						<div class="portlet-body">
							<div class="clearfix">
                                
                                <div class="btn-group">
                                    
                                    <{if check_priv('prizeDetailAdd')}>
                                    <a href="<{site_url uri=$backendDir|cat:'/prize/detailAdd/'|cat:$mainInfo.id}>" id="sample_editable_1_new" class="btn green">

                                    添加奖项 <i class="icon-plus"></i>

                                    </a>
                                    <{/if}>
                                </div>
                                
							</div>
							<table class="table table-striped table-bordered table-hover" id="sample_4">

								<thead>

									<tr>
                                    
                                        <th>ID</th>
                                
										<th>奖品名称</th>

										<th>总量</th>

                                        <th>剩余数量</th>

                                        <th>每日上限（0为无上限）</th>

                                        <th>概率</th>

                                        <th>活动开始时间</th>

                                        <th>活动结束时间</th>

                                        <th>奖项排序</th>

                                        <th>抽奖模块位置</th>
                                        
                                        <th>操作</th>

									</tr>

								</thead>

								<tbody>
									<{if isset($datas)}>
                                    <{foreach from=$datas item=v}>
									<tr class="odd gradeX">
                                    
                                        <td><{$v.id}></td>
                                        
                                        <td>
                                            <{$v.name}>
                                        </td>

										<td><{$v.totality}></td>
                                        
                                        <td><{$v.rest}></td>
                                        
                                        <td><{$v.daily_limit}></td>

                                        <td><{$v.rate}></td>

                                        <td><{$v.begin_time|date_format:"%Y-%m-%d"}></td>

                                        <td><{$v.end_time|date_format:"%Y-%m-%d"}></td>

                                        <td><{$v.sort}></td>

                                        <td><{$v.module}></td>
                                        
                                        <td>
                                        	<{if check_priv('prizeDetailEdit')}>
                                            <a href="<{site_url uri=$backendDir|cat:'/prize/detailEdit/'|cat:$v.id}>">编辑</a>
                                            <{/if}>
                                            &nbsp;&nbsp;
                                            <{if check_priv('prizeDetailDel')}>
                                            <a class=" confirm_opener" href="<{site_url uri=$backendDir|cat:'/prize/detailDelete?id='|cat:$v.id}>" title="删除">删除</a>
                                            <{/if}>
                                        </td>

									</tr>
                                    <{/foreach}>
                                    <{/if}>

								</tbody>

							</table>

						</div>

						<!-- END EXAMPLE TABLE PORTLET-->
						<!-- DIALOG BOX BEGIN  -->
                        <div class="portlet-body form">
                            <div id="dialog_confirm" title="删除记录" class="hide">

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

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>table-managed.js"></script>   
	<script src="<{$js_path}>ui-jqueryui.js"></script>   
	<script>
        jQuery(document).ready(function(e) {
            TableManaged.init();
            UIJQueryUI.init();
		});
        
	</script>

</body>
<!-- END BODY -->

</html>