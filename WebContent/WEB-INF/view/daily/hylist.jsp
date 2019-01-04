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
  <script type="text/javascript" src="js/meetinglist.js"></script>


</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/会议管理</span></div>
    <div style="padding: 20px;">
    	<form action="findMeetingCondition.do" method="post" id="form" class="layui-form layui-form-pane1">
    	<div >
		 会议标题：
		  <div class="layui-inline">
		    <input class="layui-input" name="hybt" id="hybt" autocomplete="off" style="width: 100%;">
		  </div>&nbsp;&nbsp;&nbsp;
		  会议发起人：
		  <div class="layui-inline">
		    <select name="hyfqr" id="hyfqr" class="layui-select" lay-filter="hyfqr" >
		        <option value="">---请选择---</option>
		        <c:forEach items="${userlist }" var="user">
		        	<option value="${user.yhdm }">${user.yhxm }</option>
		        </c:forEach>
		     </select>
		  </div>&nbsp;&nbsp;&nbsp;
		  
		  <input type="submit" class="layui-btn" value="查询">
		  <input type="button" class="layui-btn" value="新增" onclick="newMeeting()">
		</div>
		<br>
		<table id="table" class="layui-table">
		  <thead>
		    <tr>
		      <th>会议标题</th>
		      <th>时间</th>
		      <th>地点</th>
		      <th>发起人</th>
		      <th>说明</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		    <c:forEach items="${pb.list }" var="meeting">
		    	<tr>
		    		<td>${meeting.hybt }</td>
		    		<td>${meeting.hysj }</td>
		    		<td>${meeting.hydz }</td>
		    		<td>${meeting.hyfqr.yhxm }</td>
		    		<td>${meeting.remark}</td>
		    		<td>
		    			<a class="view" href="viewByHyid.do?hyid=${meeting.hyid }">查看</a>  
		    			<c:choose>
		    				<c:when test="${meeting.hyfqr.yhdm eq userExist.yhdm }">
		    					<a class="del"  onclick="deleteById('${meeting.hyid }')" layEvent="del">删除</a>
		    				</c:when>
		    				<c:otherwise>
		    					<c:if test="${userExist.yhzh eq 'admin' }">
				    				<a class="del"  onclick="deleteById('${meeting.hyid }')" layEvent="del">删除</a>
				    			</c:if> 
		    				</c:otherwise>
		    			</c:choose>
		    		</td>
		    	</tr>
		    </c:forEach>
		  </tbody>
		</table>
		</form>
		<div style="float:left; width: 100%; text-align: center;">
			<%@include file="../include/pagination.jsp" %>
		</div>
    </div>
  </div>
  
</div>

</body>
</html>