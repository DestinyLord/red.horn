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

							<div class="portlet-body form">

									<!-- BEGIN FORM-->

									<form action="<{$formAction}>" method="post" class="form-horizontal">
                                    
                                        <div class="clearfix">
                                        <input name="id" style="display:none;" value="<{$leadsKeyItem['id']}>" />
                                        <input name="oldLeadsKey" style="display:none;" value="<{$leadsKeyItem['leads_key']}>" />
                                        </div>
                                    
                                        <div class="row-fluid span12">
                                        
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">品牌：</label>
                                                    <div class="controls">
                                                        <select size="1" name="brand" class="m-wrap changeKey" id="brand">
                                                            <option value="N-" <{if $data[0] == "N-"}>selected<{/if}> >日产（N）</option>
                                                            <option value="V-" <{if $data[0] == "V-"}>selected<{/if}> >启辰（V）</option>
                                                            <option value="NV-" <{if $data[0] == "NV-"}>selected<{/if}>>双品牌（NV）</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">设备：</label>
                                                    <div class="controls">
                                                        <select size="1" name="device" class="m-wrap changeKey" id="device">
                                                            <option value="Pc-" <{if $data[2] == "Pc-"}>selected<{/if}> >桌面（Pc）</option>
                                                            <option value="Wap-" <{if $data[2] == "Wap-"}>selected<{/if}> >移动（Wap）</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                            
                                        <div class="row-fluid span12">
                                        
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">业务领域：</label>
                                                    <div class="controls">
                                                        <select size="1" name="businessField" class="m-wrap changeKey" id="businessField">
                                                            <{foreach from=$businessFieldArr key=key item=value}>
                                                                <option value="<{$key}>"<{if $data[3] == $key}>selected<{/if}>><{$value}></option>
                                                            <{/foreach}>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">业务类型：</label>
                                                    <div class="controls">
                                                        <select size="1" name="businessType" class="m-wrap changeKey" id="businessType">
                                                            <{foreach from=$businessTypeArr key=key item=value}>
                                                                <option value="<{$key}>"<{if $data[4] == $key}>selected<{/if}>><{$value}></option>
                                                            <{/foreach}>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        
                                        <div class="row-fluid span12">
                                                                           
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">交易类型：</label>
                                                    <div class="controls">
                                                        <select size="1" name="transactionType" class="m-wrap changeKey" id="transactionType">
                                                            <option value="Le-" <{if $data[5] == "Le-"}>selected<{/if}> >线索（Le）</option>
                                                            <option value="Or-" <{if $data[5] == "Or-"}>selected<{/if}> >订单（Or）</option>
                                                            <option value="Fa-" <{if $data[5] == "Fa-"}>selected<{/if}> >粉丝（Fa）</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">客户类型：</label>
                                                    <div class="controls">
                                                        <select size="1" name="customerType" class="m-wrap changeKey" id="customerType">
                                                            <option value="PoC-" <{if $data[6] == "PoC-"}>selected<{/if}> >潜客（Potential Customer）</option>
                                                            <option value="ReC-" <{if $data[6] == "ReC-"}>selected<{/if}> >保客（RetainCustomer）</option>
                                                            <option value="Ng-" <{if $data[6] == "Ng-"}>selected<{/if}> >无法识别（NG）</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                            
                                        <div class="row-fluid span12">
                                            
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">短信类型：</label>
                                                    <div class="controls">
                                                        <select size="1" name="messageType" class="m-wrap changeKey" id="messageType">
                                                            <{foreach from=$msg key=key item=value}>
                                                                <option value="<{$value.type}>" <{if $data[7] == $value.type}>selected<{/if}>><{$value.name}></option>
                                                            <{/foreach}>
                                                            
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">同类排序：</label>
                                                    <div class="controls">
                                                        <select size="1" name="similarSort" class="m-wrap changeKey" id="similarSort">
                                                            <{foreach from=$similarSort key=key item=value}>
                                                                <option value=<{$key}> <{if $data[8] == $key}>selected<{/if}> ><{$value}></option>
                                                            <{/foreach}>
                                                            
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>
                                        
                                        <div class="row-fluid span12">
                                        
                                            <div class="span12">
                                                <div class="control-group">
                                                    <label class="control-label">业务有效期：</label>
                                                    <div class="controls">
                                                        <input type="text" id="exDate" name="exDate" class="changeKey" value="<{trim($data[9], '-')}>" />
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>                                                                                
                                        
                                        <div class="row-fluid span12">
                                        
                                            <div class="span12">
                                                <div class="control-group">
                                                    <label class="control-label">KEY值名称：</label>
                                                    <div class="controls">
                                                        <input type="text" id="leads_name" name="leads_name" style="width: 600px;" value="<{$leadsKeyItem['leads_name']}>" />
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>
                                        
                                        <div class="row-fluid span12">
                                        
                                            <div class="span12">
                                                <div class="control-group">
                                                    <label class="control-label">KEY值：</label>
                                                    <div class="controls">
                                                        <input readonly type="text" id="leads_key" name="leads_key" style="width: 600px;" value="<{$leadsKeyItem['leads_key']}>" />
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>
                                        
                                        <div class="row-fluid span12">
                                            
                                            <div class="span6">
                                                <div class="control-group">
                                                    <label class="control-label">停启状态：</label>
                                                    <div class="controls">
                                                        <select size="1" name="is_enable" class="m-wrap" id="is_enable">
                                                            <option value="1" <{if $leadsKeyItem['is_enable'] == "1"}>selected<{/if}> >启用</option>
                                                            <option value="0" <{if $leadsKeyItem['is_enable'] == "0"}>selected<{/if}> >停用</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                        </div>
                                    
										<div class="form-actions">

											<button type="submit" class="btn blue"><i class="icon-ok"></i> 保存</button>

											<button type="reset" class="btn">重置</button>

										</div>

									</form>

									<!-- END FORM-->  

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
            
            creatLeadsKey(0);
            
            $(".changeKey").change(function() {
                creatLeadsKey(1)
            });
		});
        
        /**创建key值，若flag=0则为页面初始化**/
        function creatLeadsKey(flag)
        {
            var leadsKey = $("#leads_key").val();
            
            if(leadsKey=="" || flag==1)
            {
                var brand = $("#brand").val(),
                channel = "Tmall-",
                device = $("#device").val(),
                businessField = $("#businessField").val(),
                businessType = $("#businessType").val(),
                transactionType = $("#transactionType").val(),
                customerType = $("#customerType").val(),
                messageType = $("#messageType").val(),
                similarSort = $("#similarSort").val(),
                exDate = $("#exDate").val();
                
                leadsKey = brand + channel + device + businessField + businessType + transactionType + customerType + messageType + similarSort + exDate;
                
                $("#leads_key").attr('value' ,leadsKey);
            }
        }
        
	</script>

</body>
<!-- END BODY -->

</html>