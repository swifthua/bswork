<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.zh.po.User" %>
<%
	User user=(User)session.getAttribute("userExist");
	System.out.println(user);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>办公自动化管理系统</title>
  <link rel="stylesheet" href="ext/layui/css/layui.css">
  <link rel="stylesheet" href="css/common.css">
  <script type="text/javascript" src="ext/jquery/jquery.js"></script>
  <script type="text/javascript" src="js/common.js"></script>
  <script src="ext/layui/layui.js"></script>
	<script>
	//JavaScript代码区域
	layui.use('element', function(){
	  var element = layui.element;
	  //alert(element);
	});
	</script>


</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/通讯录</span></div>
    <div style="padding: 20px;">
    	<form action="findByYhxm.do" method="post" id="form" class="layui-form layui-form-pane1">
    	<div style="text-align: center;">
		  用户姓名：
		  <div class="layui-inline">
		    <input class="layui-input" name="yhxm" id="yhxm" autocomplete="off" style="width: 100%;">
		  </div>&nbsp;&nbsp;&nbsp;
		  <input type="submit" class="layui-btn" value="查询">
		</div>
		<br>
		</form>
		
		<div style="text-align: center;">
			<table id="table" class="layui-table">
			  <thead>
			    <tr>
			      <th style="text-align: center;">部门</th>
			      <th style="text-align: center;">用户姓名</th>
			      <th style="text-align: center;">电话</th>
			      <th style="text-align: center;">email</th>
			    </tr> 
			  </thead>
			  <tbody>
			    <c:forEach items="${pb.list }" var="user">
			    	<tr>
			    		<td>${user.bmdm.bmmc }</td>
			    		<td>${user.yhxm }</td>
			    		<td>${user.phone }</td>
			    		<td>${user.email }</td>
			    	</tr>
			    </c:forEach>
			  </tbody>
			</table>
		</div>
		<div style="float:left; width: 100%; text-align: center;">
			<%@include file="../include/pagination.jsp" %>
		</div>
    </div>
  </div>
  
</div>

</body>
</html>