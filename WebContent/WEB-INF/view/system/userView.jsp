<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zh.po.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user=(User)request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>办公自动化管理系统</title>
  <link rel="stylesheet" href="ext/layui/css/layui.css">
  <script type="text/javascript" src="<%=basePath %>ext/jquery/jquery.js"></script>
  <script type="text/javascript" src="<%=basePath %>js/common.js"></script>
  <script src="<%=basePath %>ext/layui/layui.js"></script>
  <script type="text/javascript" src="<%=basePath %>js/userForm.js"></script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/员工信息查看</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" id="form">
   		  <div class="layui-form-item" >
		    <label class="layui-form-label">用户姓名<span style="color:red;">*</span></label>
		    <div class="layui-input-block" style="width: 650px;">
		      <input type="text" name="yhxm" id="yhxm" autocomplete="off" class="layui-input" value="${user.yhxm }" disabled="disabled">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">用户性别</label>
		    <div class="layui-input-block" style="width: 650px;">
		    <%if("男".equals(user.getYhxb())){ %>
			    <input type="radio" name="yhxb" value="男" title="男" checked="checked" disabled="disabled">
			    <input type="radio" name="yhxb" value="女" title="女" disabled="disabled">
			<%}else{ %>
				<input type="radio" name="yhxb" value="男" title="男" disabled="disabled">
	      		<input type="radio" name="yhxb" value="女" title="女" checked="checked" disabled="disabled">
	        <%} %>
      		</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">所在部门</label>
		    <div class="layui-input-inline">
		      <select name="bmdm" id="bmdm" class="layui-select" lay-filter="bmdm" disabled="disabled">
		        <option value="${user.bmdm.bmdm }">${user.bmdm.bmmc }</option>
		      </select>
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">职位</label>
		    <div class="layui-input-inline">
		      <select name="zwdm" id="zwdm" class="layui-select" disabled="disabled">
		        <option value="${user.zwdm.zwdm }">${user.zwdm.zwmc }</option>
		      </select>
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">出生日期</label>
		    <div class="layui-input-block" style="width: 650px;">
			  <input type="text" class="layui-input" id="csrq" name="csrq" value="${user.csrq }" disabled="disabled">
			</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">电话</label>
		    <div class="layui-input-block" style="width: 650px;">
		      <input type="text" name="phone" id="phone" autocomplete="off" class="layui-input" value="${user.phone }" disabled="disabled">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">email</label>
		    <div class="layui-input-block" style="width: 650px;">
		      <input type="text" name="email" id="email" autocomplete="off" class="layui-input" value="${user.email }" disabled="disabled">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">所在地</label>
		    <div class="layui-input-block" style="width: 650px;">
		      <input type="text" name="address" id="address" autocomplete="off" class="layui-input" value="${user.address }" disabled="disabled" >
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">说明</label>
		    <div class="layui-input-block" style="width: 650px;">
		      <textarea name="remark"  class="layui-textarea" disabled="disabled">${user.remark }</textarea>
		    </div>
		  </div>
		  
    	  <div class="layui-form-item" style="padding-left:320px;">
	    	  <input id="back" type="button" value="返回" class="layui-btn layui-btn-primary" onclick="history.back()"/>
	      </div>
    		
    	</form>
    </div>
  </div>
  
</div>
</body>
</html>