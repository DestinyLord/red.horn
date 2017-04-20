var Login = function () {
    
    return {
        //main function to initiate the module
        init: function () {
        	
           $('.login-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            rules: {
	                username: {
	                    required: true
	                },
	                password: {
	                    required: true
	                },
                    captcha_code: {
	                    required: true ,
                        remote: {
                            url: captchaValidatePath,     //后台处理路径
                            type: "post",               //数据发送方式
                            dataType: "json",           //接受数据格式   
                            /*data: {                     //要传递的数据
                                password: function() {
                                    return $("#passworld").val();
                                }
                            }*/
                        },
	                },
	                remember: {
	                    required: false
	                }
	            },

	            messages: {
                    captcha_code: {
                        remote: '验证码错误'
                    }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   
	                //$('.alert-error', $('.login-form')).show();
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
	                error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	            },

	            submitHandler: function (form) {
	                $('.error-info-box').html('');
	                $('.login-loding-box .alert').show();
                    $.post(
                        checkLoginPath ,
                        {'username' :form.username.value ,'password' :form.password.value ,'captcha_code' : form.captcha_code.value},
                        function(res)
                        {
                            if(res == true)
                            {
                                window.location.href=homeUrl;
                            }else
                            {
                                $('.login-loding-box .alert').hide();
                                $('.error-info-box').html('<div class="alert alert-error"><button class="close" data-dismiss="alert"></button><span>请填写正确的用户名和密码</span></div>');
                                $('.login-form').show();
                                form.password.value = '';
                                form.password.focus();
                            }
                        },
                        'json'
                    );
	            }
	        });

	        $('.login-form input').keypress(function (e) {
	            if (e.which == 13) {
	                if ($('.login-form').validate().form()) {
	                    $('.login-form').submit();
	                }
	                return false;
	            }
	        });

        }
    
    };

}();