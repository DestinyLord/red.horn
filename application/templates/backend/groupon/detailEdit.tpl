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

					<!-- BEGIN EXAMPLE TABLE PORTLET-->

					

					<div class="portlet box blue ">

						<div class="portlet-title">

							<div class="caption"><i class="icon-reorder"></i><{$h3title}></div>

						</div>

						<div class="portlet-body form">

							<!-- BEGIN FORM-->

							<form id="data-form" name="infoform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data" >
								
								<input type="hidden" name="id" value="<{$editData.id}>" />
								<div class="tabbable tabbable-custom boxless">

									<ul class="nav nav-tabs">

										<li class="active"><a href="#tab_1" data-toggle="tab">基本信息</a></li>

										<li><a class="" href="#tab_2" data-toggle="tab">团购现场流程</a></li>

										<li><a class="" href="#tab_3" data-toggle="tab">团购政策详情</a></li>

										<li><a class="" href="#tab_4" data-toggle="tab">团购现场花絮图片</a></li>

									</ul>

									<div class="tab-content">

										<div class="tab-pane active" id="tab_1">
											<div class="control-group">

												<label class="control-label">本期团购期号</label>

												<div class="controls">

													<span class="m-wrap span6"><{$editData.number}></span>
													<div class="clearfix"></div>
												</div>

											</div>

											<div class="control-group">

												<label class="control-label">本期团购主题</label>

												<div class="controls">

													<span class="m-wrap span6"><{$editData.groupon_name}></span>
													<div class="clearfix"></div>
												</div>

											</div>

											<div class="control-group">

												<label class="control-label">客户报名时间</label>

												<div class="controls">

													<span class="m-wrap span6"><{$editData.start_time|date_format:"%Y年%m月%d日"}> &nbsp;至&nbsp; <{$editData.end_time|date_format:"%Y年%m月%d日"}></span>
													<div class="clearfix"></div>
												</div>

											</div>


											<div class="control-group seriesBox">

												<label class="control-label">开团时间</label>

												<div class="controls">
													
													<div class="row-fluid">
													
														<div class="span3">

															<label class="radio line">
															<{assign var='sat' value=($editData.end_time-86400)|date_format:"%Y-%m-%d"}>
															<input <{if $editData.join_date.0 == $sat}>checked="true"<{/if}> type="radio" name="join_date[]" value="<{$sat}>" /> 本周六（<{($editData.end_time-86400)|date_format:"%m月%d日"}>）

															</label>
														</div>

														<div class="span3">

															<label class="radio line">
															<{assign var='sun' value=($editData.end_time)|date_format:"%Y-%m-%d"}>
															<input <{if $editData.join_date.0 == $sun}>checked="true"<{/if}> type="radio" name="join_date[]" value="<{$sun}>" /> 本周日（<{($editData.end_time)|date_format:"%m月%d日"}>）

															</label>
														</div>
													
													</div>
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

																<input <{if $seriesData.series_id|in_array:$editData.series_id}>checked="true"<{/if}> type="checkbox" name="series_id[]" value="<{$seriesData.series_id}>" /> <{$seriesData.name}>

																</label>
															</div>
														<{if $smarty.foreach.sl.index % 4 == 3 || $smarty.foreach.sl.last}>	
														</div>
														<{/if}>
														<{/foreach}>
												</div>           

											</div>
											<!--<div class="control-group">

												<label class="control-label" for="apply_user">团购已报名基数</label>

												<div class="controls">

													<input id="apply_user" name="apply_user" value="" dataType="Number" msg="报名基数必须为正整数" type="text" placeholder="团购已报名基数" class="m-wrap span6" />

												</div>

											</div>-->
											<div class="control-group policyBox">

												<label class="control-label" for="favorable">优惠政策</label>

												<div class="controls">
													<{if $editData.favorable}>
													<{foreach $editData.favorable item=v name="poli"}>
													<{if $smarty.foreach.poli.index != 0}><div class="clearfix"></div><br/><{/if}>
													<input <{if $smarty.foreach.poli.index == 0}>id="favorable"<{/if}> name="favorable[]" value="<{$v}>" type="text" placeholder="优惠政策10个字以内" class="m-wrap span6" />
													
													<span class="help-inline">&nbsp;<a class="icon-plus" onclick="return addPolicy(this);" style="font-size: 16px; " href=""> </a><{if $smarty.foreach.poli.index > 2}> &nbsp;&nbsp;<a class="icon-minus" onclick="return removePolicy(this);" href=""> </a><{/if}></span>

													<{/foreach}>
													<{/if}>
													<span class="help-inline hide policyErrorText">优惠政策必须最少填写3个,并在2-10个字之间</span>
												</div>

											</div> 
											
											<div class="control-group <{if !check_priv('joinGrouponCheckOnline')}>last<{/if}>">

												<label class="control-label">团购封面图片</label>

												<div class="controls">

													<div class="fileupload fileupload-new" data-provides="fileupload">

														<div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">

															<img src="<{if $editData.pic_path}><{base_url uri=$editData.pic_path}><{else}><{$image_path}>backend/nopic.jpg<{/if}>" alt="" />

														</div>

														<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>

														<div>

															<span class="btn btn-file"><span class="fileupload-new">选择图片</span>

															<span class="fileupload-exists">更改</span>

															<input type="file" class="default" name="pic_path" /></span>

															<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">清除</a>
															
															<!--<a href="#stack1" class=" btn green" data-toggle="modal">选择文件</a>-->
															
														</div>

													</div>

													<span class="label label-important">注意!</span>

													<span>

													上传功能只支持Firefox、Chrome,Opera,Safari和ie10或以上浏览器 ,只允许上传 jpg,gif,png格式的图片
													<font color="red">尺寸699 * 350 且大小不超过200K</font>
													</span>

												</div>

											</div>

											<{if check_priv('joinGrouponCheckOnline')}>      
											<div class="control-group last">

												<label class="control-label" for="status">审核状态</label>

												<div class="controls">
											
														<select name="status" id="status" class="span2" style="margin: 2px 0;">
															<option <{if $editData.status == 1}>selected="true"<{/if}> value="1">未处理</option>
															<option <{if $editData.status == 2}>selected="true"<{/if}> value="2">审核通过</option>
															<option <{if $editData.status == 3}>selected="true"<{/if}> value="3">审核不通过</option>
														</select>
														<input id="check_reason" name="check_reason" value="" type="text" placeholder="审核未通过请给出原因" class="m-wrap span4"  style="margin-left:10px;"/>
													

												</div>

											</div>                                                                                
											<{/if}>
											
										</div>

										<div class="tab-pane " id="tab_2">
											<{$ckeditor->editor('flow' ,$editData.flow)}>
										</div>

										<div class="tab-pane " id="tab_3">
											<{$ckeditor->editor('policy' ,$editData.policy)}>
										</div>

										<div class="tab-pane uploads-box" id="tab_4">
											
											<iframe id="result" width="100%" height="380" src='<{site_url uri=$backendDir|cat:'/uploadFile/uploadTemplate/grouponDetail'}>?delUrl=groupon/delDetailImage&imgData=<{$editData.images}>' frameborder="0"></iframe>
										</div>
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
	<script type="text/javascript" src="<{$js_path}>bootstrap-fileupload.js"></script>

	

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
	var addTtml = '<div class="clearfix"></div><br/><input name="favorable[]" value="" type="text" placeholder="优惠政策10个字以内" class="m-wrap span6" /><span class="help-inline">&nbsp;<a class="icon-plus" onclick="return addPolicy(this);" style="font-size: 16px; " href=""> </a>&nbsp;&nbsp;<a class="icon-minus" onclick="return removePolicy(this);" href=""> </a></span>';

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
	var form_ob=document.getElementById("data-form"); 
	var series_check = false;
	var policy_check = true;
	
	$('input[name="series_id[]"]').each(function(){
		if($(this).attr('checked'))
		{
			series_check = true;
			return false; //跳出循环
		}
	});

	var policyObj = $('input[name="favorable[]"]');

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
    
</body>
<!-- END BODY -->

</html>