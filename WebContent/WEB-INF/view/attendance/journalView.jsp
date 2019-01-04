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
  <script type="text/javascript" src="ext/jquery/jquery.js"></script>
  <script type="text/javascript" src="js/common.js"></script>
  <script src="ext/layui/layui.js"></script>
	<script>
	 $(function () {
	 	var jhnr='${journal.rznr}';
	 	$("#rznr").val(jhnr);
	 });
	//JavaScript代码区域
	layui.use(['element','laydate','form','layer','layedit'], function(){
	  var element = layui.element;
	  var laydate =layui.laydate;
	  var form =layui.form;
	  var layer=layui.layer;
	  
	  var layedit = layui.layedit;
	  content = layedit.build("rznr");
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
	</script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">考勤管理/日志查看</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="arrangeAdd.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">日志查看 </div>
   		  <table class="layui-table" >
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${journal.djr.bmdm.bmmc }</td>
   		  		<td>姓名</td>
   		  		<td>${journal.djr.yhxm}</td>
   		  	</tr>
   		  	<tr>
   		  		<td>日志日期</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${fn:substring(journal.rzsj,0,16)}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  		<td>时长</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${journal.duration}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  	</tr>
   		  	<tr>
   		  		<td>登记日期</td>
   		  		<td colspan="3">
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${fn:substring(journal.djsj,0,16)}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  	</tr>
   		  	<tr>
   		  		<td>日志内容</td>
   		  		<td colspan="3"><textarea id="rznr" name="rznr" class="layui-textarea" style="border: 0px;" disabled="disabled" ></textarea></td>
   		  	</tr>
   		  </table>
   		  <div class="layui-form-item" style="margin-left:495px;">
	    	  <input id="back" type="button" value="返回" class="layui-btn layui-btn-primary" onclick="history.back()"/>
	      </div>
    	</form>
    </div>
  </div>
  
</div>
</body>
</html>