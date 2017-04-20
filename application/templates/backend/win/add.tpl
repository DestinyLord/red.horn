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



						<div class="portlet box blue ">

							<div class="portlet-title">

								<div class="caption"><i class="icon-reorder"></i><{$h3title}></div>

								<!--<div class="tools">

									<a href="javascript:;" class="collapse"></a>

									<a href="#portlet-config" data-toggle="modal" class="config"></a>

									<a href="javascript:;" class="reload"></a>

									<a href="javascript:;" class="remove"></a>

								</div>-->

							</div>

							<div class="portlet-body form">

								<!-- BEGIN FORM-->

								<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form">
                                    
									<div class="control-group">

										<label class="control-label" for="activity_name">活动名称</label>

										<div class="controls">

											<input dataType="Require" msg="活动名称必须填写" id="activity_name" name="activity_name" value="" type="text" placeholder="活动名称" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="number">期数</label>

										<div class="controls">

											<input dataType="Number" msg="期数必须为正整数" id="number" name="number" value="" type="text" placeholder="期数" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="join_num">参与人数</label>

										<div class="controls">

											<input dataType="Number" msg="参与人数必须为正整数" id="join_num" name="join_num" value="" type="text" placeholder="参与人数" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="end_time">活动时间</label>

										<div class="controls">
											
											<div class="input-append date date-picker" >

												<input dataType="Require" msg="活动时间必须填写" class="m-wrap m-ctrl-medium date-picker" id="start_time" name="start_time" readonly size="16" type="text" value="" placeholder="开始时间" /><span class="add-on" ><i class="icon-calendar"></i></span>

											</div>

											<div class="input-append date date-picker" >

												<input dataType="Require" msg="活动时间必须填写" class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value="" placeholder="结束时间" /><span class="add-on" ><i class="icon-calendar"></i></span>

											</div>

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="draw_time">揭晓时间</label>

										<div class="controls">
											
											<div class="input-append date date-picker" >

												<input dataType="Require" msg="揭晓时间必须填写" class="m-wrap m-ctrl-medium date-picker" id="draw_time" name="draw_time" readonly size="16" type="text" value="" placeholder="揭晓时间" /><span class="add-on" ><i class="icon-calendar"></i></span>

											</div>

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="price">付款金额</label>

										<div class="controls">

											<input dataType="Number" msg="参与人数必须为正整数" id="price" name="price" value="" type="text" placeholder="参与人数" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="order_num">订单号码</label>

										<div class="controls">

											<input dataType="Require" msg="订单号码必须填写" id="order_num" name="order_num" value="" type="text" placeholder="订单号码" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="price">客户姓名</label>

										<div class="controls">

											<input dataType="Require" msg="客户姓名必须填写" id="win_name" name="win_name" value="" type="text" placeholder="客户姓名" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="tel">手机号码</label>

										<div class="controls">

											<input dataType="Require" msg="手机号码必须填写" id="tel" name="tel" value="" type="text" placeholder="手机号码" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" >车型</label>

										<div class="controls">

											<div class="select2-wrapper">

												<select name="series_id" class="span6 select2_category" dataType="Require" msg="车型必须选择">

													<option value="">请选择车型</option>
                                                  	<{foreach from=$seriesList item=v}>
                                                  	<option value="<{$v.series_id}>"><{$v.name}></option>
                                                  	<{/foreach}>
													
												</select>

											</div>

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" >专营店</label>

										<div class="controls">

											<div class="select2-wrapper">

												<select name="dealer_id" class="span6 select2_category" dataType="Require" msg="专营店必须选择">

													<option value="">请选择专营店</option>
                                                  	<{foreach from=$dealerList item=v}>
                                                  	<option value="<{$v.dealer_id}>"><{$v.dealer_name_short}></option>
                                                  	<{/foreach}>

												</select>

											</div>

										</div>

									</div>

									<div class="control-group">

										<label class="control-label" for="idcard_no">身份证号码</label>

										<div class="controls">

											<input dataType="IdCard" msg="身份证号码格式错误" id="idcard_no" name="idcard_no" value="" type="text" placeholder="身份证号码" class="m-wrap span6" />

										</div>

									</div>

									<div class="control-group last">

										<label class="control-label" for="leads_key">KEY值</label>

										<div class="controls">

											<input dataType="Require" msg="KEY值必须填写" id="leads_key" name="leads_key" value="" type="text" placeholder="KEY值" class="m-wrap span6" />

										</div>

									</div>
                                    
                                    
									
									<div class="form-actions">

										<button type="submit" onclick="return submit_form();" class="btn blue"><i class="icon-ok"></i> 保存</button>

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
		   if (jQuery().datepicker) {
            $('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd'});
        }
		});

	</script>
    
    <script type="text/javascript">
    

	function submit_form(){
		var form_ob=document.getElementById("dataform"); 

		if((!Validator.Validate(form_ob,4)))
		{
			return false;
		}

		form_ob.submit();
	}


</script>
    
</body>
<!-- END BODY -->

</html>