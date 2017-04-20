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
    <link rel="stylesheet" type="text/css" href="<{$css_path}>clockface.css" />
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

									<div class="caption"><i class="icon-reorder"></i><{$couponType[$data.type]}>&nbsp;<{$h3title}></div>

								</div>

								<div class="portlet-body form">

									<!-- BEGIN FORM-->

									<form id="dataform" action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form" enctype="multipart/form-data" >
                                    
                                        <input type="hidden" name="id" value="<{$data.id}>" />
                                        <input type="hidden" name="status" value="1" />
                                        <input type="hidden" name="type" value="<{$data.type}>" />
                                        
										<div class="control-group">

											<label class="control-label" for="coupon_name">优惠券名称</label>

											<div class="controls">

												<input id="coupon_name" name="coupon_name" value="<{$data.coupon_name}>" type="text" placeholder="优惠券名称" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group seriesBox">

											<label class="control-label" for="series_id">活动车系</label>
                                            
                                            <div class="controls">
                                            
                                                <{if $data.type == 1}>
                                                
    												<{foreach from=$seriesList item=seriesData name=sl}>
    													<{if $smarty.foreach.sl.index % 4 == 0}>
    													<div class="row-fluid">
    													<{/if}>
    														<div class="span3">
    
    															<label class="checkbox line">
    
    															<input type="checkbox" <{if in_array($seriesData.series_id ,$data.series_id )}>checked="true"<{/if}> name="series_id[]" value="<{$seriesData.series_id}>" /> <{$seriesData.name}>
    
    															</label>
    														</div>
    													<{if $smarty.foreach.sl.index % 4 == 3 || $smarty.foreach.sl.last}>	
    													</div>
    													<{/if}>
       												<{/foreach}>
                                                
                                                <{elseif $data.type == 2}>
                                                
                                                    <div class="select2-wrapper">

    													<select name="series_id" id="series_id" class="span4 select2_category" tabindex="1" dataType="Require" msg="活动车系必须选择">
    
    														<option value="">请选择活动车系</option>
    															
    														<{foreach from=$seriesList item=seriesData}>
    														
                                                                <option <{if $seriesData.series_id==$data.series_id}>selected="true"<{/if}> value="<{$seriesData.series_id}>"><{$seriesData.name}></option>
    
    														<{/foreach}>
    															
    													</select>
                                                        
    												</div>
                                                
                                                <{/if}>
   
											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="price">券面金额</label>

											<div class="controls">

												<input dataType="Require" msg="券面金额必须填写" id="price" name="price" value="<{$data.price}>" type="text" placeholder="券面金额" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="sell_price">抢购定金</label>

											<div class="controls">

												<input dataType="Require" msg="抢购定金必须填写" id="sell_price" name="sell_price" value="<{$data.sell_price}>" type="text" placeholder="抢购定金" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="command">口令</label>

											<div class="controls">

												<input dataType="Require" msg="口令必须填写" id="command" name="command" value="<{$data.command}>" type="text" placeholder="口令" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="totality">每日数量</label>

											<div class="controls">

												<input dataType="Require" msg="每日数量必须填写" id="totality" name="totality" value="<{$data.totality}>" type="text" placeholder="每日数量" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

    										<label class="control-label">每日开抢时间</label>
    
    										<div class="controls">
    
    											<div class="input-append">
    
    												<input type="text" id="grab" name="grab" value="<{$data.grab}>" class="m-wrap small" readonly="" />
    
    												<button class="btn" type="button" id="grab_toggle" style="padding:10px 8px">
    
    												    <i class="icon-time"></i>
    
    												</button>
    
    											</div>
    
    										</div>
    
    									</div>
                                        
                                        
                                        <div class="control-group ">

											<label class="control-label" for="end_time">结束时间</label>

											<div class="controls">
                                                                                                
												<div class="input-append date date-picker" >

													<input class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value="<{$data.end_time}>"  dataType="Require" msg="启止时间必须填写" /><span class="add-on" ><i class="icon-calendar"></i></span>

												</div>
                                                
												<span class="help-inline">活动结束，自动下架</span>
                                                
											</div>

										</div>
										
										<div class="control-group">

											<label class="control-label" for="apply_user">报名基数</label>

											<div class="controls">

												<input id="apply_user" name="apply_user" value="<{$data.apply_user}>" type="text" placeholder="报名基数" class="m-wrap span4" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="leads_key">留资Key值</label>

											<div class="controls">

												<input dataType="Require" msg="留资Key值必须填写" id="leads_key" name="leads_key" value="<{$data.leads_key}>" type="text" placeholder="留资Key值" class="m-wrap span6" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="num_iid">宝贝URL</label>

											<div class="controls">

												<span>
                                                
                                                    <input dataType="Require" msg="宝贝id必须填写" id="num_iid" name="num_iid" value="<{$data.num_iid}>" type="text" placeholder="宝贝id" class="m-wrap span2 changeURL" />
                                                    
                                                </span>
                                                
                                                <span>
                                                
                                                    <input dataType="Require" msg="宝贝sku_id必须填写" id="sku_id" name="sku_id" value="<{$data.sku_id}>" type="text" placeholder="宝贝sku_id" class="m-wrap span2 changeURL" />
                                                
                                                </span>
                                                
                                                <span id="URL">https://detail.tmall.com/item.htm?id=<{$data.num_iid}>&skuId=<{$data.sku_id}></span>

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label" for="sort">排序</label>

											<div class="controls">

												<input id="sort" name="sort" value="<{$data.sort}>" type="text" placeholder="排序" class="m-wrap span4" />
                                                
                                                <span class="help-inline">数字越大，排序越前</span>

											</div>

										</div>

										<div class="control-group">
                                        
                                            <label class="control-label" for="pic_path">
                                                图片<br /> 
                                                （不上传使用默认图片）
                                            </label>

											<div class="controls">

												<div class="fileupload fileupload-new" data-provides="fileupload">

													<div class="fileupload-new thumbnail" style="width: 260px; height: 125px;">

														<img src="<{if $data.pic_path}><{base_url uri=$data.pic_path}><{else}><{$image_path}>backend/nopic.jpg<{/if}>" alt="" />

													</div>

													<div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 260px; max-height: 125px; line-height: 20px;"></div>

													<div>

														<span class="btn btn-file">
                                                            
                                                            <span class="fileupload-new">选择图片</span>
                                                        
                                                            <span class="fileupload-exists">更改</span>
                                                            
                                                            <input type="file" class="default" name="pic_path" />
                                                            
                                                        </span>

														<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">清除</a>
                                                        
                                                    </div>

												</div>

												<span class="label label-important help-inline">注意!</span>

												<span class="help-inline">

												上传功能只支持Firefox、Chrome,Opera,Safari和ie10或以上浏览器 ,只允许上传 jpg,gif,png格式的图片

												</span>

											</div>

										</div>
                                        
										<div class="form-actions">

											<button type="submit" onclick="return submit_form();" class="btn blue"><i class="icon-ok"></i> 发布</button>

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
    <script type="text/javascript" src="<{$js_path}>clockface.js"></script>

	<script type="text/javascript">
        jQuery(document).ready(function() {
            FormSamples.init();
            if (jQuery().datepicker) {
                $('.date-picker').datepicker({'language':'zh' ,'format':'yyyy-mm-dd' ,'minDate':'<{date("Y-m-d")}>'});
            }
            
            //时钟
            $('#grab').clockface({
                format: 'HH:mm',
                trigger: 'manual'
            });
            
            //更改URL
            $(".changeURL").change(function() {
                changeURL();
            });
		});
        
        $('#grab_toggle').click(function (e) {
            e.stopPropagation();
            $('#grab').clockface('toggle');
        });
        
        function submit_form(){
        	var form_ob=document.getElementById("dataform"); 
        	var series_check = false;  //  判断是否有勾选车系
            
            if((!Validator.Validate(form_ob, 4)))
        	{
        		return false;
        	}
            
            $('input[name="series_id[]"]').each(function(){
        		if($(this).attr('checked'))
        		{
        			series_check = true;
        			return false; //跳出循环
        		}
        	});
            
            if($('#series_id').val())
            {
                series_check = true;
            }
            
            if(series_check == false)
        	{
        		$('.seriesBox').addClass('error');
        		return false;
        	}else
        	{
        		$('.seriesBox').removeClass('error');
        	}
        
        	form_ob.submit();
        }
        
        function changeURL()
        {
            var num_iid = $("#num_iid").val();
            var sku_id = $("#sku_id").val();
            var URL = "https://detail.tmall.com/item.htm?id=" + num_iid + "&skuId=" + sku_id;
            $("#URL").html(URL);
        }

	</script>
    
</body>
<!-- END BODY -->

</html>