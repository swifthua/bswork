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
  <link rel="stylesheet" href="css/common.css">
  <script type="text/javascript" src="ext/jquery/jquery.js"></script>
  <script type="text/javascript" src="js/common.js"></script>
  <script src="ext/layui/layui.js"></script>
  <script type="text/javascript" src="js/projectlist.js"></script>


</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/项目管理</span></div>
    <div style="padding: 20px;">
    	<form action="findProjectByXmmc.do" method="post" id="form" class="layui-form layui-form-pane1">
    	<div style="text-align: center;">
		  项目名称：
		  <div class="layui-inline">
		    <input class="layui-input" name="xmmc" id="xmmc" autocomplete="off" style="width: 100%;">
		  </div>&nbsp;&nbsp;&nbsp;
		  <input type="submit" class="layui-btn" value="查询">
		  <input type="button" class="layui-btn" value="新增" onclick="newProject()">
		</div>
		<br>
		<table id="table" class="layui-table">
		  <thead>
		    <tr>
		      <th>项目名称</th>
		      <th>立项日期</th>
		      <th>立项人</th>
		      <th>项目描述</th>
		      <th>附件名称</th>
		      <th>附件大小</th>
		      <th>最近更新</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		    <c:forEach items="${pb.list }" var="project">
		    	<tr>
		    		<td>${project.xmmc }</td>
		    		<td>${project.lxrq}</td>
		    		<td>${project.lxr.yhxm }</td>
		    		<td>${project.xmxx }</td>
		    		<td><a href="downloadByXmdm.do?xmdm=${project.xmdm }"><span style="color:blue;">${project.fjmc }.${project.fjgs }</span></a></td>
		    		<td>${project.fjdx }</td>
		    		<td>${project.lastUpdate }</td>
		    		<td>
		    			<a class="view" href="viewByXmdm.do?xmdm=${project.xmdm }">查看</a>    
		    			<a class="del"  onclick="deleteById('${project.xmdm }')" layEvent="del">删除</a>
		    		</td>
		    	</tr>
		    </c:forEach>
		  </tbody>
		</table>
		</form>
		<div style="float:left; width: 100%; text-align: center;">
			<%@include file="../include/pagination.jsp" %>
		</div>
    </div>
  </div>
  
</div>

</body>
</html>