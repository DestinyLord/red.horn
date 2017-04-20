<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--[if IE 8]> <html xmlns="http://www.w3.org/1999/xhtml" lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html xmlns="http://www.w3.org/1999/xhtml" lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html xmlns="http://www.w3.org/1999/xhtml" lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>
    <{include file= $backendViewDir|cat:'/common/head.tpl'}>

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="<{$css_path}>select2_metro.css" />
	
	<!-- END PAGE LEVEL STYLES -->
	<link rel="stylesheet" type="text/css" href="<{$css_path}>datepicker.css" />
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

						<div class="tab-pane"  id="tab_5">

							<div class="portlet box blue ">

								<div class="portlet-title">

									<div class="caption">
                                    
                                        <i class="icon-reorder"></i>
                                        <{$h3title}>&nbsp;
                                        
                                    </div>
                                    
                                    <div style="float: right;">
                                        
                                        Key值：<{$leadsKeyItem.leads_key}>&nbsp;
                                        项目名称：<{$leadsKeyItem.leads_name}>
                                    
                                    </div>

								</div>

								<div class="portlet-body form">

									<!-- BEGIN FORM-->

									<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form">
                                    
                                        <input value="<{$leadsKeyItem.leads_key}>" name="leadsKey" style="display:none;" />
                                        
                                        <input value="<{$leadsKeyItem.sms_type}>" name="smsType" style="display:none;" />
                                                                           
										<div class="row-fluid">
                                                
                                            <input name="numIid" id="numIid" value="" type="text" class="m-wrap span2" placeholder="宝贝ID" />
                                            <input name="name" id="name" value="" type="text" class="m-wrap span4" placeholder="宝贝名称" />
                                            <select name="source" id="source" class="m-wrap" style="width:80px">
                                                <option value="1">订单</option>
                                                <option value="3">线索</option>
                                            </select>
                                            
                                            <select name="isPhoneDealer" id="isPhoneDealer" class="m-wrap" style="width:130px">
                                                <option value="1">匹配经销商</option>
                                                <option value="0">不匹配经销商</option>
                                            </select>
                                            
                                            <select name="isInsert" id="isInsert" class="m-wrap" style="width:80px">
                                                <option value="1">入库</option>
                                                <option value="0">不入库</option>
                                            </select>
                                            
                                            <button type="submit" onclick="return submit_form();" class="btn blue">
                                            
                                                <i class="icon-ok"></i>保存
                                            
                                            </button>
                                            
                                            <span class="validate-inline hide NumIidErrorText" style="color: red"></span>
                                            
										</div>

									</form>

									<!-- END FORM-->  

								</div>
                                
                                <div class="portlet-body">
                                
                                    <table class="table table-striped table-bordered table-hover" id="sample_4">
                                    
                                        <thead>

    										<tr>
                                                <th></th>
                                            
                                                <th>宝贝ID</th>
                                                                                        
    											<th>宝贝名称</th>
    
    											<th>入库类型</th>
    
    											<th>是否分配经销商</th>
    
    											<th>是否入库</th>
                                                
                                                <th>是否有效</th>
    
    										</tr>
    
    									</thead>
                                        
                                        <tbody>
                                        
                                        <{if $tmallKey}>
                                        
                                            <{foreach from=$tmallKey item=v name="keyItem"}>
                                            
        										<tr class="odd gradeX">
                                                
                                                    <td><{$smarty.foreach.keyItem.index + 1}></td>
        
        											<td><{$v.num_iid}></td>
        
        											<td><{$v.name}></td>
                                                    
                                                    <td><{if $v.source==1}>订单<{elseif $v.source==3}>线索<{/if}></td>
                                                    
                                                    <td><{if $v.is_phoneDealer}>是<{else}>否<{/if}></td>
                                                    
                                                    <td><{if $v.is_insert}>是<{else}>否<{/if}></td>
                                                    
                                                    <td>
                                                        <select onchange="update(<{$v.id}>)" id="isEnable_<{$v.id}>" class="span12">
                                                        
                                                            <option value="1" <{if $v.is_enable == "1"}>selected<{/if}> >是</option>
                                                            
                                                            <option value="0" <{if $v.is_enable == "0"}>selected<{/if}> >否</option>
                                                            
                                                        </select>
                                                        
                                                    </td>
        
        										</tr>
                                            
                                            <{/foreach}>
                                            
                                        <{/if}>
                                        
                                        </tbody>

								    </table>
                                
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
    
    <script src="<{$js_path}>jquery.validate.min.js" type="text/javascript"></script>
    <script src="<{$js_path}>jquery.validate.messages_zh.js" type="text/javascript"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>form-samples.js"></script>    
    <script type="text/javascript" src="<{$js_path}>bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<{$js_path}>validator.js"></script>
    
	<script type="text/javascript">

		jQuery(document).ready(function() {       
		   FormSamples.init();
		});

        //添加数据提交
        function submit_form()
        {
        	var form_ob=document.getElementById("dataform"); 
        	        
        	var numIid = $('#numIid').val(),
                name = $('#name').val(),
                source = $('#source').val(),
                smsType = $('#smsType').val(),
                isPhoneDealer = $('#isPhoneDealer').val(),
                isInsert = $('#isInsert').val();
            
                    
        	if(!numIid)
            {
                $('.NumIidErrorText').html("宝贝ID不能为空");
                $('.NumIidErrorText').show();
   		        $('.NumIidBox').addClass('error');
        	    return false;
            }
            else if(!name)
            {
                $('.NumIidErrorText').html("宝贝名称不能为空");
                $('.NumIidErrorText').show();
   		        $('.NumIidBox').addClass('error');
        	    return false;
            }
            else
        	{
        		$('.NumIidErrorText').hide();
        		$('.NumIidBox').removeClass('error');
        	}	
        
        	form_ob.submit();
        }
        
        //更新天猫Key值
        function update(id)
        {
            var value = $('#isEnable_' + id).val();
            
            url = '/index.php/backend/customer/tmallKeyUpdate';
            $.ajax({
                url : url,
                type : "POST",
                data : {"id":id, "is_enable":value},
                success: function(data) {
                    
                }
            });
        }
    </script>
    
</body>
<!-- END BODY -->

</html>