// JavaScript Document
//支持Enter键登录
		document.onkeydown = function(e){
			if($(".bac").length==0)
			{
				if(!e) e = window.event;
				if((e.keyCode || e.which) == 13){
					var obtnLogin=document.getElementById("submit_btn")
					obtnLogin.focus();
				}
			}
		}
    	$(function(){
			function isPhone(aPhone) {
				var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
				var isMob=/^1\d{10}$/;
				if(isMob.test(aPhone)||isPhone.test(aPhone)){
					return true;
				}
				else{
					return false;
				}
			}
			//提交表单
			$('#submit_btn').click(function(){
				show_loading();
				var myReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/; //邮件正则
				if($('#email').val() == ''){
					show_err_msg('手机号码不能为空！');
					$('#email').focus();
				}else if(!isPhone($('#email').val())){
					show_err_msg('手机号码格式错误！');
					$('#email').focus();
				}else if($('#password').val() == ''){
					show_err_msg('密码还没填呢！');
					$('#password').focus();
				}else{
					console.log(calcMD5($('#password').val()));
					$.post("/seller/validateSeller.action",{"tel":$('#email').val(),"password":calcMD5($('#password').val())},function(data){
						console.log(data);
						if(data=="not_find"){
							show_err_msg('账号或密码错误！');
							$('#email').focus();
						}else if(data=="success"){
							window.location.href = "http://www.baidu.com";
						}
					})
					//ajax提交表单，#login_form为表单的ID。 如：$('#login_form').ajaxSubmit(function(data) { ... });
					/*show_msg('登录成功咯！  正在为您跳转...','/');	*/
				}
			});
		});