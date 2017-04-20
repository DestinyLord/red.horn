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
    <script src="//cdn.bootcss.com/jquery/1.8.3/jquery.min.js"></script>

    <script src="//cdn.bootcss.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
  
    <script src="//cdn.bootcss.com/bootbox.js/4.4.0/bootbox.min.js"></script>
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

					
					<!-- BEGIN EXAMPLE TABLE PORTLET-->

					<div class="portlet box light-grey">

						<div class="portlet-title">

							<div class="caption">
                            
                                <i class="icon-globe"></i>
                                
                                <{$h3title}>列表
                                
                            </div>
                            

						</div>

						<div class="portlet-body">

							<div class="clearfix">
                                <div class="row-fluid form-horizontal">
                                	
                                	<div class="span3">
                                        <div class="control-group">

                                            <label class="control-label" style="width:80px;" for="out_no">订单号：</label>

                                            <div class="controls" style="margin-left:80px;">

                                                <input type="text" id="out_no" class="m-wrap span12" placeholder="订单号" value="<{$out_no}>" />

                                            </div>

                                        </div>
                                    </div>
                                    <div class="span3">
                                        <div class="control-group">

                                            <label class="control-label" style="width:80px;" for="mobile">手机号：</label>

                                            <div class="controls" style="margin-left:80px;">

                                                <input type="text" id="mobile" class="m-wrap span12" placeholder="手机号" value="<{$mobile}>" />

                                            </div>

                                        </div>
                                    </div>
                                    <div class="span4">
                                        <div class="control-group">

                                            <label class="control-label" style="width:100px;" for="identifier">专营店代码：</label>

                                            <div class="controls" style="margin-left:100px;">

                                                <input type="text" id="identifier" class="m-wrap span12" placeholder="店代码" value="<{$identifier}>" />

                                            </div>

                                        </div>
                                    </div>
                                    <div class="span2">
                                    	<button  class="m-wrap btn btn-primary" onclick="search()">搜索</button>
                                    </div>

                                </div>
                                <!--<div class="btn-group">
                                    <div class="col-sm-3">
                                        订单号：<input type="text" class="form-control" id="out_no" placeholder="订单号" value='<{$out_no}>'/>
                                        手机号：<input type="text" class="form-control" id="mobile" placeholder="手机号" value='<{$mobile}>'/>
                                <{if $admin_role_id<4}>
                                        专营店代码 <input type="text" class="form-control" id="identifier" placeholder="店代码" value='<{$identifier}>'/>
                                <{/if}>       
                                        <input type="button" class="btn btn-primary" onclick="search()" value="搜索"/>
                                    </div>
                                    
                                        
                                    
                                    <div class="col-sm-3">
                                        
                                    </div>
                                </div>-->
                                
							</div>
							<div class="tabbable tabbable-custom boxless">

								<ul class="nav nav-tabs">
                                  <!--<li <{if $act == 0}>class="active"<{/if}>><a href="?act=0">全部<span class="badge"><{$total[0]}></span></a></li>
                                  <li <{if $act == 1}>class="active"<{/if}>><a href="?act=1">已支付 <span class="badge"><{$total[1]}></span></a></li>
                                  <li <{if $act == 2}>class="active"<{/if}>><a href="?&act=2">已受理<span class="badge"><{$total[2]}></span></a></li>
                                  <li <{if $act == 3}>class="active"<{/if}>><a href="?act=3">车已到店 <span class="badge"><{$total[3]}></span></a></li>
                                  <li <{if $act == 4}>class="active"<{/if}>><a href="?act=4">服务中<span class="badge"><{$total[4]}></span></a></li>
                                  <li <{if $act == 5}>class="active"<{/if}>><a href="?act=5">服务完成 <span class="badge"><{$total[5]}></span></a></li>
                                  <li <{if $act == 6}>class="active"<{/if}>><a href="?act=6">交易完成 <span class="badge"><{$total[6]}></span></a></li>
  
                                  <li <{if $act == 8}>class="active"<{/if}>><a href="?act=8">退款<span class="badge"><{$total[8]}></span></a></li>
                                  <li <{if $act == 9}>class="active"<{/if}>><a href="?act=9">已取消 <span class="badge"><{$total[9]}></span></a></li>-->
                                  <li <{if $act == 1}>class="active"<{/if}>><a href="?act=1">待接单 <span class="badge"><{$total[0]}></span></a></li>
                                  <li <{if $act == 2}>class="active"<{/if}>><a href="?act=2">待客户验收 <span class="badge"><{$total[1]}></span></a></li>
                                  <li <{if $act == 3}>class="active"<{/if}>><a href="?act=3">交易成功 <span class="badge"><{$total[2]}></span></a></li>
                                  <li <{if $act == 4}>class="active"<{/if}>><a href="?act=4">待付款 <span class="badge"><{$total[3]}></span></a></li>
                                  <li <{if $act == 5}>class="active"<{/if}>><a href="?act=5">已取消 <span class="badge"><{$total[4]}></span></a></li>
                                  <li <{if $act == 6}>class="active"<{/if}>><a href="?act=6">已退款 <span class="badge"><{$total[5]}></span></a></li>

								</ul>

								<div class="tab-content">
                                    
									<div class="tab-pane active" id="tab_1">
                                    
										<table class="table table-striped table-bordered table-hover" id="sample_4" style="font-size:11px">

											<thead>

												<tr>
                                                  <th width="3%">序号</th>
                                                  <th width="7%">保养订单编号</th>
                                                  <th width="10%">下单时间</th>
                                                  <th width="10%">门店</th>
                                                  <th width="10%">姓名</th>
                                                  <th width="10%">手机号码</th>
                                                  <th width="10%">预约时间</th>
                                                  <th width="10%">金额</th>
                                                  <th width="10%">订单状态</th>
                                                 
                                                  <th width="10%">订单详情</th>
                                                  <th width="10%">操作</th>
                                                </tr>

											</thead>
    
											<tbody>
