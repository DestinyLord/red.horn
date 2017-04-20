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
                                    
                                    <{$h3title}>列表 <{if isset($orders.total)}>( 总数<{$orders.total}> )<{/if}>
                                    
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

                                        <div class="control-group">

                                            <label class="control-label " style="width:80px;" for="customer_tel">类型：</label>

                                            <div class="controls" style="margin-left:80px;">
											
												<select name="type" class="span6 select2_category">
													<option value="">请选择</option>
													<option <{if $type == 1}>selected="true"<{/if}> value="1">一口价</option>
													<option <{if $type == 2}>selected="true"<{/if}> value="2">车团长</option>
												</select>
												
                                            </div>

                                        </div>
                                    </div>
									<div class="span5">
                                        <div class="control-group">

                                            <label class="control-label" style="width:80px;" for="start_time">下单时间：</label>

                                            <div class="controls" style="margin-left:80px;">

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
                                    <div class="span2">
                                        <div class="control-group">

                                            <label class="control-label" style="width:80px;" for="verify_status">订单状态：</label>

                                            <div class="controls" style="margin-left:80px;width:100px;">
												<select name="verify_status" class="span12 select2_category">
													<option value="">请选择</option>
													<option <{if $verifyStatus == 1}>selected="true"<{/if}> value="1">未跟进</option>
													<option <{if $verifyStatus == 2}>selected="true"<{/if}> value="2">未核销</option>
													<option <{if $verifyStatus == 3}>selected="true"<{/if}> value="3">已核销</option>
												</select>
                                                
                                            </div>

                                        </div>
                                    </div>
                                    
                                    <div class="span2">
                                        <div class="control-group">
                                            <div class="controls" style="margin-left:20px;">
                                                <input type="hidden" class="export-input" name="export" value="0" />
                                                <input type="hidden" name="export_type" value="dealer_order" />
                                                <input type="submit" value="筛选" class="m-wrap btn btn-primary">
                                                <a href="<{site_url uri=$backendDir|cat:'/vipdealer/orders'}>" class="m-wrap btn">重置</a>
                                            </div>
                                        </div>
                                    </div>
                                    <{if empty($dealerId)}>
                                    <div class="btn-group pull-right">

                                        <button class="btn dropdown-toggle" data-toggle="dropdown">工具 <i class="icon-angle-down"></i>

                                        </button>

                                        <ul class="dropdown-menu pull-right">
                    
                                            <li><a href="#" class="export-button">导出到EXCEL</a></li>

                                        </ul>

                                    </div>
                                    <{/if}>
                                
                                </form>
								<table class="table table-striped table-bordered table-hover" id="sample_4">

									<thead>

										<tr>
                                        
                                            <th>NO</th>
                                            <{if empty($dealerId)}>
											<th>经销商</th>
											<{/if}>
											<th>类型</th>

											<th>姓名</th>

											<th>电话</th>

											<th>性别</th>

                                            <th>意向车系</th>

                                            <th>下单时间</th>
                                            
                                            <th>订单状态</th>
                                            
                                            

										</tr>

									</thead>

									<tbody>

                                        <{if $orders.lists}>
                                        <{assign var='i' value="1"}>
                                        <{foreach from=$orders.lists item=v}>
										<tr class="odd gradeX">
                                        
                                            <td><{$i++}></td>
                                            <{if empty($dealerId)}>
                                            <td><{$v.dealer_name_short}></td>
                                            <{/if}>
                                            <td><{if in_array($v.leads_key ,array('NV-Tmall-Pc-V2-Ch-Le-PoC-Msg34-01-0000' ,'NV-Tmall-Wap-V2-Ac-Le-PoC-Msg34-01-0000'))}>车团长<{else}>一口价<{/if}></td>
                                            <td>
                                                <{$v.customer_name}>
                                            </td>

											<td><{$v.customer_tel}></td>

											<td><{if $v.sex == 1}>男<{else}>女<{/if}></td>
                                            
                                            <td><{$v.name}></td>

                                            <td><{$v.addTime|date_format:"%Y-%m-%d %H:%M:%S"}></td>
                                            
                                            <td><{if $v.verify_status == 1}>未跟进<{else if $v.verify_status == 2}>未核销<{else}>已核销 <{if $v.verify_time}>(<{$v.verify_time|date_format:"%Y-%m-%d %H:%M:%S"}>)<{/if}><{/if}></td>
                                            
										</tr>
                                        
                                        <{/foreach}>
                                        <{/if}>

									</tbody>

								</table>
                                
                                <ul class="pagination"><{$orders['multi']}></ul>
                                
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