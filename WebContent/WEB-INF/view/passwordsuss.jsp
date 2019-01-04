<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>修改密码界面</title>
  <link rel="stylesheet" href="<%=basePath %>ext/layui/css/layui.css" media="all">
  <script type="text/javascript" src="<%=basePath %>ext/layui/layui.js"></script>
    <script>
    //JavaScript代码区域
    layui.use('element', function(){
      var element = layui.element;
    });
    </script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="include/header.jsp" %>
  <%@include file="include/left.jsp" %>
    <div class="layui-body">
	  	<%@include file="include/pageheader.jsp" %>
	  	<div style="padding-top: 30px;text-align: center;">
		  	<span style="font-size: 30px;color: red;">修改密码成功!</span><br></br>
		  	<span style="font-size: 20px;">请点击<a href="quit.do"><span style="color:blue;">这里</span></a>重新登陆</span>
	  	</div>
  	</div>
  <div class="layui-footer">
    © 版权所有Chengdu University of Technology  -by zh
  </div>
</div>
</body>
</html>