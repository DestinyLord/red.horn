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
    
    <link rel="stylesheet" href="<{$css_path}>orderDetail.css" />
    
    <link rel="stylesheet" type="text/css" href="<{$css_path}>jquery-ui-1.10.1.custom.min.css"/>
    
    <link rel="stylesheet" type="text/css" href="<{$css_path}>pagination-style.css"/>

	<!-- END PAGE LEVEL STYLES -->
<style type="text/css">
fieldset.myfieldset {
    background: #fff none repeat scroll 0 0;
    border: 1px solid #dfdfdf;
    margin: 15px;
    padding: 10px;
}

fieldset.myfieldset legend {
    display: inline !important;
    background: #fff none repeat scroll 0 0;
    font-size: 14px;
    line-height: 20px;
    border: 1px solid #dfdfdf;
    margin: 0;
    color: #006699;
    font-weight: bold;
    padding: 3px 20px;
    width: auto;
}
ul.package-ul {
    float: left;
    width:60%;
}
ul.package-ul li span{
    float: left;
    width: 45%;
}
ul.package-ul li span.price{
    float: right;
    color: red;
    width:10%;
    text-align: right;
}
ul.package-ul li.count-price{
    list-style: none;
    border-top: 1px solid #999;
    padding-top: 10px;
    margin-top: 10px;
}
ul.package-ul li.last {
    list-style: none;
}
.export_btn {
    text-align: center;
    margin-bottom: 20px;
}
</style>


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

					
					<!-- BEGIN EXAMPLE TABLE PORTLET-->

					<div class="portlet box light-grey">

						<div class="portlet-title">

							<div class="caption">
                            
                                <i class="icon-globe"></i>
                                
                                <{$h3title}>
                                
                            </div>
                            

						</div>

						<div class="form-horizontal" id="print_content">
                            <fieldset class="myfieldset">
                            <legend>订单信息</legend>
                            <table border="0" width="100%" class="table-striped table-condensed flip-content">
                                <tr>
                                    <td>订单编号：<{$detail.out_no}></td>
                                    <td>下单时间：<{date("Y-m-d H:i:s",$detail.dateline)}></td>
                                </tr>
                                <tr>
                                    <td>订单金额：<span style="color: red;"><{moneyFormat($detail.fee)}>元</span></td>
                                    <td>订单状态：<{deal_status(1,$detail)}></td>
                                </tr>
                                <tr>
                                    <td>预约时间：<{if isset($detail['extend']['reserve_time'])}><{date('Y-m-d : H:i:s',$detail['extend']['reserve_time'])}><{/if}></td>
                                    <td><{if $detail.reason}>取消理由：<{$detail.reason}><{/if}></td>
                                </tr>
                                <tr><td colspan="2">套餐类型：<{$detail.package.oil_name}></td></tr>
                                <tr>
                                    <td colspan="2"><div style="float:left;">构&nbsp; 成：</div>
                                        <ul class="package-ul">
                                            <li>
                                                <span><{$detail.package.oil_name}></span>
                                                <span><{$detail.package.oil_ts}></span>
                                                <span class="price"><{$detail.package.oil_price}>元</span>
                                            </li>
                                            <li>
                                                <span>机油滤清器</span>
                                                <span><{$detail.package.oil_filter_name}></span>
                                                <span class="price"><{$detail.package.oil_filter_price}>元</span>
                                            </li>
                                            <{assign var="oilCountPrice" value=0}>
                                            <{foreach from=$detail.package.content item=ov}>
                                            <li>
                                                <span><{$ov.name}></span>
                                                <span><{$ov.ts}></span>
                                                <span class="price"><{$ov.price}>元</span>
                                            </li>
                                            <{assign var="oilCountPrice" value=$oilCountPrice+$ov.price}>
                                            <{/foreach}>
                                            <li class="count-price">零件小计：<span class="price"><{$oilCountPrice+$detail.package.oil_price+$detail.package.oil_filter_price}>元</span></li>
                                            <li class="last">工时费：<span class="price"><{$detail.package.time_price}>元</span></li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </td>
                                </tr>
                            </table>
                            </fieldset>
                            <fieldset class="myfieldset">
                            <legend>车辆信息</legend>
                            <table border="0" width="100%" class="table-striped table-condensed flip-content">
                                <tr>
                                    <td>保养车型：<{$detail.modelInfo.series_name}>&nbsp;&nbsp;<{$detail.modelInfo.model_name}></td>
                                    <td>保养里程：<{$detail.extend.distance}> KM</td>
                                </tr>
                                <tr>
                                    <td>客户姓名：<{$detail.extend.name}></td>
                                    <td>电&nbsp;&nbsp;&nbsp;&nbsp;话：<{$detail.extend.mobile}></td>
                                </tr>
                                <tr>
                                    <td>车&nbsp;&nbsp;牌：<{$detail.extend.car_code}></td>
                                    <td> </td>
                                </tr>
                            </table>
                            </fieldset>
                        </div>
                        <div class="export_btn"><button class="btn" onClick="printview();">打印</button></div>
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

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>table-managed.js"></script>     
	<script>
        jQuery(document).ready(function(e) {
            TableManaged.init();
            
            
		});

        function printview()
        {
            bdhtml=document.getElementById('print_content').innerHTML;
            bdhtml = '<h1 style="line-height:100px;text-align:center;font-size:24px;">预约保养订单详情</h1>'+bdhtml;
            sprnstr="<!--startprint-->";
            eprnstr="<!--endprint-->";
            window.document.body.innerHTML=bdhtml;
            window.print();
        }
	</script>

</body>
<!-- END BODY -->

</html>