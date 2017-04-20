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
								<form method="get" action="" class="form-horizontal search-form">
                                    
                                    <div class="span3">
                                        <div class="control-group">

                                            <label class="control-label " style="width:80px;" for="customer_tel">手机号码：</label>

                                            <div class="controls" style="margin-left:80px;">

												<input class="m-wrap span12" id="customer_tel" name="customer_tel" type="text" value="<{$tel}>" />
                                            </div>

                                        </div>
                                    </div>

                                    <div class="span6">
                                        <div class="control-group">

                                            <label class="control-label" for="start_time">发布时间：</label>

                                            <div class="controls">

                                                <div class="input-append date date-picker span4" >

													<input class="m-wrap m-ctrl-medium date-picker span12" id="start_time" name="start_time" readonly type="text" value="<{$startTime}>" /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
												
												<div class="span1"></div>
											
												<div class="input-append date date-picker span4" >

													<input class="m-wrap m-ctrl-medium date-picker span12" id="end_time" name="end_time" readonly type="text" value="<{$endTime}>" /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>

                                            </div>

                                        </div>
                                    </div>
                                    
                                    <div class="span3">
                                        <div class="control-group">
                                            <div class="controls" style="margin-left:80px;">
                                                <input type="hidden" class="export-input" name="export" value="0" />
                                                <input type="hidden" name="export_type" value="luck" />
                                                <input type="submit" value="筛选" class="m-wrap btn btn-primary">
                                                <input type="reset" value="重置" class="m-wrap btn">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="btn-group pull-right">

                                        <button class="btn dropdown-toggle" data-toggle="dropdown">工具 <i class="icon-angle-down"></i>

                                        </button>

                                        <ul class="dropdown-menu pull-right">
                    
                                            <li><a href="#" class="export-button">导出到EXCEL</a></li>

                                        </ul>

                                    </div>    
                                
                                </form>

								<table class="table table-striped table-bordered table-hover" id="sample_3">

									<thead>

										<tr>
                                        
                                            <th class="hidden-480">序号</th>
                                                                                 
											<th>活动主题</th>
                                            
											<th>客户姓名</th>

											<th>手机号码</th>

											<th>券额</th>

                                            <th class="hidden-480">车型</th>

                                            <th class="hidden-480">专营店</th>
                                            
                                            <th class="hidden-480">日期</th>

										</tr>

									</thead>

									<tbody>

                                        <{if $datas.lists}>
                                            <{assign var='i' value="1"}>
                                            <{foreach from=$datas.lists item=v}>
        										<tr class="odd gradeX">
                                                
                                                    <td class="hidden-480"><{$i++}></td>
                                                    
                                                    <td><{$v.leads_name}></td>
        
        											<td><{$v.customer_name}></td>
        
        											<td><{if $dealerId == $v.dealer_id}><{$v.customer_tel}><{else}><{preg_replace('/(\d{4})\d{4}(\d{3})/' ,'$1****$2' ,$v.customer_tel)}><{/if}></td>
        											
        											<td><{$v.promotions_json}></td>

                                                    <td class="hidden-480"><{$v.name}></td>
                                                    
                                                    <td class="hidden-480"><{$v.dealer_name_short}></td>
                                                    
                                                    <td class="hidden-480"><{date('Y-m-d H:i:s',$v.addTime)}></td>
        
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
            
            $('.export-button').click(function(){
                $('.export-input').val(1);
                $('.search-form').submit();
            });
		});
        
	</script>

</body>
<!-- END BODY -->

</html>