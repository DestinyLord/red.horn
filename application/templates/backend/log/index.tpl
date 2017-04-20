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
							<{$h3title}>

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

								<div class="caption"><i class="icon-globe"></i><{$h3title}>列表</div>

								<!--<div class="tools">

									<a href="javascript:;" class="collapse"></a>

									<a href="#portlet-config" data-toggle="modal" class="config"></a>

									<a href="javascript:;" class="reload"></a>

									<a href="javascript:;" class="remove"></a>

								</div>-->

							</div>

							<div class="portlet-body">

                                
                                <div class="clearfix">

                                    <div class="span2">
                                        <div class="select2-wrapper">

											<select data-column="1" name="user_id" class="span12 select2_category column_filter" placeholder="操作人">

												<option value="" filter=""></option>
                                                <{foreach from = $adminUser item=v}>
												<option value="<{$v.id}>"  filter="<{$v.username}>">
                                                    <{if $v.parent_id > 0}>
                                                    <{'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'|str_repeat:$v.level}> |-- 
                                                    <{/if}>
                                                    <{$v.username}>
                                                </option>
                                                <{/foreach}>

											</select>
                                        
                                        </div>
                                    </div>
                                    
                                    <div class="span4" data-column="2">

                                        <input id="start_date" class=" m-wrap span6 m-ctrl-medium date-picker" type="text" placeholder="开始时间" />
                                        <input id="end_date" class=" m-wrap span6 m-ctrl-medium date-picker" type="text" placeholder="结束时间" />
                                        
                                    </div>
                                    
                                </div>
                                
								<table class="table table-striped table-bordered table-hover" id="sample_1">

									<thead>

										<tr>

											<th class="hidden-480">编号</th>
                                            
                                            <th>操作者</th>
                                            
											<th class="hidden-480">操作日期</th>
                                            
                                            <th class="hidden-480">ip地址</th>
                                            
                                            <th>操作记录</th>

										</tr>

									</thead>

									<tbody>

                       
										<{if $datas}>
                                        <{foreach from = $datas item = v}>
                                        <tr class="odd gradeX">
                                        
											<td class="hidden-480"><{$v.id}></td>
                                            
                                            <td><{if $v.username}><{$v.username}><{else}>&nbsp;<{/if}></td>
                                            
											<td class="hidden-480"><{$v.log_time|date_format:'%Y-%m-%d %H:%M:%S'}></td>
                                            
                                            <td class="hidden-480"><{if $v.ip_address}><{$v.ip_address}><{else}>&nbsp;<{/if}></td>
                                            
                                            <td><{if $v.log_info}><{$v.log_info}><{else}>&nbsp;<{/if}></td>
											
										</tr>
                                        
                                        <{/foreach}>
                                        <{/if}>
                                        

									</tbody>

								</table>

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

	<script type="text/javascript" src="<{$js_path}>jquery.dataTables.min.js"></script>

	<script type="text/javascript" src="<{$js_path}>DT_bootstrap.js"></script>
    
    <script type="text/javascript" src="<{$js_path}>bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<{$js_path}>bootstrap-datepicker.zh-CN.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>table-managed.js"></script>     
    <script src="<{$js_path}>ui-jqueryui.js"></script> 
    
	<script type="text/javascript">

		jQuery(document).ready(function() {       

		   TableManaged.init();
           UIJQueryUI.init();
		});

	</script>
    <script type="text/javascript">
    $(function(){
        //下拉框
        $('.select2_category').select2({
            placeholder: "Select an option",
            allowClear: true
        });
        //多搜索
        $('input.column_filter').on( 'keyup ,click', function () {
            filterColumn( $(this).attr('data-column') ,$(this).val() );
        });
        
        $('select.column_filter').on('change' ,function() {
            var i = $(this).attr('data-column');
            var val = $(this).find('option[value='+$(this).val()+']').attr('filter');
            $('#sample_1').DataTable().column( i )
            .search( val ? '^'+val+'$' : val, true, false )
            .draw();
            
        });
        
        
        //日期
        if (jQuery().datepicker) {
            $('.date-picker').datepicker({   
                format: 'yyyy-mm-dd',
                weekStart: 1,
                autoclose: true,
                todayBtn: 'linked',
                language: 'zh-CN',
                rtl : App.isRTL()
            });
        }
        
        //datatable添加日期检索到datatable插件  
        $.fn.dataTable.ext.search.push(
            function( settings, data, dataIndex ) {
                var start_date =  $('#start_date').val();
                var end_date =  $('#end_date').val();
                var statistics_date =  data[2]  || 0; // use data for the age column
                //alert(statistics_date);
                if (
                     ( !start_date && !end_date ) ||
                     ( start_date && !end_date && statistics_date >= start_date ) ||
                     ( end_date && !start_date && end_date >= statistics_date ) ||
                     ( start_date && start_date && start_date <= statistics_date   && statistics_date <= end_date ) )
                {
                    return true;
                }
                return false;
            }
        );
        
        var table = $('#sample_1').DataTable();
        $('#start_date, #end_date').change( function() {
        table.draw();
        
        });
        
        
    });
    
    
    
    function filterColumn ( i ,tval ) {
        $('#sample_1').DataTable().column( i ).search(
            tval
        ).draw();
    }
    </script>

</body>
<!-- END BODY -->

</html>