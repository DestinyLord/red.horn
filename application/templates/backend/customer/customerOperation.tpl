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
    
    <link rel="stylesheet" type="text/css" href="<{$css_path}>jquery.multiselect.css"/>

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
                                
                                <div class="row-fluid">
                                
                                    <div class="span4">
                                        <label class="span3 text-right">维度：</label>
                                        <select id="dimension" name="dimension">
                                            <option value="" <{if $dimension == ""}>selected<{/if}>>全部</option>
                                            <{foreach from=$dimensionArr key=key item=value}>
                                                <option value="<{$key}>"<{if $dimension == $key}>selected<{/if}>><{$value['name']}></option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">业务领域：</label>
                                        <select id="businessField" name="businessField">
                                            <option value="" <{if !$businessField}>selected<{/if}>>全部</option>
                                            <{foreach from=$businessFieldArr key=key item=value}>
                                                <option value="<{$key}>"<{if $businessField == $key}>selected<{/if}>><{$value}></option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">项目名称：</label>
                                        <select id="projectName" name="projectName" multiple="multiple" style="display: none;">
                                            <option value="" <{if !$projectName}>selected<{/if}>>全部</option>
                                            <{foreach from=$projectNameArr key=key item=value}>
                                                <option class="<{$value.businessField}>" value="<{$value.leads_key}>"<{if strstr($projectName, $value.leads_key)}>selected<{/if}>><{$value.leads_name}></option>
                                            <{/foreach}>
                                        </select>
                                    </div>
                                
                                </div>
                                
                                <div class="row-fluid">
                                
                                    <div class="span4">
                                        <label class="span3 text-right">设备：</label>
                                        <select id="device" name="device">
                                            <option value="" <{if $device == ""}>selected<{/if}>>全部</option>
                                            <option value="Pc-" <{if $device == "Pc-"}>selected<{/if}>>PC</option>
                                            <option value="Wap-" <{if $device == "Wap-"}>selected<{/if}>>移动</option>
                                        </select>
                                    </div>
                                    
                                    <div class="span4">
                                        <label class="span3 text-right">留资时间：</label>
                                        <input type="text" style="width:86px;" id="addTimeStart" value="<{$addTimeStart}>" />
                                        -
                                        <input type="text" style="width:86px;" id="addTimeEnd" value="<{$addTimeEnd}>" />
                                    </div>
                                    
                                    <div class="text-right">
                                    
                                        <button class="btn btn-primary" onclick="operation('customerOperation')">搜索</button>
                                        <button class="btn btn-primary" onclick="operation('customerOperationExcel')">导出</button>
                                    </div>
                                                                        
                                </div>
                                                                
                                <{if $dimension}>
                                
                                    <div id="main" style="width:100%;height:400px;"></div>
                                
    								<table class="table table-striped table-bordered table-hover" id="sample_4">
    
    									<thead>
    
    										<tr>
                                                <th>序号</th>
                                                
                                                <th><{$dimensionArr[$dimension]['title']}></th>
                                                                                        
    											<th>留资量</th>
                                                
                                                <th>占比</th>
    
    										</tr>
    
    									</thead>
    
    									<tbody>
    
                                            <{if $data}>
                                                <{assign var='i' value="1"}>
                                                <{foreach from=$data item=v}>
            										<tr class="odd gradeX">
                                                        <td><{$i++}></td>
                                                        <td><{$v.dataName}></td>
            											<td><{$v.c}></td>
                                                        <td><{sprintf("%.2f", ($v.c/$total.total*100))}>%</td>
            										</tr>
                                                <{/foreach}>
                                                <tr class="odd gradeX">
                                                    <td><{$i++}></td>
                                                    <td>总计</td>
                                                    <td><{$total.total}></td>
                                                    <td></td>
                                                </tr>
                                            <{/if}>
    
    									</tbody>
    
    								</table>
                                <{/if}>
                                
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
    
    <script type="text/javascript" src="<{$js_path}>echarts.min.js"></script>
    
    <script type="text/javascript" src="<{$js_path}>jquery.multiselect.js"></script>

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
            
            //业务领域下拉框
            $("#businessField").change(function() {
                var val=$(this).val();
                businessFieldChange(val, true);
            });
            
            //项目名称下拉框多选
            $("#projectName").multiselect({
                noneSelectedText: "全部",
                checkAllText: "全选",
                uncheckAllText: '全不选',
                selectedList:1
            });
            
            businessFieldChange('<{$businessField}>', false);
		});
        
        //业务领域下拉框值变更
        function businessFieldChange(va, flag)
        {
            if (flag) $(".ui-multiselect-none").trigger("click");
            if(va)
            {
                $(".ui-multiselect-checkboxes li").hide();
                $(".ui-multiselect-checkboxes ."+va).show();
            }
            else
            {
                $(".ui-multiselect-checkboxes li").show();  
            }
            $(".ui-multiselect-checkboxes li:first").show();
        }
        
        <{if $dimension}>
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        
        <{assign var='i' value="1"}>
        <{foreach from=$data item=v name=v}>
             <{if $smarty.foreach.v.index == 31}>
                <{break}>
             <{/if}>
            <{$dataName[] = $v.dataName}>
			<{$dataCount[] = $v.c}>
            <{$i++}>
        <{/foreach}>

        // 指定图表的配置项和数据
        var option = {
                title : {
                    text: '<{$dimensionArr[$dimension]['name']}>'
                },
                tooltip : {
                    trigger: 'axis'
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                legend: {
                    data:['留资量']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : ['<{implode("','", $dataName)}>'],
                        <{if strlen(implode("','", $dataName)) > 180}>
                            axisLabel:
                            {
                        	  interval:0 ,
                        	  formatter:function(val)
                              {
                                return val.split("").join("\n");
                        	  }
                 	        }
                        <{/if}>
                    }
                ],
                yAxis : [
                    {
                        type : 'value'
                    }
                ],
                series : [
                    {
                        name:'留资量',
                        type:'bar',
                        itemStyle : {
                            normal: {
                                label: {show: true, position: 'top'}
                            }
                        },
                        data:[<{implode(",", $dataCount)}>],
                    }
                ]
            };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        <{/if}>
        
        //搜索&导出
        function operation(v){
            var queryparams = '';
            
            //维度
            var dimension = $('#dimension').val();
            if(dimension){
                queryparams += '&dimension='+dimension;
            }
            
            //业务领域
            var businessField = $('#businessField').val();
            if(businessField){
                queryparams += '&businessField='+businessField;
            }
            
            //用户入口
            var projectName = $("#projectName").multiselect("MyValues");
            if(projectName){
                queryparams += '&projectName='+projectName;
            }
            
            //设备
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
                        
            url = '/index.php/backend/customer/' + v + '?' + queryparams;
            window.location.href = url;
        }
                
	</script>

</body>
<!-- END BODY -->

</html>