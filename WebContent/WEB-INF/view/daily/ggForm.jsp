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
	layui.use(['element','laydate','layer'], function(){
	  var element = layui.element;
	  var laydate = layui.laydate;
	  var layer=layui.layer;
	 

	});
	  function check(){
		  var ggbt=trim($("#ggbt").val());
		  if(!ggbt){
			  layer.confirm("公告标题不能为空！");
			  return false;
		  }
		  
		  var ggnr=trim($("#ggnr").val());
		  if(!ggnr){
			  layer.confirm("公告内容不能为空！");
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
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">日常管理/公告添加</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="notifyAdd.do" id="form">
   		  <div class="layui-form-item" >
		    <label class="layui-form-label">公告标题<span style="color:red;">*</span></label>
		    <div class="layui-input-block" style="width: 650px;">
		      <input type="text" name="ggbt" id="ggbt" required lay-verify="required" autocomplete="off" class="layui-input" >
		    </div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">发起人<span style="color:red;">*</span></label>
		    <div class="layui-input-block" style="width: 650px;">
			    <input type="text" class="layui-input" id="fqr" name="fqr" value="${userExist.yhxm }" disabled="disabled">
      		</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">公告内容<span style="color:red;">*</span></label>
		    <div class="layui-input-block" style="width: 650px;">
		      <textarea name="ggnr" id="ggnr" class="layui-textarea"></textarea>
		    </div>
		  </div>
		  
    	  <div class="layui-form-item" style="padding-left:320px;">
	    	  <input type="button" class="layui-btn" lay-filter="formDemo" onclick="check();" value="提交" >
	    	  <input type="reset" class="layui-btn layui-btn-primary" value="重置">
	      </div>
    		
    	</form>
    </div>
  </div>
  
</div>
</body>
</html>