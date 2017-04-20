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
                        remote: "验证码错误"
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

	        $('.forget-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            ignore: "",
	            rules: {
	                email: {
	                    required: true,
	                    email: true
	                }
	            },

	            messages: {
	                email: {
	                    required: "Email is required."
	                }
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   

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
	                window.location.href = "main.html";
	            }
	        });

	        $('.forget-form input').keypress(function (e) {
	            if (e.which == 13) {
	                if ($('.forget-form').validate().form()) {
	                    window.location.href = "main.html";
	                }
	                return false;
	            }
	        });

	        jQuery('#forget-password').click(function () {
	            jQuery('.login-form').hide();
	            jQuery('.forget-form').show();
	        });

	        jQuery('#back-btn').click(function () {
	            jQuery('.login-form').show();
	            jQuery('.forget-form').hide();
	        });

	        $('.register-form').validate({
	            errorElement: 'label', //default input error message container
	            errorClass: 'help-inline', // default input error message class
	            focusInvalid: false, // do not focus the last invalid input
	            ignore: "",
	            rules: {
	                username: {
	                    required: true,
                        rangelength: [6, 18],
                        remote: {
                            url: siteUrl+developerDir+"/login/checkUsernameIsExist",     //后台处理程序
                            type: "post",               //数据发送方式
                            dataType: "json",           //接受数据格式   
                            data: {                     //要传递的数据
                                username: function() {
                                    return $("#register_username").val();
                                }
                            }
                        },
                        
	                },
	                password: {
	                    rangelength: [8, 18],
	                    required: true,
	                },
	                rpassword: {
	                    equalTo: "#register_password"
	                },
	                email: {
	                    required: true,
	                    email: true
	                },
	                tnc: {
	                    required: true
	                }
	            },

	            messages: { // custom messages for radio buttons and checkboxes
                    username: {                        
                        rangelength: '用户名在6-18个字符之间',
                        remote: '用户名已存在',
                    },
	                tnc: {
	                    required: "必须选择"
	                },
	            },

	            invalidHandler: function (event, validator) { //display error alert on form submit   

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
	                if (element.attr("name") == "tnc") { // insert checkbox errors after the container                  
	                    error.addClass('help-small no-left-padding').insertAfter($('#register_tnc_error'));
	                } else {
	                    error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
	                }
	            },

	            submitHandler: function (form) {
	                form.submit();
                    //window.location.href = "index.html";
	            }
	        });

	        jQuery('#register-btn').click(function () {
	            jQuery('.login-form').hide();
	            jQuery('.register-form').show();
	        });

	        jQuery('#register-back-btn').click(function () {
	            jQuery('.login-form').show();
	            jQuery('.register-form').hide();
	        });
        }

    };

}();