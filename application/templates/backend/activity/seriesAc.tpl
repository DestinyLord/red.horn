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
								<form method="get" action="" class="form-horizontal">
                                                                  
                                    <div class="span4">
                                        <div class="control-group">

                                            <label class="control-label" for="add_time">发布时间：</label>

                                            <div class="controls">

                                                <div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="add_time" name="add_time" readonly size="16" type="text" value="<{$addTime}>" /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>

                                            </div>

                                        </div>
                                    </div>
                                    
                                    <div class="span4">
                                        <div class="control-group">

                                            <label class="control-label">操作人：</label>

                                            <div class="controls">

                                                <select name="operate_admin_id" class="m-wrap span12">
													<option value="">请选择操作人</option>
													<{foreach from=$adminList item=admin}>
													<option <{if $adminId == $admin.id}>selected<{/if}> value="<{$admin.id}>"><{if $admin.surname}><{$admin.surname}><{else}><{$admin.username}><{/if}></option>
													<{/foreach}>
												</select>

                                            </div>

                                        </div>
                                    </div>
                                    
                                    <div class="span4">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input type="submit" value="筛选" class="m-wrap btn btn-primary">
                                                <input type="reset" value="重置" class="m-wrap btn">
                                            </div>
                                        </div>
                                    </div>

                                
                                </form>
								<div class="clearfix">
                                    
                                    <div class="btn-group">
										<{if check_priv('seriesAcAdd')}>
                                        <a href="<{site_url uri=$backendDir|cat:'/activity/seriesAcEdit'}>" class="btn green" style="margin-right:10px;">

                                        新增活动 <i class="icon-plus"></i>

                                        </a>
										<{/if}>
                                    </div>
                                    
								</div>

								<table class="table table-striped table-bordered table-hover" id="sample_3">

									<thead>

										<tr>
                                        
                                            <th>NO</th>
                                                                                 
											<th>活动主题</th>
                                            
											<th>图片</th>

											<th>活动车系</th>

                                            <th>启止时间</th>

                                            <th>留资Key值</th>
                                            
                                            <th class="hidden-480">页面地址</th>
                                            
                                            <th>状态</th>
                                            
                                            <th>操作</th>

										</tr>

									</thead>

									<tbody>

                                        <{if $datas}>
                                            <{assign var='i' value="1"}>
                                            <{foreach from=$datas.lists item=v}>
        										<tr class="odd gradeX">
                                                
                                                    <td><{$i++}></td>
                                                    
                                                    <td><{$v.activity_name}></td>
        
        											<td><img src="/<{$v.main_picture}>" height="60" width="90"/></td>
        
        											<td>
                                                        <{foreach from=json_decode($v.series_id) item=s}>
                                                            <{$seriesList[$s]['name']}><br />
                                                        <{/foreach}>
                                                    </td>
        
                                                    <td><{date('Y年m月d日',$v.begin_time)}><br /><{date('Y年m月d日',$v.end_time)}></td>
                                                    
                                                    <td><{$v.leads_key}></td>
                                                    
                                                    <td class="hidden-480"><a target="_blank" href="https://df.shopmodule.jaeapp.com/index.php/<{if $v.type == 2}>wap<{/if}>active/seriesAc/<{$v.id}>">https://df.shopmodule.jaeapp.com/index.php/<{if $v.type == 2}>wap<{/if}>active/seriesAc/<{$v.id}></a></td>
                                                    
                                                    <td>
                                                        <{if $v.status==0}>下架
                                                        <{elseif $v.status==1 && $v.end_time < time()}>已过期
                                                        <{elseif $v.status == 1 && $v.end_time > time()}>上架
                                                        <{/if}>
                                                    </td>
                                                    
                                                    <td>
                                                    	<{if check_priv('seriesAcEdit')}>
                                                        <a href="<{site_url uri=$backendDir|cat:'/activity/seriesAcEdit/'|cat:$v.id}>">编辑</a>&nbsp;&nbsp;
                                                        <a href="<{site_url uri=$backendDir|cat:'/activity/seriesAcSave'}>?id=<{$v.id}>&status=<{1-$v.status}>"><{if $v.status==0}>上架<{elseif $v.status == 1}>下架<{/if}></a>
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

	<script type="text/javascript" src="<{$js_path}>bootstrap-datepicker.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>table-managed.js"></script>     
	<script>
        jQuery(document).ready(function(e) {
            TableManaged.init();

            $('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd' ,'minDate':'<{date("Y-m-d")}>'});
            
		});
        
	</script>

</body>
<!-- END BODY -->

</html>