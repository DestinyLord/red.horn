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

								</div>
                                
                                <div class="row-fluid">
                                
                                    <div class="span4">
                                        <label class="span3 text-right">品牌：</label>
                                        <select id="brand">
                                            <option value="" <{if $brand == ""}>selected<{/if}> >全部</option>
                                            <option value="N-" <{if $brand == 'N-'}>selected<{/if}> >日产（N）</option>
                                            <option value="V-" <{if $brand == 'V-'}>selected<{/if}> >启辰（V）</option>
                                            <option value="NV-" <{if $brand == 'NV-'}>selected<{/if}> >双品牌（NV）</option>
                                        </select>
                                    </div>
                                
                                    <div class="span4">
                                        <label class="span3 text-right">业务领域：</label>
                                        <select id="businessField">
                                            <option value="" <{if $businessField == ""}>selected<{/if}> >全部</option>
                                            <{foreach from=$businessFieldArr key=key item=value}>
                                                <option value="<{$key}>" <{if $businessField == $key}>selected<{/if}> ><{$value}></option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">设备：</label>
                                        <select id="device">
                                            <option value="" <{if $device == ""}>selected<{/if}> >全部</option>
                                            <option value="Pc-" <{if $device == "Pc-"}>selected<{/if}> >PC</option>
                                            <option value="Wap-" <{if $device == "Wap-"}>selected<{/if}> >移动</option>
                                        </select>
                                    </div>
                                    
                                </div>
                                
                                <div class="row-fluid">
                                
                                    <div class="span4">
                                        <label class="span3 text-right">交易类型：</label>
                                        <select id="transactionType">
                                            <option value="" <{if $transactionType == ""}>selected<{/if}> >全部</option>
                                            <option value="Le-" <{if $transactionType == "Le-"}>selected<{/if}> >线索</option>
                                            <option value="Or-" <{if $transactionType == "Or-"}>selected<{/if}> >订单</option>
                                        </select>  
                                    </div>
                                
                                    <div class="span4">
                                        <label class="span3 text-right">业务名称：</label>
                                        <select id="projectName" class="editable">
                                            <option value="" <{if $projectName == ""}>selected<{/if}> >全部</option>
                                            <option value="-1">编辑</option>
                                            <{if !array_search($projectName, $projectNameArr) && $projectName!=''}>
                                                <option value="<{$projectName}>" selected><{$projectName}></option>
                                            <{/if}>
                                            <{foreach from=$projectNameArr key=key item=value}>
                                                <option class="<{$value.businessField}>" value="<{$value.leads_name}>" <{if $projectName == $value.leads_name}>selected<{/if}> ><{$value.leads_name}></option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">业务担当：</label>
                                        <select id="businessPlay">
                                            <option value="" <{if $businessPlay == ""}>selected<{/if}> >全部</option>
                                            <{foreach from=$businessPlayArr key=key item=value}>
                                                <option value="<{$key}>" <{if $businessPlay == $key}>selected<{/if}> ><{$value}></option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                    
                                </div>
                                
                                <div class="row-fluid">
                                
                                    <div class="span4">
                                        <label class="span3 text-right">落地页：</label>
                                        <select id="landingPage">
                                            <option value="" <{if $landingPage == ""}>selected<{/if}> >全部</option>
                                            <{foreach from=$landingPageArr key=key item=value}>
                                                <option value="Tae-" <{if $landingPage == $key}>selected<{/if}> ><{$value}></option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">短信类型：</label>
                                        <select id="messageType">
                                            <option value="" <{if $messageType == ""}>selected<{/if}> >全部</option>
                                            <{foreach from=$msgArr key=key item=value}>
                                                <option value="<{$value.type}>" <{if $messageType == $key}>selected<{/if}> ><{$value.name}>（<{$value.type}>）</option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">意向车型：</label>
                                        <select id="series">
                                            <option value="" <{if $series == ""}>selected<{/if}> >全部</option>
                                            <{foreach from=$seriesArr key=key item=value}>
                                                <option value="<{$key}>" <{if $series == $key}>selected<{/if}> ><{$value.name}></option>
                                            <{/foreach}>
                                            
                                        </select>
                                    </div>
                                    
                                </div>
                                
                                <div class="row-fluid">
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">key值：</label>
                                        <input type="text" id="leadsKey" value="<{$leadsKey}>" />
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">手机号码：</label>
                                        <input type="text" id="customerTel" value="<{$customerTel}>" />
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">订单号：</label>
                                        <input type="text" id="tid" value="<{$tid}>" />
                                    </div>
                                
                                </div>
                                
                                <div class="row-fluid">
                                
                                    <div class="span4">
                                        <label class="span3 text-right">留资时间：</label>
                                        <input type="text" style="width:86px;" id="addTimeStart" value="<{$addTimeStart}>" />
                                        -
                                        <input type="text" style="width:86px;" id="addTimeEnd" value="<{$addTimeEnd}>" />
                                    </div>
                                
                                </div>
                                
                                <div class="row-fluid">
                                
                                    <div class="span9">
                                        <label>
                                            线索批次：<{$datas.total}> &nbsp;
                                            线索数：<{$count.business.c}> &nbsp;
                                            有效线索量：<{$count.effective.c}> &nbsp;
                                            堡垒店有效线索：<{$count.vipDealer.c}> &nbsp;
                                            有效用户数：<{$count.userCount.c}>
                                        </label>
                                    </div>
                                    
                                    <div class="text-right">
                                        <button class="btn btn-primary" onclick="search()">搜索</button>
                                        <input type="hidden" class="export-input" name="export" value="0" />
                                        <button class="btn btn-primary export-button">导出</button>
                                    </div>
                                    
                                </div>
                                    
                                <div class="row-fluid">
                                
                                    <div class="span9">
                                        <label>
                                            昨日数据【
                                            线索批次：<{$count.totalY}> &nbsp;
                                            线索数：<{$count.businessY.c}> &nbsp;
                                            有效线索量：<{$count.effectiveY.c}> &nbsp;
                                            堡垒店有效线索：<{$count.vipDealerY.c}> &nbsp;
                                            有效用户数：<{$count.userCountY.c}>】
                                            <a href="<{site_url uri=$backendDir|cat:'/customer/customerOperation'}>?dimension=userEntry&addTimeStart=<{date('Y-m-d',time() - 86400)}>&addTimeEnd=<{date("Y-m-d",time())}>">详情</a>
                                        </label>
                                    </div>
                                    
                                </div>
                                
                                <div style="overflow: auto; width: 100%;">

    								<table class="table table-striped table-bordered table-hover" id="sample_4" style="white-space: nowrap;">
    
    									<thead>
    
    										<tr>
                                            
                                                <th>NO</th>
                                                
                                                <th>业务领域</th>
                                                
                                                <th>业务名称</th>
                                                
                                                <th>落地页</th>
                                                
                                                <th>业务类型</th>
                                                
                                                <th>设备</th>
                                                
                                                <th>Key值</th>
                                                                                        
    											<th>姓名</th>
    
    											<th>电话</th>
    
    											<th>意向车型</th>
                                                
                                                <th>意向经销商</th>
    
    											<th>留资时间</th>
                                                
                                                <th>订单号码</th>
                                                
                                                <th>备注</th>
    
    										</tr>
    
    									</thead>
    
    									<tbody>
    
                                            <{if $datas}>
                                            <{assign var='i' value="1"}>
                                            <{foreach from=$datas.lists item=v}>
    										<tr class="odd gradeX">
                                            
                                                <td><{$i++}></td>
                                                
                                                <td><{$v.businessField}></td>
                                            
                                                <td><{$v.leads_name}></td>
                                                
                                                <td><{if isset($v.landingPage)}><{$v.landingPage}><{/if}></td>
                                                
                                                <td><{$v.businessType}></td>
                                                
                                                <td><{$v.device}></td>
                                                
                                                <td><{$v.leads_key}></td>
    
    											<td><{$v.customer_name}></td>
    
    											<td><{$v.customer_tel}></td>
                                                
                                                <td><{$v.series_name}></td>
                                                
                                                <td><{$v.dealer_name}></td>
                                                
                                                <td><{date("Y-m-d ", $v.addTime)}></td>
                                                
                                                <td><{$v.tid}></td>
                                                
                                                <td><{$v.remark}></td>
    
    										</tr>
                                            
                                            <{/foreach}>
                                            <{/if}>
    
    									</tbody>
    
    								</table>
                                    
                                </div>
                                
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

            $('.export-button').click(function(){
                $('.export-input').val(1);
                search();
            })
            
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
            
            //品牌
            var brand = $('#brand').val();
            if(brand){
                queryparams += '&brand='+brand;
            }
            
            //业务领域
            var businessField = $('#businessField').val();
            if(businessField){
                queryparams += '&businessField='+businessField;
            }
            
            //设备
            var device = $('#device').val();
            if(device){
                queryparams += '&device='+device;
            }
            
            //交易类型
            var transactionType = $('#transactionType').val();
            if(transactionType){
                queryparams += '&transactionType='+transactionType;
            }
            
            //业务名称
            var projectName = $('#projectName').val();
            if(projectName){
                queryparams += '&projectName='+projectName;
            }
            
            //业务担当
            var businessPlay = $('#businessPlay').val();
            if(businessPlay){
                queryparams += '&businessPlay='+businessPlay;
            }
            
            //落地页
            var landingPage = $('#landingPage').val();
            if(landingPage){
                queryparams += '&landingPage='+landingPage;
            }
            
            //短信类型
            var messageType = $('#messageType').val();
            if(messageType){
                queryparams += '&messageType='+messageType;
            }
            
            //意向车型
            var series = $('#series').val();
            if(series){
                queryparams += '&series='+series;
            }
            
            //Key值
            var leadsKey = $('#leadsKey').val();
            if(leadsKey){
                queryparams += '&leadsKey='+leadsKey;
            }
            
            //手机号
            var customerTel = $('#customerTel').val();
            if(customerTel){
                queryparams += '&customerTel='+customerTel;
            }
            
            //订单
            var tid = $('#tid').val();
            if(tid){
                queryparams += '&tid='+tid;
            }
            
            //留资时间
            var addTimeStart = $('#addTimeStart').val();
            if(addTimeStart){
                queryparams += '&addTimeStart='+addTimeStart;
            }
            
            var addTimeEnd = $('#addTimeEnd').val();
            if(addTimeEnd){
                queryparams += '&addTimeEnd='+addTimeEnd;
            }  

            var exportInput = $('.export-input').val();
            if(exportInput){
                queryparams += '&export='+exportInput;
            }           
            
            url = '/index.php/backend/customer/customerApply?' + queryparams;
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