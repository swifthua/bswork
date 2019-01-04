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
	layui.use(['element','laydate','form'], function(){
	  var element = layui.element;
	  var laydate =layui.laydate;
	  var form =layui.form;
	  //alert(element);
	  
	  //日期选择 
	  laydate.render({
		    elem: '#ccStart1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#ccStart2'
		    ,type: 'time'
		    ,min: '09:30:00'
		    ,max: '17:30:00'
		    ,done: function(value, date, endDate){
		      console.log(value, date, endDate);
		    }
		    ,change: function(value, date, endDate){
		      //this.elem.val(value)
		    }
	  });
	  
	  laydate.render({
		    elem: '#ccStop1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#ccStop2'
		    ,type: 'time'
		    ,min: '09:30:00'
		    ,max: '17:30:00'
		    ,done: function(value, date, endDate){
		      console.log(value, date, endDate);
		    }
		    ,change: function(value, date, endDate){
		      //this.elem.val(value)
		    }
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
	</script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">审核管理/差旅报销审核</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="examineByCcid.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">差旅报销审核 </div>
    	  <input type="hidden" name="ccid" id="ccid" value="${business.ccid }">
   		  <table class="layui-table" >
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${business.ccr.bmdm.bmmc}</td>
   		  		<td>报销人</td>
   		  		<td>${business.ccr.yhxm}</td>
   		  	</tr>
   		  	<tr>
   		  		<td>项目</td>
   		  		<td>
   		  			<select name="xmdm" id="xmdm" disabled="disabled" style="border: 0px;">
   		  				<option value="">${business.xmdm.xmmc }</option>
   		  			</select>
   		  		</td>
   		  		<td>报销日期</td>
   		  		<td>${business.djrq }</td>
   		  	</tr>
   		  	<tr>
   		  		<td>出差开始时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" value="${business.ccStart }" disabled="disabled"> 
					</div>
   		  		</td>
   		  		<td>出差结束时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input"  value="${business.ccStop }" disabled="disabled">
					</div>
   		  		</td>
   		  	</tr>
   		  	<tr>
   		  		<td>行程工具</td>
   		  		<td>
   		  			<select name="xcgj" id="xcgj" disabled="disabled" style="border: 0px;">
   		  				<option value="">${business.xcgj.gjms }</option>
   		  			</select>
   		  		</td>
   		  		<td>行程费用</td>
   		  		<td><input type="text" class="layui-input" id="xcfy" style="border: 0px;" name="xcfy" value="${business.xcfy }" disabled="disabled"></td>
   		  	</tr>
   		  	<tr>
   		  		<td>出差事由</td>
   		  		<td><input type="text" class="layui-input" id="ccly" style="border: 0px;" name="ccly" value="${business.ccly }" disabled="disabled"></td>
   		  		<td>市内交通费用</td>
   		  		<td><input type="text" class="layui-input" id="snjtfy" style="border: 0px;" name="snjtfy" value="${business.snjtfy }" disabled="disabled"></td>
   		  	</tr>
   		  	<tr>
   		  		<td>住宿费用</td>
   		  		<td><input type="text" class="layui-input" id="zsfy" style="border: 0px;" name="zsfy" value="${business.zsfy }" disabled="disabled"></td>
   		  		<td>总金额</td>
   		  		<td><div id="zfy">${business.zfy }</div></td>
   		  	</tr>
   		  	<tr>
   		  		<td>院长审核意见</td>
   		  		<td colspan="3">
					<input type="radio" name="shyj2" value="同意" title="同意">
     				<input type="radio" name="shyj2" value="不同意" title="不同意">
				</td>
   		  	</tr>
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