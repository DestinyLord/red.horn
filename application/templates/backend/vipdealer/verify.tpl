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

								</div>
                                
                                <div class="row-fluid">
                                
                                    <form class="form-horizontal" action="/index.php/backend/vipdealer/verifyCheck" method="get">
                                                                    
                                        <div class="span4">
                                            <div class="control-group">

                                                <label class="control-label">手机号码：</label>

                                                <div class="controls">

                                                    <input type="text" class="m-wrap span12" id="customerTel" name="customerTel" value="" />

                                                </div>

                                            </div>
                                        </div>
                                        
                                        <div class="span4">
                                            <div class="control-group">

                                                <label class="control-label">核销码：</label>

                                                <div class="controls">

                                                    <input class="m-wrap span12" type="text" id="verifyCode" name="verifyCode" value="" />

                                                </div>

                                            </div>
                                        </div>
                                        
                                        <div class="span4">
                                            <div class="control-group">
                                                <div class="controls">
                                                    <input class="m-wrap btn btn-primary" type="submit" value="核销" />
                                                </div>
                                            </div>
                                        </div>
                                    
                                    </form>
                                
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
            
            //日期控件初始化
            $('#addTimeStart').datetimepicker({format: 'yyyy-mm-dd', 'minView':2, 'fontAwesome':true});
            $('#addTimeEnd').datetimepicker({format: 'yyyy-mm-dd', 'minView':2, 'fontAwesome':true});
            
            //可编辑下拉框初始化
            $(".editable").editable(e);
            
            //业务领域下拉框
            $("#businessField").change(function() {
                var val=$(this).val();
                businessFieldChange(val)
            });
            
		});
        
        
        //可编辑下拉框
        $.fn.editable = function(config)
        {
            $(this).each(function(i,t)
            {
                $(t).change(function()
                {
                    var me=$(this);
                    me.find('.customval').remove();
                    if(-1 == me.val())
                    {
                        var ed = $("<input type=\"text\" class=\"form-control\" />");
                        me.after(ed).hide();
                        ed.blur(function()
                        {
                            var v=ed.val();
                            if(null === v ||  v.length ==0)
                            {
                                ed.remove();me.val(null).show();
                            }
                            else
                            {
                                me.append("<option value=\""+v+"\" class=\"customval\" selected>"+v+"</option>").show();
                                ed.remove();
                            }
                        }).focus();
                    }
                })
            });
        }
        
        //搜索
        function search(){
            var queryparams = '';
            
            var businessField = $('#businessField').val();
            if(businessField){
                queryparams += '&businessField='+businessField;
            }
            
            var projectName = $('#projectName').val();
            if(projectName){
                queryparams += '&projectName='+projectName;
            }
            
            var device = $('#device').val();
            if(device){
                queryparams += '&device='+device;
            }
            
            var addTimeStart = $('#addTimeStart').val();
            if(addTimeStart){
                queryparams += '&addTimeStart='+addTimeStart;
            }
            
            var addTimeEnd = $('#addTimeEnd').val();
            if(addTimeEnd){
                queryparams += '&addTimeEnd='+addTimeEnd;
            }
            
            var transactionType = $('#transactionType').val();
            if(transactionType){
                queryparams += '&transactionType='+transactionType;
            }
            
            var leadsKey = $('#leadsKey').val();
            if(leadsKey){
                queryparams += '&leadsKey='+leadsKey;
            }
            
            var customerName = $('#customerName').val();
            if(customerName){
                queryparams += '&customerName='+customerName;
            }
            
            var customerTel = $('#customerTel').val();
            if(customerTel){
                queryparams += '&customerTel='+customerTel;
            }
            
            var tid = $('#tid').val();
            if(tid){
                queryparams += '&tid='+tid;
            }
            
            url = '/index.php/backend/leadsKey/customerApply?rand=' + Math.random() + queryparams;
            window.location.href = url;
        }
        
        //业务领域下拉框值变更
        function businessFieldChange(va)
        {
            $("#projectName option").eq(0).attr("selected",true);
            if(va)
            {
                $("#projectName option").hide();
                $("."+va).show();
            }
            else
            {
                $("#projectName option").show();  
            }
            $("#projectName option").eq(0).show();
            $("#projectName option").eq(1).show();
        }
        
	</script>

</body>
<!-- END BODY -->

</html>