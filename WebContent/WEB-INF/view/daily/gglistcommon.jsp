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
    <div class="contentwrapper padding10">
    	<div class="errorwrapper error403">
			<div class="title"><h3>公告通知</h3></div>
			<c:forEach items="${pb.list }" var="notify">
				<a href="viewByGgid.do?ggid=${notify.ggid }">${notify.ggbt }</a>&nbsp;&nbsp;<span style="color:gray;">[${fn:substring(notify.lastUpdate,0,16) }]</span>
				<hr style="height:0px;border:none;border-top:1px dashed gray;" />
			</c:forEach>
        </div>
        <div style="float:left; width: 100%; text-align: center;">
			<%@include file="../include/pagination.jsp" %>
		</div>
    </div>  
		

  </div>
  
</div>

</body>
</html>