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
	<link rel="stylesheet" type="text/css" href="<{$css_path}>bootstrap-fileupload.css" />
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

									<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data" >
                                        <input type="hidden" name="type" value="2" />
                                        <input type="hidden" id="selectImg" name="selectImg" value="" />
                                        <input type="hidden" id="oldImg" name="oldImg" value="" />
										<div class="control-group">

											<label class="control-label" >团购活动主题</label>

											<div class="controls">

												<input id="activity_name" dataType="Require" msg="活动主题必须填写" name="activity_name" value="" type="text" placeholder="活动主题" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group ">

											<label class="control-label" for="end_time">即日起至活动结束时间</label>

											<div class="controls">
												<div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value=""  dataType="Require" msg="活动时间必须填写" /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
												<!--<span class="help-inline">即日起至团购开始时间为活动报名期</span>-->
											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="activety_addr">团购地点</label>

											<div class="controls">

												<input dataType="Require" msg="团购地点必须填写" id="activety_addr" name="activety_addr" value="" type="text" placeholder="团购地点" class="m-wrap span6" />

											</div>

										</div>
                                        <div class="control-group seriesBox">

											<label class="control-label">团购车型</label>

											<div class="controls">
												
												<{foreach from=$seriesList item=seriesData name=sl}>
													<{if $smarty.foreach.sl.index % 4 == 0}>
													<div class="row-fluid">
													<{/if}>
														<div class="span3">

															<label class="checkbox line">

															<input type="checkbox" name="series_id[]" value="<{$seriesData.series_id}>" /> <{$seriesData.name}>

															</label>
														</div>
													<{if $smarty.foreach.sl.index % 4 == 3 || $smarty.foreach.sl.last}>	
													</div>
													<{/if}>
   												<{/foreach}>
											</div>           

										</div>
                                        <div class="control-group policyBox">

											<label class="control-label" for="policy">优惠政策</label>

											<div class="controls">
												<input id="policy" name="policy[]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span6" />
												<div class="clearfix"></div><br/>
												<input name="policy[]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span6" />
												<div class="clearfix"></div><br/>
												<input name="policy[]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span6" />
												<span class="help-inline">&nbsp;<a class="icon-plus" onclick="return addPolicy(this);" style="font-size: 16px; " href=""> </a></span>
												
												<span class="help-inline hide policyErrorText">优惠政策必须最少填写3个,并在2-10个字之间</span>
											</div>

										</div> 
										
										<div class="control-group">

											<label class="control-label" for="apply_user">团购已报名基数</label>

											<div class="controls">

												<input dataType="Require" msg="团购已报名基数必须填写" id="apply_user" name="apply_user" value="" type="text" placeholder="团购已报名基数" class="m-wrap span6" />

											</div>

										</div>

										<div class="control-group <{if !check_priv('VIPDealerGrouponCheckOnline')}>last<{/if}>">

											<label class="control-label">首页广告</label>

											<div class="controls">

												<div class="fileupload fileupload-new" data-provides="fileupload">

													<div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

														<img src="<{$image_path}>backend/nopic.jpg" alt="" />

													</div>

													<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>

													<div>

														<span class="btn btn-file"><span class="fileupload-new">选择图片</span>

														<span class="fileupload-exists">更改</span>

														<input type="file" class="default" name="main_picture" /></span>

														<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">清除</a>
														
														<a href="#stack1" class=" btn green" data-toggle="modal">选择文件</a>
														
													</div>

												</div>

												<span class="label label-important">注意!</span>

												<span>

												上传功能只支持Firefox、Chrome,Opera,Safari和ie10或以上浏览器 ,只允许上传 jpg,gif,png格式的图片
												<font color="red">尺寸699 * 350 且大小不超过200K</font>
												</span>

											</div>

										</div>

										<{if check_priv('VIPDealerGrouponCheckOnline')}>      
										<div class="control-group last">

											<label class="control-label" for="status">审核状态</label>

											<div class="controls">
										
													<select name="status" id="status" class="span2" style="margin: 2px 0;">
														<option value="">未审核</option>
														<option value="1">审核通过</option>
														<option value="-1">审核不通过</option>
													</select>
													<input id="check_reason" name="check_reason" value="" type="text" placeholder="审核未通过请给出原因" class="m-wrap span4"  style="margin-left:10px;"/>
												

											</div>

										</div>                                                                                
										<{/if}>
										<div class="form-actions">

											<button type="submit" onclick="return submit_form();" class="btn blue"><i class="icon-ok"></i> 保存</button>

											<button type="reset" class="btn">重置</button>

										</div>

									</form>

									<!-- END FORM-->  

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
    <script type="text/javascript" src="<{$js_path}>bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="<{$js_path}>validator.js"></script>
	
	<script type="text/javascript">

		jQuery(document).ready(function() {       

		   FormSamples.init();
		   if (jQuery().datepicker) {
            $('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd' ,'minDate':'<{date("Y-m-d")}>'});
        }
		});

	</script>
    
<script type="text/javascript">

function addPolicy(obj)
{
	var $this = $(obj);
	var addTtml = '<div class="clearfix"></div><br/><input name="policy[]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span6" /><span class="help-inline">&nbsp;<a class="icon-plus" onclick="return addPolicy(this);" style="font-size: 16px; " href=""> </a>&nbsp;&nbsp;<a class="icon-minus" onclick="return removePolicy(this);" href=""> </a></span>';

	$this.parents('div.controls').append(addTtml);
	return false;
}

function removePolicy(obj)
{
	var $this = $(obj);
	
	$this.parent('span.help-inline').prev('input').prev('br').prev('div.clearfix').remove();
	$this.parent('span.help-inline').prev('input').prev('br').remove();
	$this.parent('span.help-inline').prev('input').remove();
	$this.parent('span.help-inline').remove();

	return false;
}

function submit_form(){
	var form_ob=document.getElementById("dataform"); 
	var series_check = false;
	var policy_check = true;
	
	$('input[name="series_id[]"]').each(function(){
		if($(this).attr('checked'))
		{
			series_check = true;
			return false; //跳出循环
		}
	});

	var policyObj = $('input[name="policy[]"]');

	for(var i=0 ; i < 3; i++)
	{
		if(policyObj.eq(i).val() == '')
		{
			policy_check = false;
			break;
		}
	}

	policyObj.each(function(){
		var tv = $(this).val();
		if(tv != '' && (tv.length > 10 || tv.length < 2))
		{
			policy_check = false;
			return false;
		}
	});

	if((!Validator.Validate(form_ob,4)))
	{
		return false;
	}

	if(series_check == false)
	{
		$('.seriesBox').addClass('error');
		return false;
	}else
	{
		$('.seriesBox').removeClass('error');
	}	

	if(policy_check == false)
	{
		$('.policyErrorText').show();
		$('.policyBox').addClass('error');
		return false;
	}else
	{
		$('.policyErrorText').hide();
		$('.policyBox').removeClass('error');
	}	

	form_ob.submit();
}

</script>


<!--默认图片选择-->
	<{include file=$backendViewDir|cat:'/vipdealer/defautImageSelect.tpl'}>
<!--默认图片选择 END-->    
</body>
<!-- END BODY -->

</html>