<{if count($orderData['lists'])}>
                                             <{assign var='i' value="1"}>
                                <{foreach from=$orderData['lists'] item=v}>
                                  
		                                        <tr>         
                                                      <td><{$i++}></td>
	                                                  <td><{$v.out_no}></td>
	                                                  <td><{date("Y-m-d H:i:s", $v.dateline)}></td>
	                                                  <td ><{$store[$v['identifier']]['name']}></td>
	                                                  <td ><{$deal_extends[$v['id']]['extend']['name']}></td>
	                                                  <td ><{$deal_extends[$v['id']]['extend']['mobile']}></td>
	                                                  <td ><{date("Y-m-d H:i:s", $deal_extends[$v['id']]['reserve_time'])}></td>
	                                                  <td ><{moneyFormat($v.fee)}>元</td>
	                                                  <td ><{deal_status(1,$v)}></td>	      
	                                                   <td><a href="/index.php/backend/order/orderDetail/<{$v.id}>" target="_blank">订单详情</a></td>                   
	                                                  <td ><{assign var='status_key' value=deal_status(1,$v,1)}>     
                                                           
                                                                <{if $status_key == '1_1_0_0'}>
                                                                    <input type="button" class="btn btn-primary btn-xs" onclick="update_status(this,'<{$v['out_no']}>','1_1_1_0')" value="确认服务" style="background-color: #c90024;color: #fff;" /><br/>
                                                                    <input type="button" class="btn btn-primary btn-xs" style="margin-top: 3px;" onclick="update_status(this,'<{$v['out_no']}>','-2_4_0_0')" value="取消订单" style="color: #fff;"/>    
                                                                <{/if}>
                                                                <{if $status_key == '1_1_1_0'}>
                                                                    <input type="button" class="btn btn-primary btn-xs" onclick="verify_code('<{$v['out_no']}>')" value="核销" style="background-color: #c90024;color: #fff;" />
                                                                <{/if}>
                                                                <{if $status_key == '1_1_2_0'}>
                                                                    <input type="button" class="btn btn-primary btn-xs" onclick="update_status(this,'<{$v['out_no']}>','1_1_3_0')" value="服务开始" style="background-color: #c90024;color: #fff;"/>
                                                                <{/if}>
                                                                <{if $status_key == '1_1_3_0'}>
                                                                    <input type="button" class="btn btn-primary btn-xs" onclick="update_status(this,'<{$v['out_no']}>','1_1_4_0')" value="服务完成" style="background-color: #c90024;color: #fff;" />
                                                                <{/if}>
                                                                <{if $status_key == '1_3_1_0'}>
                                                                    <input type="button" class="btn btn-primary btn-xs" onclick="update_status(this,'<{$v['out_no']}>','-2_4_1_0')" value="同意退款" style="background-color: #c90024;color: #fff;" />
                                                                <{/if}></td>
                                                      
                                                </tr>
												
                                <{/foreach}>    
