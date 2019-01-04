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
  <script type="text/javascript" src="js/userlist.js"></script>


</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="include/header.jsp" %>
  <%@include file="include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="include/pageheader.jsp" %>
	    <div class="contentwrapper padding10">
	    	<div class="errorwrapper error404">
	        	<div class="errorcontent">
	                <h1>404 Page Not Found</h1>
	                <h3>We couldn't find that page. It appears that you are lost.</h3>
	                
	                <p>The page you are looking for is not found. This could be for several reasons</p>
	                <ul>
	                    <li>It never existed.</li>
	                    <li>It got deleted for some reason.</li>
	                    <li>You were looking for something that is not here.</li>
	                    <li>You like this page.</li>
	                </ul>
	                <br />
	                <button class="stdbtn btn_black" onclick="history.back()">Go Back to Previous Page</button> &nbsp; 
	                <button onclick="location.href='home.do'" class="stdbtn btn_orange">Go Back to Home</button>
	            </div>
	        </div>
	    </div>  
		

  </div>
  
</div>

</body>
</html>