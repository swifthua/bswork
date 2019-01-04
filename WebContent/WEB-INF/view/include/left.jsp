<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>left.jsp</title>
</head>
<body>
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域-->
      <span style="padding-left:50px;font-weight: bold;font-size: 18px;">功能导航区</span>
      <ul class="layui-nav layui-nav-tree"  >
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">日常管理</a>
          <dl class="layui-nav-child">
            <dd><a href="findAllMeeting.do">会议通知</a></dd>
            <dd><a href="findAllNotify.do">公告信息</a></dd>
          </dl>
        </li>
        
        <li class="layui-nav-item">
          <a href="javascript:;">计划制定</a>
          <dl class="layui-nav-child">
            <dd><a href="toGrjhList.do">个人计划</a></dd>
            <dd><a href="toBmjhList.do">部门计划</a></dd>
            <dd><a href="toNotFound.do">企业计划</a></dd>
          </dl>
        </li>
        
        <li class="layui-nav-item">
          <a href="javascript:;">考勤管理</a>
          <dl class="layui-nav-child">
            <dd><a href="toJournalForm.do">个人日志</a></dd>
            <dd><a href="toJournalList.do">出勤绩效查询</a></dd>
            <dd><a href="toLeaveForm.do">请休假登记</a></dd>
            <dd><a href="toLeaveList.do">请休假查询</a></dd>
          </dl>
        </li>
        
        <li class="layui-nav-item">
          <a href="javascript:;">报销管理</a> 
          <dl class="layui-nav-child">
            <dd><a href="toTravel.do">出差报销</a></dd>
            <dd><a href="toExpense.do">费用报销</a></dd>
            <dd><a href="tofindExpense.do">报销查询</a></dd>
          </dl>
        </li>
        
        <c:if test="${fn:substring(userExist.zwdm.zwdm,fn:length(userExist.zwdm.zwdm)-2,fn:length(userExist.zwdm.zwdm)) eq '01' }"> 
	        <li class="layui-nav-item">
	          <a href="javascript:;">审核管理</a>
	          <dl class="layui-nav-child">
	            <dd><a href="toLeaveExamineList.do">请休假审核</a></dd>
	            <c:if test="${userExist.yhzh eq 'admin' }">  
	            	<dd><a href="toExpenseExamineList.do">报销审核</a></dd>
	            </c:if>
	          </dl>
	        </li>
        </c:if>
        
        
        <c:if test="${userExist.yhzh eq 'admin' }">  
        <li class="layui-nav-item">
          <a href="javascript:;">系统管理</a>
          <dl class="layui-nav-child">
            <dd><a href="findAllUser.do">员工管理</a></dd>
            <dd><a href="findAllProject.do">项目管理</a></dd>
            <dd><a href="tongxunlu.do">通讯录</a></dd>
          </dl>
        </li>
        </c:if>
      </ul>
    </div>
  </div>
</body>
</html>