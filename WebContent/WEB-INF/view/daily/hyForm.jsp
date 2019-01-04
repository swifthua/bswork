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
	  //alert(element);
	  
	  //日期选择 
	  laydate.render({
		    elem: '#hysj1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#hysj2'
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

	});
	  function check(){
		  var hybt=trim($("#hybt").val());
		  if(!hybt){
			  layer.confirm("会议标题不能为空！");
			  return false;
		  }
		  var hysj1=trim($("#hysj1").val());
		  if(!hysj1){
			  layer.confirm("会议日期不能为空！");
			  return false;
		  }
		  var hysj2=trim($("#hysj2").val());
		  if(!hysj2){
			  layer.confirm("会议时间不能为空！");
			  return false;
		  }
		  var hysj=Date.parse(hysj1+" "+hysj2);
		  var currentTime=Date.parse(new Date());
		  if(currentTime>=hysj){
			  layer.alert("会议时间不能小于当前系统时间！");
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
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">系统管理/会议添加</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="meetingAdd.do" id="form">
   		  <div class="layui-form-item" >
		    <label class="layui-form-label">会议标题<span style="color:red;">*</span></label>
		    <div class="layui-input-block" style="width: 650px;">
		      <input type="text" name="hybt" id="hybt" required lay-verify="required" autocomplete="off" class="layui-input" >
		    </div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">发起人</label>
		    <div class="layui-input-block" style="width: 650px;">
			    <input type="text" class="layui-input" id="lxr" name="lxr" value="${userExist.yhxm }" disabled="disabled">
      		</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">会议地址<span style="color:red;">*</span></label>
		    <div class="layui-input-block" style="width: 650px;">
			    <input type="text" class="layui-input" id="hydz" name="hydz" value="会议室" disabled="disabled">
      		</div>
		  </div>
		  
		  <div class="layui-form-item"> 
		    <label class="layui-form-label">会议时间<span style="color:red;">*</span></label>
		    <div class="layui-inline" >
			  <input type="text" class="layui-input" id="hysj1" name="hysj1" required lay-verify="required">
			</div>
			<div class="layui-inline">
			  <input type="text" class="layui-input" id="hysj2" name="hysj2" required lay-verify="required">
			</div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">会议内容</label>
		    <div class="layui-input-block" style="width: 650px;">
		      <textarea name="hynr"  class="layui-textarea"></textarea>
		    </div>
		  </div>
		  
		  <div class="layui-form-item">
		    <label class="layui-form-label">备注</label>
		    <div class="layui-input-block" style="width: 650px;">
			    <input type="text" class="layui-input" id="remark" name="remark" >
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