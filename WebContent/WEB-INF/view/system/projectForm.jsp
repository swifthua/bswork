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
	layui.use('element', function(){
	  var element = layui.element;
	  //alert(element);
	});
	</script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/项目添加</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="projectAdd.do" id="form" method="POST" enctype="multipart/form-data">
   		  <div class="layui-form-item" >
		    <label class="layui-form-label">项目名称<span style="color:red;">*</span></label>
		    <div class="layui-input-block" style="width: 650px;">
		      <input type="text" name="xmmc" id="xmmc" required lay-verify="required" autocomplete="off" class="layui-input" >
		    </div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">立项人</label>
		    <div class="layui-input-block" style="width: 650px;">
			    <input type="text" class="layui-input" id="lxr" name="lxr" value="${userExist.yhxm }" disabled="disabled">
      		</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">项目描述</label>
		    <div class="layui-input-block" style="width: 650px;">
			    <input type="text" class="layui-input" id="xmxx" name="xmxx" >
      		</div>
		  </div>
		 
		 <div class="layui-form-item">
		    <label class="layui-form-label">选择附件</label>
		    <div class="layui-input-block" style="width: 650px;">
			  <input type="file" name="fj" class="input">
			</div>
		  </div>
		 
		  <div class="layui-form-item">
		    <label class="layui-form-label">说明</label>
		    <div class="layui-input-block" style="width: 650px;">
		      <textarea name="remark"  class="layui-textarea"></textarea>
		    </div>
		  </div>
		  
    	  <div class="layui-form-item" style="padding-left:320px;">
	    	  <input type="submit" class="layui-btn" lay-filter="formDemo"  value="提交" >
	    	  <input type="reset" class="layui-btn layui-btn-primary" value="重置">
	      </div>
    		
    	</form>
    </div>
  </div>
  
</div>
</body>
</html>