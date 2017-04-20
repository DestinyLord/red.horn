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

									<div class="caption"><i class="icon-reorder"></i><{$h3title}>  → <{$name}> (<{if $type == 'admin_user'}>管理员<{else}>角色<{/if}>)</div>

									<!--<div class="tools">

										<a href="javascript:;" class="collapse"></a>

										<a href="#portlet-config" data-toggle="modal" class="config"></a>

										<a href="javascript:;" class="reload"></a>

										<a href="javascript:;" class="remove"></a>

									</div>-->

								</div>

								<div class="portlet-body form">

									<!-- BEGIN FORM-->

									<form action="<{site_url uri=$backendDir|cat:'/permission/setAction' }>" method="post" class="form-horizontal form-bordered info-form">
                                        <input type="hidden" name="type" value="<{$type}>" />
                                        <input type="hidden" name="id" value="<{$id}>" />
										<{foreach from = $actionList item = v}>
                                        <{if $v.parent_id == 0}>
                                        <div class="control-group">

											<label class="control-label checkbox pcode">
                                            
                                                <input name="actionList[]" <{if $v.action_code|in_array:$curData}>checked="true"<{/if}> type="checkbox" value="<{$v.action_code}>" />

                                                <{$v.action_title}>
                                            
                                            </label>

											<div class="controls">
                                                <{foreach from = $actionList item = codeList}>
                                                <{if $codeList.parent_id == $v.action_id}>
    											<label class="checkbox" relevance_code = '<{$codeList.relevance_code}>' id="<{$codeList.action_code}>">

                                                    <input name="actionList[]" <{if $codeList.action_code|in_array:$curData}>checked="true"<{/if}> type="checkbox" value="<{$codeList.action_code}>" />

                                                    <{$codeList.action_title}>
    
    											</label>
                                                <{/if}>
    											<{/foreach}>

                                            </div>

										</div>
                                        <{/if}>
                                        <{/foreach}>
										<div class="form-actions">

											<button type="submit" class="btn blue"><i class="icon-ok"></i> 保存</button>

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
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>form-samples.js"></script>    

	<script type="text/javascript">

		jQuery(document).ready(function() {       

		   FormSamples.init();

		});

	</script>
    
    <script type="text/javascript">
        jQuery(function(){
        
            $('.info-form').validate({
	            errorElement: 'span', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            rules: {
	                action_title: {
	                    required: true
	                },
	                action_code: {
	                    required: true
	                }
                    
	            },

	            messages: {
	                action_title: {
	                    required: " 权限名称不能为空"
	                },
	                action_code: {
	                    required: " 权限标识不能为空"
	                }
	            },

	            highlight: function (element) { // hightlight error inputs
	                $(element)
	                    .closest('.control-group').addClass('error'); // set error class to the control group
	            },

	            success: function (label) {
	                label.closest('.control-group').removeClass('error');
	                label.remove();
	            },

	            errorPlacement: function (error, element) {
	                error.insertAfter(element.closest('input'));
	            },

	            submitHandler: function (form) {
                    form.submit();
	            }
	        });
            
            
        });
    </script>
    
<script type="text/javascript">
$(function(){
    $('.pcode').click(function(){
        if($(this).find('.checker span').hasClass('checked'))
        {
            $(this).siblings('.controls').find('.checkbox span').addClass('checked')
            .find('input').attr('checked' ,true);
        }else
        { 
            $(this).siblings('.controls').find('.checkbox span').removeClass('checked')
            .find('input').removeAttr('checked');
        }
    })
    
    $('.controls .checkbox').click(function(){
        if($(this).find('span').hasClass('checked'))
        {
            var relevance_code = $(this).attr('relevance_code');
            $('#'+relevance_code).find('span').addClass('checked')
            .find(':input').attr('checked','true');
            $(this).parents('.controls').prev('label').find('.checker span').addClass('checked')
            .find(':input').attr('checked','true');
        }else
        {
            //把关联到这个CODE的选择全部移除
            if(!$(this).attr('relevance_code'))
            {
                var actionCode = $(this).attr('id');

                $(this).siblings('label[relevance_code="'+actionCode+'"]').find('.checker span').each(function(){
                    $(this).removeClass('checked')
                    .find(':input').removeAttr('checked');
                })
            }
            
            if($(this).parents('.controls').find('span.checked').length == 0)
            {
                $(this).parents('.controls').prev('label').find('.checker span').removeClass('checked')
                .find(':input').removeAttr('checked');
            }
        } 
    });
})
</script>
</body>
<!-- END BODY -->

</html>