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
  <script type="text/javascript" src="js/userlist.js"></script>


</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/员工管理</span></div>
    <div style="padding: 20px;">
    	<form action="findUserMore.do" method="post" id="form" class="layui-form layui-form-pane1">
    	<div >
		  所在部门：
		  <div class="layui-inline">
		    <select name="bmdm" id="bmdm" class="layui-select" lay-filter="bmdm" >
		        <option value="">--请选择--</option>
		     </select>
		  </div>&nbsp;&nbsp;&nbsp;
		  用户姓名：
		  <div class="layui-inline">
			    <select name="yhdm" id="yhdm" class="layui-select" >
			        <option value="">--请选择--</option>
			    </select>
		  </div>&nbsp;&nbsp;&nbsp;&nbsp;
		  
		  <input type="submit" class="layui-btn" value="查询">
		  <input type="button" class="layui-btn" value="新增" onclick="newUser()">
		  <input type="button" class="layui-btn" value="批量删除" onclick="deleteBatch()">
		</div>
		<br>
		<table id="table" class="layui-table">
		  <thead>
		    <tr>
		      <th><input type="checkbox" id="checkAll"  lay-skin="primary" lay-filter="allChoose"/></th>
		      <th>用户代码</th>
		      <th>用户姓名</th>
		      <th>用户性别</th>
		      <th>所在部门</th>
		      <th>职位</th>
		      <th>电话</th>
		      <th>email</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		    <c:forEach items="${pb.list }" var="user">
		    	<tr>
		    		<td><input type="checkbox" class="check" name="checkbox" value="${user.yhdm }" lay-skin="primary" lay-filter="oneChoose"/></td>
		    		<td>${user.yhdm }</td>
		    		<td>${user.yhxm }</td>
		    		<td>${user.yhxb }</td>
		    		<td>${user.bmdm.bmmc }</td>
		    		<td>${user.zwdm.zwmc }</td>
		    		<td>${user.phone }</td>
		    		<td>${user.email }</td>
		    		<td>
		    			<a class="view" href="viewByYhdm.do?yhdm=${user.yhdm }">查看</a>    
		    			<a class="edit" href="editByYhdm.do?yhdm=${user.yhdm }">编辑</a>
		    			<a class="del"  onclick="deleteById('${user.yhdm }')" layEvent="del">删除</a>
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