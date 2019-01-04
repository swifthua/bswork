<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>登录页面</title>
<link rel="stylesheet" type="text/css" href="css/login.css" />
<link rel="stylesheet" href="ext/layui/css/layui.css" />
<script src="ext/layui/layui.js"></script>
<script type="text/javascript" src="ext/jquery/jquery.js"></script>

</head>

<body> 

<div class="login">
	<script type="text/javascript">
		onload=function(){
			var s="${cookie.savename.value }";
			username=s.substring(0,s.indexOf("-"));
			password=s.substring(s.indexOf("-")+1,s.length);
			
			document.getElementsByName("username")[0].value=username;
			document.getElementsByName("password")[0].value=password;
			
			
		};
	</script>
    <div class="message">办公自动化管理系统登录</div>
    <div id="darkbannerwrap"></div>
    
    <form action="login.do" method="post" class="layui-form layui-form-pane1">
		<input name="action" value="login" type="hidden" />
		<input name="username" placeholder="用户名" required="" type="text" />
		<br></br>
		<input name="password" placeholder="密码" required="" type="password" />
		<br></br>
		<c:if test="${msg!=null }">
			<span style="margin-left: 130px;color:red;">${msg }</span><br></br>
		</c:if>
		<input value="登录" style="width:100%;" type="submit"/>
		<br></br>
		<input type="checkbox" name="saveName" value="ok"/>记住账户信息
		<!--  帮助 <a onClick="alert('请联系管理员')">忘记密码</a>  -->
	</form>

	
</div>


</body>
</html>
