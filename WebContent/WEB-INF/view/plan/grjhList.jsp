<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	layui.use(['element','form'], function(){
	  var element = layui.element;
	  var form =layui.form;
	  //alert(element);
	  
	  //事件监听
	  form.on('select', function(data){
	    console.log('select: ', this, data);
	  });
	  
	  form.on('select(interest)', function(data){
	    console.log('select.interest: ', this, data);
	  });
	  
	  form.on('checkbox', function(data){
	    console.log(this.checked, data.elem.checked);
	  });
	  
	  form.on('switch', function(data){
	    console.log(data);
	  });
	  
	  form.on('radio', function(data){
	    console.log(data);
	  });
	  
	  //监听提交
	  form.on('submit(*)', function(data){
	    console.log(data);
	    return false;
	  });
	});
	
	
	function deleteByJhid(jhid){
		 layer.confirm('真的删除行么', function(){
	        window.location.href="delByJhid.do?jhid="+jhid;
	      }); 
	}

  </script>


</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">计划制定/个人计划</span></div>
    <div style="padding: 20px;">
    	<form action="findBxMore.do" method="post" id="form" class="layui-form layui-form-pane1">
		<br>
			<table id="table" class="layui-table">
			  <thead>
			    <tr>
			      <th>计划号</th>
			      <th>负责人</th>
			      <th>项目</th>
			      <th>计划内容</th>
			      <th>登记时间</th>
			      <th>安排人</th>
			      <th>计划期限</th>
			      <th>操作</th>
			    </tr> 
			  </thead>
			  <tbody>
			    <c:forEach items="${pb.list }" var="arrange">
			    	<tr>
			    		<td>${arrange.jhid }</td>
			    		<td>${arrange.fzr.yhxm}</td>
			    		<td>${arrange.xmdm.xmmc }</td>
			    		<td>${arrange.jhnr }</td>
			    		<td>${fn:substring(arrange.djsj,0,16)}</td>
			    		<td>${arrange.apr.yhxm }</td>
			    		<td>${fn:substring(arrange.jhStart,0,16)} - ${fn:substring(arrange.jhStop,0,16)}</td>
			    		<td>
			    			<a class="view" href="viewByJhid.do?jhid=${arrange.jhid }">查看</a>  
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