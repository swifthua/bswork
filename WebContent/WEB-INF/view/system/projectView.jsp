<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>办公自动化管理系统</title>
  <link rel="stylesheet" href="ext/layui/css/layui.css">
  <script type="text/javascript" src="ext/jquery/jquery.js"></script>
  <script type="text/javascript" src="js/common.js"></script>
  <script src="ext/layui/layui.js"></script>
  <script type="text/javascript" src="js/userForm.js"></script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/项目信息查看</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" id="form">
   		  <div class="layui-form-item" >
		    <div class="layui-input-block" style="width: 650px;">项目名称:${project.xmmc }</div>
		  </div>
		  <div class="layui-form-item">
		   <div class="layui-input-block" style="width: 650px;">版本号:${project.bbh }</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <div class="layui-input-block" style="width: 650px;">立项日期:${project.lxrq }</div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block" style="width: 650px;">立项人:${ project.lxr.yhxm}</div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block" style="width: 650px;">项目描述:${project.xmxx }</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <div class="layui-input-block" style="width: 650px;">相关附件:<a href="downloadByXmdm.do?xmdm=${project.xmdm }"><span style="color:blue;">${project.fjmc }.${project.fjgs }</span></a></div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block" style="width: 650px;">附件大小:${project.fjdx }KB</div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block" style="width: 650px;">最近更新:${project.lastUpdate }</div>
		  </div>

		  <div class="layui-form-item">
		    <div class="layui-input-block" style="width: 650px;">说明:${project.remark } </div>
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