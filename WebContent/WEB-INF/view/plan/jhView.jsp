<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String bxrq=formatter.format(new Date());
%>
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
	 	var jhnr='${arrange.jhnr}';
	 	$("#jhnr").val(jhnr);
	 });
	//JavaScript代码区域
	layui.use(['element','laydate','form','layer','layedit'], function(){
	  var element = layui.element;
	  var laydate =layui.laydate;
	  var form =layui.form;
	  var layer=layui.layer;
	  
	  var layedit = layui.layedit;
	  content = layedit.build("jhnr");
	  //alert(element);
	  
	  //日期选择 
	  laydate.render({
		    elem: '#jhStart1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#jhStart2'
		    ,type: 'time'
		    ,min: '09:30:00'
		    ,max: '17:30:00'
		    ,done: function(value, date, endDate){
		      console.log(value, date, endDate);
		    }
		    ,change: function(value, date, endDate){
		      //this.elem.val(value)
		    }
	  });
	  
	  laydate.render({
		    elem: '#jhStop1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#jhStop2'
		    ,type: 'time'
		    ,min: '09:30:00'
		    ,max: '17:30:00'
		    ,done: function(value, date, endDate){
		      console.log(value, date, endDate);
		    }
		    ,change: function(value, date, endDate){
		      //this.elem.val(value)
		    }
	  });
	  
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
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">计划制定/制定计划</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="arrangeAdd.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">制定计划 </div>
   		  <table class="layui-table" >
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${arrange.apr.bmdm.bmmc }</td>
   		  		<td>安排人</td>
   		  		<td>${arrange.apr.yhxm}</td>
   		  	</tr>
   		  	<tr>
   		  		<td>项目</td>
   		  		<td>
   		  			<select name="xmdm" id="xmdm" style="border: 0px;" disabled="disabled">
   		  				<option value="${arrange.xmdm.xmdm }">${arrange.xmdm.xmmc }</option>
   		  			</select>
   		  		</td>
   		  		<td>登记日期</td>
   		  		<td>${fn:substring(arrange.djsj,0,16)}</td>
   		  	</tr>
   		  	<tr>
   		  		<td>计划开始时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${fn:substring(arrange.jhStart,0,16)}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  		<td>计划结束时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${fn:substring(arrange.jhStop,0,16)}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  	</tr>
   		  	
   		  	
   		  	<tr>
   		  		<td>负责人</td>
   		  		<td>部门:${arrange.fzr.bmdm.bmmc }</td>
   		  		<td colspan="2">员工:${arrange.fzr.yhxm }</td>
   		  	</tr>
   		  	<tr>
   		  		<td>计划内容</td>
   		  		<td colspan="3"><textarea id="jhnr" name="jhnr" class="layui-textarea" style="border: 0px;" ></textarea></td>
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