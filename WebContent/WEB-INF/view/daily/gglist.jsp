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
  <script type="text/javascript">

	  layui.use(['element','layer','form'], function(){
	    var element = layui.element;
	    var layer=layui.layer;
	    var form = layui.form;
	    var laydate = layui.laydate;
	    
	
	    //事件监听
	    form.on('select', function(data){
	      console.log('select: ', this, data);
	    });
	    
	    //监听提交
	    form.on('submit(*)', function(data){
	      console.log(data);
	      return false;
	    });
	    
	    //全选  
        form.on('checkbox(allChoose)', function(data){  
            /* var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');  
            child.each(function(index, item){  
              item.checked = data.elem.checked;
            });  
            form.render('checkbox');  */ 
            
        	var a = data.elem.checked;
        	if(a == true){
        		$(".check").prop("checked", true);
        		form.render('checkbox');
        	}else{
        		$(".check").prop("checked", false);
        		form.render('checkbox');
        	} 
        	
        }); 
	    
	    //有一个没选中取消全选 
	    form.on('checkbox(oneChoose)',function(data){
	    	var item = $(".check");
        	for(var i=0;i<item.length;i++){
        		if(item[i].checked == false){
        			$("#checkAll").prop("checked", false);
        			form.render('checkbox');
        		}
        	}
	    });
	  });
	
	  //表单重新渲染，否则加载不出来东西
	  function renderForm() {
	  	layui.use('form', function() {
	  		var form = layui.form;// 高版本建议把括号去掉，有的低版本，需要加()
	  		form.render();
	  	});
	  }
	
	  function newNotify(){
	  	window.location.href="toNotifyForm.do";
	  }
	
	  function deleteById(ggid){
	  	 layer.confirm('真的删除行么', function(){
	          window.location.href="delByGgid.do?ggid="+ggid;
	     }); 
	  }
	  
	  //批量删除
	  function deleteBatch(){
		  var chckBox = document.getElementsByName("checkbox");
		  var num = chckBox.length;
		  var ids = "";
		  for (var index = 0; index < num; index++) {
			  if (chckBox[index].checked) {
			  	ids += chckBox[index].value + ",";
			  }
		  }
		  if(ids){
			 layer.confirm('真的批量删除行么', function(){
		          window.location.href="deleteNotifyByIds.do?ids="+ids;
		     }); 
		  }else{
			  layer.alert("请选择一条记录后再操作");
			  return false;
		  }
	  }
	  
  </script>


</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <%@include file="../include/header.jsp" %>
  <%@include file="../include/left.jsp" %>
  
  <div class="layui-body">
  	<%@include file="../include/pageheader.jsp" %>
    <div style="padding-left: 20px;padding-top: 10px;">	当前位置:<span style="color: blue;">公告管理</span></div>
    <div style="padding: 20px;">
    	<form action="findNotifyCondition.do" method="post" id="form" class="layui-form layui-form-pane1">
    	<div >
		 公告标题：
		  <div class="layui-inline">
		    <input class="layui-input" name="ggbt" id="ggbt" autocomplete="off" style="width: 100%;">
		  </div>&nbsp;&nbsp;&nbsp;
		  公告发起人：
		  <div class="layui-inline">
		    <select name="fqr" id="fqr" class="layui-select" lay-filter="fqr" >
		        <option value="">---请选择---</option>
		        <c:forEach items="${userlist }" var="user">
		        	<option value="${user.yhdm }">${user.yhxm }</option>
		        </c:forEach>
		     </select>
		  </div>&nbsp;&nbsp;&nbsp;
		  
		  <input type="submit" class="layui-btn" value="查询">
		  <input type="button" class="layui-btn" value="新增" onclick="newNotify()">
		  <c:if test="${userExist.yhzh eq 'admin' }">
		 	 <input type="button" class="layui-btn" value="批量删除" onclick="deleteBatch()">
		  </c:if>
		</div>
		<br>
		<table id="table" class="layui-table">
		  <thead>
		    <tr>
		      <th><input type="checkbox" id="checkAll"  lay-skin="primary" lay-filter="allChoose"/></th>
		      <th>公告标题</th>
		      <th>发起时间</th>
		      <th>发起人</th>
		      <th>最近更新</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		    <c:forEach items="${pb.list }" var="notify">
		    	<tr>
		    		<td><input type="checkbox" class="check" name="checkbox" value="${notify.ggid }" lay-skin="primary" lay-filter="oneChoose"/></td>
		    		<td>${notify.ggbt }</td>
		    		<td>${notify.fqsj }</td>
		    		<td>${notify.fqr.yhxm }</td>
		    		<td>${notify.lastUpdate}</td>
		    		<td>
		    			<a class="view" href="viewByGgid.do?ggid=${notify.ggid }">查看</a>  
		    			<c:choose>
		    				<c:when test="${notify.fqr.yhdm eq userExist.yhdm }">
		    					<a class="edit" href="editByGgid.do?ggid=${notify.ggid }">编辑</a>  
		    					<a class="del"  onclick="deleteById('${notify.ggid }')" layEvent="del">删除</a>
		    				</c:when>
		    				<c:otherwise>
		    					<c:if test="${userExist.yhzh eq 'admin' }">
		    						<a class="edit" href="editByGgid.do?ggid=${notify.ggid }">编辑</a>  
				    				<a class="del"  onclick="deleteById('${notify.ggid }')" layEvent="del">删除</a>
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