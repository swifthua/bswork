<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
	//JavaScript代码区域
	layui.use(['element','laydate','form','layer'], function(){
	  var element = layui.element;
	  var laydate =layui.laydate;
	  var form =layui.form;
	  var layer=layui.layer;
	  //alert(element);
	  
	  //日期选择 
	  laydate.render({
		    elem: '#qjStart1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#qjStart2'
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
		    elem: '#qjStop1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#qjStop2'
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
	
	function check(){
		var currentTime=Date.parse(new Date());
		var qjStart1=trim($("#qjStart1").val());
		var qjStart2=trim($("#qjStart2").val());
		var qjStart=Date.parse(qjStart1+" "+qjStart2);
		if(!qjStart){
			layer.alert("请填写开始时间！");
			return false;
		}
		if(qjStart < currentTime){
			layer.alert("起始时间不能小于当前系统时间！");
			return false;
		}
		var qjStop1=trim($("#qjStop1").val());
		var qjStop2=trim($("#qjStop2").val());
		var qjStop=Date.parse(qjStop1+" "+qjStop2);
		if(!qjStop){
			layer.alert("请填写结束时间！");
			return false;
		}
		if(qjStop< currentTime){
			layer.alert("结束时间不能小于当前系统时间！");
			return false;
		}
		if(qjStop<qjStart){
			layer.alert("结束时间不能小于起始时间！");
			return false;
		}
		
		$("#form").submit();
	}
	</script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">考勤管理/请假登记</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="leaveAdd.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">请假登记 </div>
   		  <table class="layui-table" >
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${userExist.bmdm.bmmc }</td>
   		  		<td>请假人</td>
   		  		<td>${userExist.yhxm}</td>
   		  	</tr>
   		  
   		  	<tr>
   		  		<td>请假开始时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" id="qjStart1" name="qjStart1" required lay-verify="required">
					</div>
					<div class="layui-inline">
					  <input type="text" class="layui-input" id="qjStart2" name="qjStart2" required lay-verify="required">
					</div>
   		  		</td>
   		  		<td>请假结束时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" id="qjStop1" name="qjStop1" required lay-verify="required">
					</div>
					<div class="layui-inline">
					  <input type="text" class="layui-input" id="qjStop2" name="qjStop2" required lay-verify="required">
					</div>
   		  		</td>
   		  	</tr>
   		  	
   		  	<tr>
   		  		<td>请假事由</td>
   		  		<td colspan="3"><textarea name="remark" id="remark" class="layui-textarea" style="border: 0px;" required lay-verify="required"></textarea></td>
   		  	</tr>
   		  </table>
   		  <div class="layui-form-item" style="margin-left:495px;">
	    	  <input type="button" class="layui-btn"  onclick="check()" lay-filter="formDemo" value="提交" >
	    	  <input type="reset" class="layui-btn layui-btn-primary" value="重置">
	      </div>
    	</form>
    </div>
  </div>
  
</div>
</body>
</html>