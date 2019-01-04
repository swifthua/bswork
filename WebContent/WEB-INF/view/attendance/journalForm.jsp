<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String djsj=formatter.format(new Date());
%>
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
	layui.use(['element','form','laydate'], function(){
	  var element = layui.element;
	  var form =layui.form;
	  var laydate =layui.laydate;
	  //alert(element);
	  
	  //日期选择 
	  laydate.render({
		    elem: '#rzsj' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
		    ,value:new Date()
	  });
	  
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
	
	function check(){
		var currentTime=Date.parse(new Date());
		var rzsj=trim($("#rzsj").val());
		var duration=trim($("#duration").val());
		if(!rzsj){
			layer.alert("日志日期不能为空");
			return false;
		}
		if(!duration){
			layer.alert("工作时长不能为空");
			return false;
		}
		if(Date.parse(rzsj) > currentTime){
			layer.alert("日志日期不能大于当前系统时间");
			return false;
		}
		if(parseInt(duration)>=10){
			layer.alert("工作时长不能超过10小时");
			return false;
		}
		$.ajax({
			cache: false,
			async: true,
			type: "POST",
			data: {method: "findByYhdmAndRzsj", rzsj:rzsj,yhdm:'${userExist.yhdm}'},
			url: "findByYhdmAndRzsj.do",
			success: function(flag) {
				if(flag) {
					//alert(flag);
					layer.alert("今天日志已填写，不能再填写");		
					return false;
				}else{
					$("#form").submit();
				}
			}
		});
		
	}
	</script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">考勤管理/个人日志</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="journalAdd.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">日志登记 </div>
    	  
   		  <table class="layui-table" style="width: 80%;margin-left: 120px;">
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${userExist.bmdm.bmmc }</td>
   		  		<td>登记人</td>
   		  		<td>${userExist.yhxm}</td>
   		  	</tr>
   		  	
   		  	<tr>
   		  		<td>日志时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" id="rzsj" name="rzsj" >
					</div>
				</td>
   		  		<td>工作时长</td>
   		  		<td><input type="text" name="duration" id="duration" class="layui-input" style="border: 0px;" required lay-verify="required"></td>
   		  	</tr>
   		  	<tr>
   		  		<td>内容</td>
   		  		<td colspan="3"><textarea name="rznr" id="rznr" class="layui-textarea" style="border: 0px;"></textarea></td>
   		  	</tr>
   		  </table>
   		  <div class="layui-form-item" style="margin-left:495px;">
	    	  <input type="button" class="layui-btn" onclick="check()" lay-filter="formDemo" value="提交" >
	    	  <input type="reset" class="layui-btn layui-btn-primary" value="重置">
	      </div>
    	</form>
    </div>
  </div>
  
</div>

</body>
</html>