var userProfileValidation = function () {

    return {
        //main function to initiate the module
        init: function () {
            var form1 = $('#user_form1');

            form1.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    surname:{
                        required: true,
                    },
                    email: {
                        required: true,
                        email: true
                    },
                },
                
                
                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label
                        .addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                    .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    form.submit();
                }
            });
            
            
            var form3 = $('#user_form3');
            
            form3.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-inline', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",
                rules: {
                    current_password: {
                        required: true,
                        remote: {
                            url: passwordValidatePath,     //后台处理路径
                            type: "post",               //数据发送方式
                            dataType: "json",           //接受数据格式   
                            
                        },
                    },
                    new_password: {
                        rangelength: [8 ,18],
                        required: true,
                    },
                    confirm_new_password: {
                        equalTo: '#new_password',
                    },
                },
                messages: {
                    current_password: {
                        remote: '密码不正确',
                    }, 
                       
                },
                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.help-inline').removeClass('ok'); // display OK icon
                    $(element)
                        .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change dony by hightlight
                    $(element)
                        .closest('.control-group').removeClass('error'); // set error class to the control group
                },

                success: function (label) {
                    label
                        .addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                    .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                },

                submitHandler: function (form) {
                    form.submit();
                }
            });                                                
        }
    };

}();