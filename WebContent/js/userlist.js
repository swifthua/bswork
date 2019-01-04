//加载所有部门
(function () {
    $.getJSON("/work/getAllDepart.do",function (departs) {
    console.log(departs);
    $.each(departs,function (index,item) {
        $("<option/>").prop("value",item.code).html(item.name).appendTo("#bmdm");
      });
    });
})();


layui.use(['element','layer','form','laydate'], function(){
  var element = layui.element;
  var layer=layui.layer;
  var form = layui.form;
  var laydate = layui.laydate;
  

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

function newUser(){
	window.location.href="toUserForm.do";
}

function deleteById(yhdm){
	 layer.confirm('真的删除行么', function(){
        window.location.href="delByYhdm.do?yhdm="+yhdm;
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
		 layer.confirm('真的删除行么', function(){
	          window.location.href="deleteUserByIds.do?ids="+ids;
	     }); 
	  }else{
		  layer.alert("请选择一条记录后再操作");
		  return false;
	  }
}
