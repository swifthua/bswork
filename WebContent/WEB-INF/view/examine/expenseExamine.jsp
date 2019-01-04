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
	</script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">审核管理/费用报销审核</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="examineByBxid.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">费用报销审核 </div>
    	  <input type="hidden" name="bxid" id="bxid" value="${expense.bxid }">
   		  <table class="layui-table" style="width: 80%;margin-left: 120px;">
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${expense.bxr.bmdm.bmmc }</td>
   		  		<td>报销人</td>
   		  		<td>${expense.bxr.yhxm}</td>
   		  	</tr>
   		  	
   		  	<tr>
   		  		<td>项目</td>
   		  		<td>
   		  			<select name="xmdm" id="xmdm" disabled="disabled" style="border: 0px;">
   		  				<option value="${expense.xmdm.xmdm }">${expense.xmdm.xmmc }</option>
   		  			</select>
   		  		</td>
   		  		<td>报销日期</td>
   		  		<td>${expense.bxrq }</td>
   		  	</tr>
   		  	<tr>
   		  		<td>报销用途</td>
   		  		<td><input type="text" name="bxyt" class="layui-input" style="border: 0px;" value="${expense.bxyt }" disabled="disabled"></td>
   		  		<td>报销费用</td>
   		  		<td><input type="text" name="bxfy" class="layui-input" style="border: 0px;" value="${expense.bxfy }" disabled="disabled"></td>
   		  	</tr>
   		  	
   		  	<tr>
   		  		<td>院长审核意见</td>
   		  		<td colspan="3">
					<input type="radio" name="shyj2" value="同意" title="同意">
     				<input type="radio" name="shyj2" value="不同意" title="不同意">
				</td>
   		  	</tr>
   		  </table>
   		  <div class="layui-form-item" style="margin-left:495px;">
	    	  <input id="submit" type="submit" value="提交" class="layui-btn"/>
	      </div>
    	</form>
    </div>
  </div>
  
</div>

</body>
</html>