
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

function newProject(){
	window.location.href="toProjectForm.do";
}

function deleteById(xmdm){
	 layer.confirm('真的删除行么', function(){
        window.location.href="delByXmdm.do?xmdm="+xmdm;
     }); 
}

