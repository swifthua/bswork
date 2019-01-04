<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>办公自动化管理系统首页</title>
  <link rel="stylesheet" href="ext/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="ext/layui/css/font_eolqem241z66flxr.css" media="all">
  <link rel="stylesheet" href="css/home.css" media="all">
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
  <%@include file="include/header.jsp" %>
  <%@include file="include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="include/pageheader.jsp" %>
  	
	<div><span style="font-size: 30px;margin-left:20px;">欢迎使用办公自动化管理系统</span></div>
	<div class="panel_box row">
		<div class="panel col max_panel">
			<a href="toJournalForm.do" data-url="page/news/newsList.html">
				<div class="panel_icon" style="background-color:#2F4056;">
					<i class="iconfont icon-text" data-icon="icon-text"></i>
				</div>
				<div class="panel_word allNews">
					<span></span>
					<em>个人日志</em>
				</div>
			</a>
		</div>
		<div class="panel col">
			<a href="findAllNotify.do" data-url="page/message/message.html">
				<div class="panel_icon">
					<i class="layui-icon" data-icon="&#xe63a;">&#xe63a;</i>
				</div>
				<div class="panel_word newMessage">
					<span></span>
					<cite>公告通知</cite>
				</div>
			</a>
		</div>
		<div class="panel col">
			<a href="tongxunlu.do" data-url="page/user/allUsers.html">
				<div class="panel_icon" style="background-color:#009688;">
					<i class="layui-icon" data-icon="&#xe613;">&#xe613;</i>
				</div>
				<div class="panel_word userAll">
					<span></span>
					<cite>通讯录</cite>
				</div>
			</a>
		</div>
		<div class="panel col">
			<a href="toNotFound.do" data-url="page/news/newsList.html">
				<div class="panel_icon" style="background-color:#F7B824;">
					<i class="iconfont icon-wenben" data-icon="icon-wenben"></i>
				</div>
				<div class="panel_word waitNews">
					<span></span>
					<cite>待审核</cite>
				</div>
			</a>
		</div>
		

		<div class="panel col">
			<a href="toNotFound.do" data-url="page/img/images.html">
				<div class="panel_icon" style="background-color:#5FB878;">
					<i class="layui-icon" data-icon="&#xe64a;">&#xe64a;</i>
				</div>
				<div class="panel_word imgAll">
					<span></span>
					<cite>图片总数</cite>
				</div>
			</a>
		</div>
	</div>
	
	<div style="margin-left: 20px;">
		<blockquote class="layui-elem-quote title">系统基本参数</blockquote>
		<table class="layui-table">
			<colgroup>
				<col width="150">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<td>当前版本</td>
					<td class="version">测试版本</td>
				</tr>
				<tr>
					<td>开发作者</td>
					<td class="author">zh</td>
				</tr>
				<tr>
					<td>服务器环境</td>
					<td class="server">Tomcat6.0</td>
				</tr>
				<tr>
					<td>数据库版本</td>
					<td class="dataBase">Sybase</td>
				</tr>
				<tr>
					<td>最大上传限制</td>
					<td class="maxUpload">10M以下</td>
				</tr>
			</tbody>
		</table>
	</div>
	
  </div>
  
  <div class="layui-footer">
    © 版权所有Chengdu University of Technology  -by zh
  </div>
</div>
</body>
</html>