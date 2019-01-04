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
	$(function(){
		// 输入框推动焦点时进行校验
		$(".layui-input").blur(function() {
			var zsfy=trim($("#zsfy").val());
			var snjtfy=trim($("#snjtfy").val());
			var xcfy=trim($("#xcfy").val());
			$("#zfy").html(parseInt(zsfy)+parseInt(snjtfy)+parseInt(xcfy));
		});
	});
	
	//JavaScript代码区域
	layui.use(['element','laydate','form','layer'], function(){
	  var element = layui.element;
	  var laydate =layui.laydate;
	  var form =layui.form;
	  var layer=layui.layer;
	  //alert(element);
	  
	  //日期选择 
	  laydate.render({
		    elem: '#ccStart1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#ccStart2'
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
		    elem: '#ccStop1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#ccStop2'
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
		var ccStart1=trim($("#ccStart1").val());
		var ccStart2=trim($("#ccStart2").val());
		var ccStart=Date.parse(ccStart1+" "+ccStart2);
		if(!ccStart){
			layer.alert("起始时间不能为空！");
			return false;
		}
		if(ccStart < currentTime){
			layer.alert("起始时间不能小于当前系统时间！");
			return false;
		}
		var ccStop1=trim($("#ccStop1").val());
		var ccStop2=trim($("#ccStop2").val());
		var ccStop=Date.parse(ccStop1+" "+ccStop2);
		if(!ccStop){
			layer.alert("结束时间不能为空！");
			return false;
		}
		if(ccStop< currentTime){
			layer.alert("结束时间不能小于当前系统时间！");
			return false;
		}
		if(ccStop<ccStart){
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
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">报销管理/差旅报销</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="travelAdd.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">差旅报销 </div>
   		  <table class="layui-table" >
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${userExist.bmdm.bmmc }</td>
   		  		<td>报销人</td>
   		  		<td>${userExist.yhxm}</td>
   		  	</tr>
   		  	<tr>
   		  		<td>项目</td>
   		  		<td>
   		  			<select name="xmdm" id="xmdm" required lay-verify="required" style="border: 0px;">
   		  				<option value="">--请选择--</option>
   		  				<c:forEach items="${list_project }" var="project">
   		  					<option value="${project.xmdm }">${project.xmmc }</option>
   		  				</c:forEach>
   		  			</select>
   		  		</td>
   		  		<td>报销日期</td>
   		  		<td><%=bxrq%></td>
   		  	</tr>
   		  	<tr>
   		  		<td>出差开始时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" id="ccStart1" name="ccStart1" required lay-verify="required">
					</div>
					<div class="layui-inline">
					  <input type="text" class="layui-input" id="ccStart2" name="ccStart2" required lay-verify="required">
					</div>
   		  		</td>
   		  		<td>出差结束时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" id="ccStop1" name="ccStop1" required lay-verify="required">
					</div>
					<div class="layui-inline">
					  <input type="text" class="layui-input" id="ccStop2" name="ccStop2" required lay-verify="required">
					</div>
   		  		</td>
   		  	</tr>
   		  	<tr>
   		  		<td>行程工具</td>
   		  		<td>
   		  			<select name="xcgj" id="xcgj" required lay-verify="required" style="border: 0px;">
   		  				<option value="">--请选择--</option>
   		  				<c:forEach items="${list_traffic }" var="traffic">
   		  					<option value="${traffic.gjid}">${traffic.gjms }</option>
   		  				</c:forEach>
   		  			</select>
   		  		</td>
   		  		<td>行程费用</td>
   		  		<td><input type="text" class="layui-input" id="xcfy" style="border: 0px;" name="xcfy"></td>
   		  	</tr>
   		  	<tr>
   		  		<td>出差事由</td>
   		  		<td><input type="text" class="layui-input" id="ccly" style="border: 0px;" name="ccly"></td>
   		  		<td>市内交通费用</td>
   		  		<td><input type="text" class="layui-input" id="snjtfy" style="border: 0px;" name="snjtfy"></td>
   		  	</tr>
   		  	<tr>
   		  		<td>住宿费用</td>
   		  		<td><input type="text" class="layui-input" id="zsfy" style="border: 0px;" name="zsfy"></td>
   		  		<td>总金额</td>
   		  		<td><div id="zfy"></div></td>
   		  	</tr>
   		  	<tr>
   		  		<td>备注</td>
   		  		<td colspan="3"><textarea name="remark" class="layui-textarea" style="border: 0px;"></textarea></td>
   		  	</tr>
   		  </table>
   		  <div class="layui-form-item" style="margin-left:495px;">
	    	  <input type="button" class="layui-btn" lay-filter="formDemo" onclick="check()" value="提交" >
	    	  <input type="reset" class="layui-btn layui-btn-primary" value="重置">
	      </div>
    	</form>
    </div>
  </div>
  
</div>
</body>
</html>