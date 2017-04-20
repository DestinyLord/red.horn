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

								<div class="caption"><i class="icon-globe"></i><{$h3title}>列表</div>

							</div>

							<div class="portlet-body">

								<div class="clearfix">
                                
                                    <div class="btn-group span6">
										
										<{if check_priv('messageAdd')}>
                                        <a href="<{site_url uri=$backendDir|cat:'/customer/messageEdit'}>" id="sample_editable_1_new" style="margin-right:10px;" class="btn green">

                                        新增短信模板 <i class="icon-plus"></i>

                                        </a>
                                        <{/if}>
                                    </div>
                                    
                                    <div class="span6">
                                        <div class="dataTables_filter" id="sample_1_filter">
                                            <label>
                                                <button class="btn btn-primary" onclick="search()">搜索</button>  
                                                <input type="text" class="m-wrap medium" id="name" placeholder="短信专题名" value="<{$name}>"/>
                                            </label>
                                        </div>
                                    </div>
                                    
								</div>
                                
								<table class="table table-striped table-bordered table-hover" id="sample_4">

									<thead>

										<tr>
                                        
                                            <th>NO</th>
                                                                                    
											<th width="80">短信编码</th>

											<th width="120">短信专题名</th>

											<th>Tae平台短信</th>
                                            
                                            <th>天猫宝贝短信</th>
                                            
                                            <th width="30">操作</th>

										</tr>

									</thead>

									<tbody>

                                        <{if $datas}>
                                        <{assign var='i' value="1"}>
                                        <{foreach from=$datas.lists item=v}>
										<tr class="odd gradeX">
                                        
                                            <td><{$i++}></td>
                                        
                                            <td><{$v.type}></td>

											<td><{$v.name}></td>

											<td><{$v.sms|htmlentities}></td>
                                            
                                            <td><{$v.sms_tmall|htmlentities}></td>
                                                                                              
                                            <td>
                                            <{if check_priv('messageEdit')}>
                                                <a href="<{site_url uri=$backendDir|cat:'/customer/messageEdit/'|cat:$v.id}>" title="修改"><img src="<{$image_path}>icon_edit.gif" alt="修改" /></a>
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

	<script type="text/javascript" src="<{$js_path}>DT_bootstrap.js"></script>
    
    <script type="text/javascript" src="<{$js_path}>bootstrap-datetimepicker.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>table-managed.js"></script>     
    <script src="<{$js_path}>ui-jqueryui.js"></script> 
	<script>
        jQuery(document).ready(function(e) {
            TableManaged.init();
            UIJQueryUI.init();
		});
        
        //搜索
        function search(){
            var queryparams = '';
                        
            var name = $('#name').val();
            if(name){
                queryparams += '&name='+name;
            }
            
            url = '/index.php/backend/customer/messageManage?' + queryparams;
            window.location.href = url;
        }
        
	</script>

</body>
<!-- END BODY -->

</html>