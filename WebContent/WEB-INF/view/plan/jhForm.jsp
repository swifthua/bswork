<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String bxrq=formatter.format(new Date());
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
	$(function(){
	    $.getJSON("/work/getAllDepart.do",function (departs) {
		    console.log(departs);
		    $.each(departs,function (index,item) {
		        $("<option/>").prop("value",item.code).html(item.name).appendTo("#bmdm");
		      });
		});
	});
	
	//JavaScript代码区域
	layui.use(['element','laydate','form','layer'], function(){
	  var element = layui.element;
	  var laydate =layui.laydate;
	  var form =layui.form;
	  var layer=layui.layer;
	  //alert(element);
	  
	  //日期选择 
	  laydate.render({
		    elem: '#jhStart1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#jhStart2'
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
		    elem: '#jhStop1' //指定元素
		    ,theme: '#393D49'
		    ,format:"yyyy-MM-dd"
		    //,range: true
		    ,trigger: 'click'
	  });
	  
	  laydate.render({
		    elem: '#jhStop2'
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
	  
	  form.on('select(bmdm)', function(data){
		  $("#yhdm").find("option").not(":first").remove(); //保留第一项，移除所有option
	      var bcode=data.value;
	      console.log("选择的部门"+bcode);

	      if(bcode){
		      $.getJSON("/work/getUserByDepart.do",{code:bcode},function (positions) {
		          console.log(positions);
		
		          $.each(positions,function (index,item) {
		              $("<option/>").prop("value",item.code).html(item.name).appendTo("#yhdm");
		              //$("#zwdm").append("<option value="+item.code+">"+item.name+"</option>"); 
		          });
		          renderForm();
		
		      });
	      }else{
	    	  $("#yhdm").find("option").not(":first").remove();
	      }
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
		var jhStart1=trim($("#jhStart1").val());
		var jhStart2=trim($("#jhStart2").val());
		var jhStart=Date.parse(jhStart1+" "+jhStart2);
		if(!jhStart){
			layer.alert("起始时间不能为空！");
			return false;
		}
		if(jhStart < currentTime){
			layer.alert("起始时间不能小于当前系统时间！");
			return false;
		}
		var jhStop1=trim($("#jhStop1").val());
		var jhStop2=trim($("#jhStop2").val());
		var jhStop=Date.parse(jhStop1+" "+jhStop2);
		if(!jhStop){
			layer.alert("结束时间不能为空！");
			return false;
		}
		if(jhStop< currentTime){
			layer.alert("结束时间不能小于当前系统时间！");
			return false;
		}
		if(jhStop<jhStart){
			layer.alert("结束时间不能小于起始时间！");
			return false;
		}
		
		$("#form").submit();
	}
	
	//表单重新渲染，否则加载不出来东西
	function renderForm() {
		layui.use('form', function() {
			var form = layui.form;// 高版本建议把括号去掉，有的低版本，需要加()
			form.render();
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
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">计划制定/制定计划</span></div>
    <div style="padding: 20px;">
    	<form class="layui-form layui-form-pane1" action="arrangeAdd.do" id="form">
    	  <div style="margin-left:495px;font-size: 20px;font-weight: bold;">制定计划 </div>
   		  <table class="layui-table" >
   		  	<tr>
   		  		<td>部门</td>
   		  		<td>${userExist.bmdm.bmmc }</td>
   		  		<td>安排人</td>
   		  		<td>${userExist.yhxm}</td>
   		  	</tr>
   		  	<tr>
   		  		<td>项目</td>
   		  		<td>
   		  			<select name="xmdm" id="xmdm" required lay-verify="required" style="border: 0px;">
   		  				<option value="">--请选择--</option>
   		  				<c:forEach items="${list_project }" var="project">
   		  					<option value="${project.xmdm }">${project.xmmc }</option>
   		  				</c:forEach>
   		  			</select>
   		  		</td>
   		  		<td>登记日期</td>
   		  		<td><%=bxrq%></td>
   		  	</tr>
   		  	<tr>
   		  		<td>计划开始时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" id="jhStart1" name="jhStart1" required lay-verify="required">
					</div>
					<div class="layui-inline">
					  <input type="text" class="layui-input" id="jhStart2" name="jhStart2" required lay-verify="required">
					</div>
   		  		</td>
   		  		<td>计划结束时间</td>
   		  		<td>
   		  			<div class="layui-inline" >
					  <input type="text" class="layui-input" id="jhStop1" name="jhStop1" required lay-verify="required">
					</div>
					<div class="layui-inline">
					  <input type="text" class="layui-input" id="jhStop2" name="jhStop2" required lay-verify="required">
					</div>
   		  		</td>
   		  	</tr>
   		  	
   		  	
   		  	<tr>
   		  		
   		  		<td>负责人</td>
   		  			<c:choose>
					  	<c:when test="${userExist.yhzh eq 'admin' }">
					     <td> 部门：
						  <div class="layui-inline">
						    <select name="bmdm" id="bmdm" class="layui-select" lay-filter="bmdm" >
						        <option value="">--请选择--</option>
						    </select>
						  </div>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						 <td colspan="2">员工：
						  <div class="layui-inline">
						    <select name="yhdm" id="yhdm" class="layui-select" >
						        <option value="">--请选择--</option>
						    </select>
						  </div>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					  	</c:when>
					  	<c:otherwise>
					  	 <td>部门：
					  	  <div class="layui-inline">
						    <select name="bmdm" id="bmdm" class="layui-select" lay-filter="bxlx" disabled="disabled">
						        <option value="${userExist.bmdm.bmdm }">${userExist.bmdm.bmmc }</option>
						    </select>
						  </div>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						  <td colspan="2">员工：
						  <div class="layui-inline">
						    <select name="yhdm" id="yhdm" class="layui-select" >
						        <option value="">--请选择--</option>
						        <c:forEach items="${list_user }" var="user">
						        	<option value="${user.yhdm }">${user.yhxm }</option>
						        </c:forEach>
						    </select>
						  </div>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					  	</c:otherwise>
		  			</c:choose>
   		  		
   		  	</tr>
   		  	<tr>
   		  		<td>计划内容</td>
   		  		<td colspan="3"><textarea name="jhnr" class="layui-textarea" style="border: 0px;"></textarea></td>
   		  	</tr>
   		  </table>
   		  <div class="layui-form-item" style="margin-left:495px;">
	    	  <input type="button" class="layui-btn" lay-filter="formDemo" onclick="check()" value="提交" >
	    	  <input type="reset" class="layui-btn layui-btn-primary" value="重置">
	      </div>
    	</form>
    </div>
  </div>
  
</div>
</body>
</html>