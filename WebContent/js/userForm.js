//加载所有部门
(function () {
    $.getJSON("/work/getAllDepart.do",function (departs) {
    console.log(departs);
    $.each(departs,function (index,item) {
        $("<option/>").prop("value",item.code).html(item.name).appendTo("#bmdm");
      });
    });
})();

//layui
layui.use(['element','layer','form','laydate'], function(){
  var element = layui.element;
  var layer=layui.layer;
  var form = layui.form;
  var laydate = layui.laydate;
  
  //日期选择 
  laydate.render({
	    elem: '#csrq' //指定元素
	    ,type: 'datetime'
	    ,theme: '#393D49'
	    //,range: true
	    ,trigger: 'click'
  });

  //事件监听
  form.on('select', function(data){
    console.log('select: ', this, data);
  });
  
  
  form.on('select(interest)', function(data){
    console.log('select.interest: ', this, data);
  });
  
  form.on('select(bmdm)', function(data){
	  $("#zwdm").find("option").not(":first").remove(); //保留第一项，移除所有option
      var bcode=data.value;
      console.log("选择的部门"+bcode);

      if(bcode){
	      $.getJSON("/work/getPositionByDepart.do",{code:bcode},function (positions) {
	          console.log(positions);
	
	          $.each(positions,function (index,item) {
	              $("<option/>").prop("value",item.code).html(item.name).appendTo("#zwdm");
	              //$("#zwdm").append("<option value="+item.code+">"+item.name+"</option>"); 
	          });
	          renderForm();
	
	      });
      }else{
    	  $("#zwdm").find("option").not(":first").remove();
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

function check(){
	var yhxm=trim($("#yhxm").val());
	if(!yhxm){
		layer.confirm("用户姓名不能为空！");
		return false;
	}

	var bmdm=trim($("#bmdm option:selected").val());
	if(!bmdm){
		layer.confirm("所在部门不能为空");
		return false;
	}
	var zwdm=trim($("#zwdm option:selected").val());
	if(!zwdm){
		layer.confirm("职位不能为空");
		return false;
	}
	
	var phone=trim($("#phone").val());
	if(phone){
		//var regphone="/^0?1[3|4|5|7|8][0-9]\d{8}$/";
		if(!/^0?1[3|4|5|7|8][0-9]\d{8}$/.test(phone)){
			layer.alert("电话格式不正确");
			return false;
		}
	}
	var email=trim($("#email").val());
	if(email){
		//var regemail="/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/";
		if(!/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/.test(email)){
			layer.alert("邮箱格式不正确");
			return false;
		}
	}
	$("#form").submit();
}