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
                                    <input type="hidden" name="type" value="1" />
									<div class="control-group">

										<label class="control-label" >车型</label>

										<div class="controls">

											<div class="select2-wrapper">

												<select name="series_id" class="span4 select2_category" tabindex="1">

													<option value="">请选择车系</option>
													<{if check_priv('VIPDealerCarCheckOnline')}>
														<optgroup label="日产">
															<{foreach from=$seriesList1 item=ns}>
															<option value="<{$ns.series_id}>"><{$ns.name}></option>

															<{/foreach}>
														</optgroup>

														<optgroup label="启辰">
															<{foreach from=$seriesList2 item=qcs}>
															<option value="<{$qcs.series_id}>"><{$qcs.name}></option>
															<{/foreach}>
														</optgroup>
														
													<{else}>
														<{foreach from=$seriesList1 item=ns}>
														<option value="<{$ns.series_id}>"><{$ns.name}></option>
														<{/foreach}>
													<{/if}>
												</select>

												<select name="model_id" class="span4 select2_category" tabindex="1" dataType="Require" msg="车型必须选择">

													<option value="">请选择</option>

												</select>
												
											</div>

										</div>

									</div>
                                    
                                    <div class="control-group">

										<label class="control-label" >车身颜色</label>

										<div class="controls">

											<div class="select2-wrapper">

												<select name="color" class="span6 select2_category" dataType="Require" msg="车型颜色必须选择">

													<option value="">请选择颜色</option>
                                                  

												</select>

											</div>

										</div>

									</div>
                                    
                                    <div class="control-group">

										<label class="control-label" for="stock">库存</label>

										<div class="controls">

											<input dataType="Number" msg="库存必须为正整数" id="stock" name="stock" value="" type="text" placeholder="库存" class="m-wrap span6" />

										</div>

									</div>
                                    <div class="control-group ">

										<label class="control-label" for="price">价格</label>

										<div class="controls">

											<input dataType="BetweenTo" require="true" msg="价格必须为大于0的整数且不能大于车型指导价" min="1" max="1" id="price" name="price" value="" type="text" placeholder="价格" class="m-wrap span6" /> 
											<span class="help-inline">元 官方指导价：<font class="model-price">XX</font>元，优惠：<font class="favorable-price">XX</font>元</span>

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

									<div class="control-group <{if !check_priv('VIPDealerCarCheckOnline')}>last<{/if}>">

										<label class="control-label" for="end_time">活动时间</label>

										<div class="controls">
											
											<span class="help-inline">即日起至 &nbsp;&nbsp;</span>
											<div class="input-append date date-picker" >

												<input dataType="Require" msg="活动时间必须填写" class="m-wrap m-ctrl-medium date-picker" id="end_time" name="end_time" readonly size="16" type="text" value="" /><span class="add-on" ><i class="icon-calendar"></i></span>

											</div>

										</div>

									</div>
									<{if check_priv('VIPDealerCarCheckOnline')}>      
									<div class="control-group last">

										<label class="control-label" for="status">审核状态</label>

										<div class="controls">
									
												<select name="status" id="status" class="span2" style="margin: 2px 0;">
													<option value="0">未审核</option>
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
        jQuery(function(){
            $('select[name="series_id"]').change(function(){
            	var series_id = $(this).val();
            	$('select[name="model_id"]').html('<option value="">请选择车型</option>');
            	$('select[name="color"]').html('<option value="">请选择颜色</option>');
            	$('#s2id_autogen3 a.select2-choice span').html('请选择车型');
            	$('#s2id_autogen5 a.select2-choice span').html('请选择颜色')
            	$.post(
            			'/index.php/<{$backendDir}>/vipdealer/getModelList/'+series_id ,
            			{} ,
            			function(res){
            				if(res.datas != '')
            				{
            					var html = '<option value="">请选择车型</option>';
            					for(var i in res.datas)
            					{
            						html += '<option value="'+res.datas[i].model_id+'">'+res.datas[i].model_name+'</option>'
            					}

            					$('select[name="model_id"]').html(html);
            				}
            			} ,
            			'json'
            	);
            });
            
            $('select[name="model_id"]').change(function(){
            	$('select[name="color"]').html('<option value="">请选择颜色</option>');
            	$('#s2id_autogen5 a.select2-choice span').html('请选择颜色');
            	$('font.model-price').text('XX');
            	var model_id = $(this).val();
            	$.post(
            		'/index.php/<{$backendDir}>/vipdealer/getModelInfo/'+model_id ,
            		{} ,
            		function(res)
            		{
            			if(res != '')
            			{
            				var priceVal = $('#price').val();
            				if(priceVal != '')
            				{
            					$('font.favorable-price').text(res.model_price / 100 - priceVal);
            				}

            				$('font.model-price').text(res.model_price / 100);
            				$('#price').attr('max' ,res.model_price / 100);//设置价格的最大值
            				var html = '';
            				if(res.model_color)
            				{
	            				for(var i in res.model_color)
	            				{
	            					html += '<option value="'+res.model_color[i].color_name+'">'+res.model_color[i].color_name+'</option>'
	            				}
	            				$('select[name="color"]').html(html);
            				}
            			}
            		} ,
            		'json'
            	);
            });


            $('#price').change(function(){
            	var model_price = $('.model-price').text();
            	var cur_price = $(this).val();
            	var favorable_price = model_price - cur_price;
            	if(parseInt(model_price) > 0)
            	{
            		$('.favorable-price').text(favorable_price);
            	}
            })


        });

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
	var policy_check = true;


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