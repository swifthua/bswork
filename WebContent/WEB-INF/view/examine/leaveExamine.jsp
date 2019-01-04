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
	 	var remark='${leave.remark}';
	 	$("#remark").val(remark);
	 });
	//JavaScript代码区域
	layui.use(['element','laydate','form','layer','layedit'], function(){
	  var element = layui.element;
	  var laydate =layui.laydate;
	  var form =layui.form;
	  var layer=layui.layer;
	  
	  var layedit = layui.layedit;
	  content = layedit.build("remark");
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
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">审核管理/请休假审核</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="examineByQjid.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">请休假审核 </div>
    	  <input type="hidden" name="qjid" id="qjid" value="${leave.qjid }">
   		  <table class="layui-table" >
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${leave.bmdm.bmmc }</td>
   		  		<td>姓名</td>
   		  		<td>${leave.qjr.yhxm}</td>
   		  	</tr>
   		  	<tr>
   		  		<td>开始时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${fn:substring(leave.qjStart,0,16)}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  		<td>结束时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${fn:substring(leave.qjStop,0,16)}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  	</tr>
   		  	<tr>
   		  		<td>登记日期</td>
   		  		<td colspan="3">
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${fn:substring(leave.djsj,0,16)}" style="border: 0px;" disabled="disabled">
					</div>
   		  		</td>
   		  	</tr>
   		  	<tr>
   		  		<td>请假事由</td>
   		  		<td colspan="3"><textarea id="remark" name="remark" class="layui-textarea" style="border: 0px;" disabled="disabled" ></textarea></td>
   		  	</tr>
   		  	<c:choose>
	   		  	<c:when test="${leave.wczt.ztms eq '未审核' }">
	   		  		<c:choose>
	   		  		<c:when test="${fn:substring(leave.qjr.zwdm.zwdm,fn:length(leave.qjr.zwdm.zwdm)-2,fn:length(leave.qjr.zwdm.zwdm)) eq '01' }">
	   		  			<tr>
			   		  		<td>院长审核意见</td>
			   		  		<td colspan="3">
								<input type="radio" name="shyj2" value="同意" title="同意">
		      					<input type="radio" name="shyj2" value="不同意" title="不同意">
							</td>
		   		  		</tr>
	   		  		</c:when>
		   		  	<c:otherwise>
			   		  	<tr>
			   		  		<td>部门组长审核意见</td>
			   		  		<td colspan="3">
			   		  			<input type="radio" name="shyj1" value="同意" title="同意">
		      					<input type="radio" name="shyj1" value="不同意" title="不同意">
		      				</td>
			   		  	</tr>
		   		  	</c:otherwise>
		   		  	</c:choose>
	   		  	</c:when>
	   		  	<c:otherwise>
	   		  		<tr>
		   		  		<td>部门组长(${examine.shr1.yhxm })审核意见</td>
		   		  		<td><input name="shyj1" id="shyj1" class="layui-input" style="border: 0px;" value="${examine.shyj1 }" disabled="disabled"></td>
		   		  		<td>审核时间</td>
		   		  		<td><input type="text" class="layui-input" value="${fn:substring(examine.shsj1,0,16)}" style="border: 0px;" disabled="disabled"></td>
		   		  	</tr>
		   		  	<tr>
		   		  		<td>院长审核意见</td>
		   		  		<td colspan="3">
							<input type="radio" name="shyj2" value="同意" title="同意">
	      					<input type="radio" name="shyj2" value="不同意" title="不同意">
						</td>
		   		  	</tr>
	   		  	</c:otherwise>
   		  	</c:choose>
   		  	
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