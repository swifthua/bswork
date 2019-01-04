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
  <script>
    (function () {
	    $.getJSON("/work/getAllDepart.do",function (departs) {
	    console.log(departs);
	    $.each(departs,function (index,item) {
	        $("<option/>").prop("value",item.code).html(item.name).appendTo("#bmdm");
	      });
	    });
	})();
  
	//JavaScript代码区域
	layui.use(['element','form'], function(){
	  var element = layui.element;
	  var form =layui.form;
	  //alert(element);
	  
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
	//表单重新渲染，否则加载不出来东西
	function renderForm() {
		layui.use('form', function() {
			var form = layui.form;// 高版本建议把括号去掉，有的低版本，需要加()
			form.render();
		});
	}
	
	function deleteByQjid(qjid){
		 layer.confirm('真的删除行么', function(){
	        window.location.href="delByQjid.do?qjid="+qjid;
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
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">考勤管理/请休假查询</span></div>
    <div style="padding: 20px;">
    	<form action="findQjMore.do" method="post" id="form" class="layui-form layui-form-pane1">
	    <div >
		  <c:choose>
		  	<c:when test="${userExist.yhzh eq 'admin' }">
		               部门：
			  <div class="layui-inline">
			    <select name="bmdm" id="bmdm" class="layui-select" lay-filter="bmdm" >
			        <option value="">--请选择--</option>
			    </select>
			  </div>&nbsp;&nbsp;&nbsp;&nbsp;
			  员工：
			  <div class="layui-inline">
			    <select name="yhdm" id="yhdm" class="layui-select" >
			        <option value="">--请选择--</option>
			    </select>
			  </div>&nbsp;&nbsp;&nbsp;&nbsp;
		  	</c:when>
		  	<c:otherwise>
		  	<c:choose>
		  	<c:when test="${fn:substring(userExist.zwdm.zwdm,fn:length(userExist.zwdm.zwdm)-2,fn:length(userExist.zwdm.zwdm)) eq '01' }">
		  	     部门：
		  	  <div class="layui-inline">
			    <select name="bmdm" id="bmdm" class="layui-select" lay-filter="bxlx" disabled="disabled">
			        <option value="${userExist.bmdm.bmdm }">${userExist.bmdm.bmmc }</option>
			    </select>
			  </div>&nbsp;&nbsp;&nbsp;&nbsp;
			    员工：
			  <div class="layui-inline">
			    <select name="yhdm" id="yhdm" class="layui-select" >
			        <option value="">--请选择--</option>
			        <c:forEach items="${list_user }" var="user">
			        	<option value="${user.yhdm }">${user.yhxm }</option>
			        </c:forEach>
			    </select>
			  </div>&nbsp;&nbsp;&nbsp;&nbsp;
			  </c:when>
			  <c:otherwise>
			   部门：
		  	  <div class="layui-inline">
			    <select name="bmdm" id="bmdm" class="layui-select" lay-filter="bxlx" disabled="disabled">
			        <option value="${userExist.bmdm.bmdm }">${userExist.bmdm.bmmc }</option>
			    </select>
			  </div>&nbsp;&nbsp;&nbsp;&nbsp;
			    员工：
			  <div class="layui-inline">
			    <select name="yhdm" id="yhdm" class="layui-select" disabled="disabled">
			        <option value="${userExist.yhdm }">${userExist.yhxm }</option>
			    </select>
			  </div>&nbsp;&nbsp;&nbsp;&nbsp;
			  </c:otherwise>
			  </c:choose>
		  	</c:otherwise>
		  </c:choose>
			<div class="layui-inline">
			    <select name="wczt" id="wczt" class="layui-select" >
			        <option value="">--请选择--</option>
			        <c:forEach items="${list_status }" var="status">
			        	<option value="${status.ztid }">${status.ztms }</option>
			        </c:forEach>
			    </select>
			 </div>&nbsp;&nbsp;&nbsp;&nbsp;
	      <input type="submit" class="layui-btn"  value="查询">
		</div>
		<br>
			<table id="table" class="layui-table">
			  <thead>
			    <tr>
			      <th>姓名</th>
			      <th>登记日期</th>
			      <th>请假事由</th>
			      <th>请假时间</th>
			      <th>状态</th>
			      <th>操作</th>
			    </tr> 
			  </thead>
			  <tbody>
			    <c:forEach items="${pb.list }" var="leave">
			    	<tr>
			    		<td>${leave.qjr.yhxm}</td>
			    		<td>${fn:substring(leave.djsj,0,16)}</td>
			    		<td>${leave.remark }</td>
			    		<td>${fn:substring(leave.qjStart,0,16)} —— ${fn:substring(leave.qjStop,0,16)}</td>
			    		<td>${leave.wczt.ztms}</td>
			    		<td>
			    			<a class="view" href="viewByQjid.do?qjid=${leave.qjid }">查看</a>  
			    			<c:if test="${userExist.yhzh eq 'admin' }">
			    				<a class="del"  onclick="deleteByQjid('${leave.qjid }')" layEvent="del">删除</a>
			    			</c:if>
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