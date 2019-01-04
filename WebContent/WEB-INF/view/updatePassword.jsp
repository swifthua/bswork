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
  <script type="text/javascript" src="<%=basePath %>ext/jquery/jquery.js"></script>
  <script type="text/javascript" src="<%=basePath %>js/common.js"></script>
  <script type="text/javascript" src="<%=basePath %>js/updatepassword.js"></script>
  <script type="text/javascript">
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
  	<div style="padding-left: 20px;padding-top: 50px;">
  	  <form action="repassword.do" id="form">
	 	  <div class="layui-form-item">
		    <label class="layui-form-label">原始密码</label>
		    <div class="layui-input-inline">
		      <input type="password" id="password" name="password"  placeholder="请输入密码" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-form-mid layui-word-aux" id="passwordError" style="color: red;"></div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">新密码</label>
		    <div class="layui-input-inline">
		      <input type="password" id="newpwd" name="newpwd"  placeholder="请输入密码" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-form-mid layui-word-aux" id="newpwdError"></div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">确认密码</label>
		    <div class="layui-input-inline">
		      <input type="password" id="confirmpwd" name="confirmpwd"  placeholder="请输入密码" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-form-mid layui-word-aux" id="confirmpwdError"></div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block">
		      <input id="submit" type="submit" value="修改密码" class="layui-btn" lay-submit lay-filter="formDemo"/>
		      <input id="back" type="button" value="返回" class="layui-btn layui-btn-primary" onclick="history.back()"/>
		    </div>
		  </div>
	  </form>
  	</div>
  </div>
  
  <div class="layui-footer">
    © 版权所有Chengdu University of Technology  -by zh
  </div>
</div>
</body>
</html>