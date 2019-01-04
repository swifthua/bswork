$(function(){
	//给表单添加submit事件，完成表单验证 
	$("#form").submit(function(){
		var bool = true;
		$(".layui-input").each(function() {
			var inputName = $(this).attr("name");
			if(!invokeValidateFunction(inputName)) {
				bool = false;
			} 
		});
		return bool;
	});
	
	// 输入框推动焦点时进行校验
	$(".layui-input").blur(function() {
		var inputName = $(this).attr("name");
		invokeValidateFunction(inputName);
	});
});

//输入input名称，调用对应的validate方法。
//例如input名称为：loginname，那么调用validateLoginname()方法
function invokeValidateFunction(inputName){
	inputName = inputName.substring(0, 1).toUpperCase() + inputName.substring(1);
	var functionName = "validate" + inputName;
	return eval(functionName + "()");	
}

function validatePassword(){
	var bool = true;
	$("#passwordError").css("display", "none");
	var value = trim($("#password").val());
	if(!value) {// 非空校验
		$("#passwordError").css("display", "");
		$("#passwordError").text("原始密码不能为空！");
		bool = false;
	} else if(value.length < 3 || value.length > 20) {//长度校验
		$("#passwordError").css("display", "");
		$("#passwordError").text("原始密码长度必须在3 ~ 20之间！");
		bool = false;
	} else {// 验证原错误是否正确
		$.ajax({
			cache: false,
			async: true,
			type: "POST",
			data: {method: "ajaxValidatePwd", password: value},
			url: "ajaxValidatePwd.do",
			success: function(flag) {
				if(!flag) {
					$("#passwordError").css("display", "");
					$("#passwordError").text("原密码错误！");
					bool = false;				
				}
			}
		});
	}
	return bool;
}

function validateNewpwd(){
	var bool = true;
	var value = trim($("#newpwd").val());
	$("#newpwdError").css("display", "none");
	if(!value) {// 非空校验
		$("#newpwdError").css("display","");
		$("#newpwdError").text("新密码不能为空！");
		bool = false;
	}else if(value.length < 3 || value.length > 20) {//长度校验
		$("#newpwdError").css("display","");
		$("#newpwdError").text("新密码长度必须在3 ~ 20之间！");
		bool = false;
	}else if(value==$("#password").val()){  //与原密码不能相同
		$("#newpwdError").css("display","");
		$("#newpwdError").text("新密码不能与原密码相同");
	}
	return bool;
}

function validateConfirmpwd(){
	var bool = true;
	$("#confirmpwdError").css("display", "none");
	var value = trim($("#confirmpwd").val());
	if(!value) {// 非空校验
		$("#confirmpwdError").css("display", "");
		$("#confirmpwdError").text("确认密码不能为空！");
		bool = false;
	} else if(value != $("#newpwd").val()) {//两次输入是否一致
		$("#confirmpwdError").css("display", "");
		$("#confirmpwdError").text("两次密码输入不一致！");
		bool = false;
	}
	return bool;	
}