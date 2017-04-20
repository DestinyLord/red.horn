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

									<div class="caption"><i class="icon-reorder"></i><{$h3title}></div>

									<div class="tools">

										<a href="javascript:;" class="collapse"></a>

										<a href="#portlet-config" data-toggle="modal" class="config"></a>

										<a href="javascript:;" class="reload"></a>

										<a href="javascript:;" class="remove"></a>

									</div>

								</div>

								<div class="portlet-body form">

									<!-- BEGIN FORM-->

									<form action="<{$formAction}>" method="post" class="form-horizontal form-bordered info-form">
                                        <{if $editData}>
                                        <input type="hidden" name="id" value="<{$editData.action_id}>" />
                                        <input type="hidden" name="old_parent_id" value="<{$editData.parent_id}>" />
                                        <input type="hidden" name="has_child" value="<{$editData.has_child}>" />
                                        <{/if}>
										<div class="control-group">

											<label class="control-label" >所属权限</label>

											<div class="controls">

												<div class="select2-wrapper">

													<select name="parent_id" class="span12 select2_category">

														<option value="0">根权限</option>
                                                        <{foreach from = $permissionList item=v}>
														<option value="<{$v.action_id}>" <{if $editData}><{if $v.action_id == $editData.parent_id}>selected<{/if}><{/if}>>
                                                            <{'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'|str_repeat:($v.level+1)}> |-- 
                                                            <{$v.action_title}>
                                                        </option>
                                                        <{/foreach}>

													</select>

												</div>

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label">权限名称</label>

											<div class="controls">

												<input id="action_title" name="action_title" value="<{if $editData}><{$editData.action_title}><{/if}>" type="text" placeholder="Action Title" class="m-wrap span12" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label">权限标识</label>

											<div class="controls">

												<input id="action_code" name="action_code" value="<{if $editData}><{$editData.action_code}><{/if}>" type="text" placeholder="Action Code" class="m-wrap span12" />

											</div>

										</div>
                                        
                                        <div class="control-group">

											<label class="control-label">关联标识</label>

											<div class="controls">

												<input name="relevance_code" value="<{if $editData}><{$editData.relevance_code}><{/if}>" type="text" placeholder="Relevance Code" class="m-wrap span12" />

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
</body>
<!-- END BODY -->

</html>