<{/if}>                                     
											</tbody>

										</table>
                                        
                                       <ul class="pagination"><{$orderData['multi']}></ul>
                                        
				                    </div>
                                        
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

	<script type="text/javascript" src="<{$js_path}>jquery.dataTables.js"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="<{$js_path}>table-managed.js"></script>     
	<script>
        jQuery(document).ready(function(e) {
            TableManaged.init();
            console.log();
            
		});
       // 搜索订单
            function search()
            {
                var identifier = $.trim($('#identifier').val());
                var out_no = $.trim($('#out_no').val());
                var mobile = $.trim($('#mobile').val());
                var params = '';
                if(identifier!=''){
                    params += '&identifier='+identifier;
                }
                if(out_no!=''){
                    params += '&out_no='+out_no;
                }
                if(mobile!=''){
                    params += '&mobile='+mobile;
                }
                window.location.href='/index.php/backend/order?act={$act}'+params;
            } 
            //改变订单状态
            function update_status(obj,out_no,update_status_str){
                
                bootbox.confirm({
        			message:'您确定要操作该订单吗？',
              closeButton:false ,
        			buttons:{cancel:{label:'取消'},confirm:{label:'确定'}},
                    callback:function(res){
		                        if(res){
		                            $(obj).attr('disabled','disabled');
		                            $.post('/index.php/backend/order/update_status',{'out_no':out_no,'update_status_str':update_status_str},function(response){
		                                if(response.error){
				                            bootbox.alert({closeButton:false ,message:response.msg});    
				                        }else{
				                            //setTimeout(function(){
				                            if(update_status_str == '1_1_1_0'){
				                                window.location.href = '?act=2';    
				                            }
				                            if(update_status_str == '-2_4_0_0'){
				                                window.location.href = '?act=9'; 
				                            }
				                            if(update_status_str == '1_1_3_0'){
				                                window.location.href = '?act=4'; 
				                            }
				                            if(update_status_str == '1_1_4_0'){
				                                window.location.href = '?act=5'; 
				                            }
				                            if(update_status_str == '-2_4_1_0'){
				                                window.location.href = '?act=8'; 
				                            }
				                            //},1000);  // '?'+getUrl()    
				                        }
                            
                            },'json');    
                        }
                           
                    }
                });     
            }
        
            // 输入验证码
            function verify_code(out_no)
            {
                $.get('/index.php/backend/order/verify_code',{},function(view){
                    bootbox.confirm({
                        title:'验证码',
                        message:view.data,
                        closeButton:false,
                        buttons:{cancel:{label:'取消'},confirm:{label:'确定'}},
                        callback:function(result){
                            if(result){
                                $.post('/index.php/backend/order/doverify',{'out_no':out_no,'verify_code':$('#verify_code').val()},function(response){
                                    bootbox.alert({closeButton:false ,message:response.msg});
                                    if(!response.error){
                                        setTimeout(function(){window.location.href='?act=2';},1000);
                                    }
                                    
                                },'json');    
                            }
                        }
                    });
                },'json');
            }
        
        
 
            
	</script>

</body>
<!-- END BODY -->

</html>