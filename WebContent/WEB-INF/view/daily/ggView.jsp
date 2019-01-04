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
    <script type="text/javascript">
	//JavaScript代码区域
	layui.use('element', function(){
	  var element = layui.element;
	});
  </script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div class="contentwrapper " >
    	<div class="errorwrapper">
                <h1 style="text-align: center;">${notify.ggbt }</h1>
                <h3>各部门组长、有关工作人员:</h3>
                <p style="text-indent:2em;font-size: 16px;">${notify.ggnr}</p>
                
                <br/>
                <p style="text-indent:2em;font-size: 16px;">${notify.fqr.bmdm.bmmc}:${notify.fqr.yhxm }&nbsp;&nbsp;&nbsp;&nbsp;电话:${notify.fqr.phone }</p>
                <p style="text-align: right;font-size: 16px;">${notify.lastUpdate }</p>
                <div style="text-align: center;">
	                <button class="stdbtn btn_black" onclick="history.back()">返回</button> &nbsp; 
	                <button onclick="location.href='home.do'" class="stdbtn btn_orange">返回首页</button>
                </div>
        </div>
    </div>  
		

  </div>
  
</div>

</body>
</html>