//创建Vue对象，管理数据
var category_admin = new Vue({
	el:'#category-admin',
	data:{
        currentId : '',
        cNum:0,
        tNum:0,
        all_category_account:0
	},
	methods:{
		deleteRow:function(e){
			this.currentId = $(e.target).parents('tr').attr('id'); 
			$("#delModal").modal('show');
		},
		editCategoryName:function(e){
			this.currentId = $(e.target).parents('tr').attr('id');
			$("#editModal").modal('show').find('input').val($("#"+this.currentId).find('.cName').text().trim()).focus();
		},
		addRow:function(e){
			$("#editModal").modal('show').find('input').focus();
		}
	}
})
//计算类别个数和总共数量
var trs = $("tr:gt(0)") , num = new Number(0) , all = new Number(0);
category_admin.$data.cNum = trs.length;
for(var i = 0 ;i<trs.length;i++){
    num += parseInt($(trs[i]).find('.bookCount').text());
    all += parseInt($(trs[i]).find('.category-account').text().trim());
}
category_admin.$data.tNum = num
category_admin.$data.all_category_account = all;


//confirm delete 
$("#del").click(function(){
    var tr = $("#"+ category_admin.$data.currentId);
    var num = parseInt(tr.find('.bookCount').text().trim())
    var all = parseInt(tr.find('.category-account').text().trim())
    tr.remove();
	//发起post 删除类别
    $.getJSON('/seller/delCategory.action', {'id':category_admin.$data.currentId}, function(json) {
        //将要删除的类别ID发给服务器，同步删除
        if(json=="noLogin"){
            window.location.href = "/seller/loginPage.action";
        }
    });

    category_admin.$data.cNum--;
    category_admin.$data.tNum -=num;
    category_admin.$data.all_category_account -= all
    $("#delModal").modal('hide');
})

//confirm edit 
$("#confirmEdit").click(function(){
	var $input = $("#editModal").find('input');
	var cName = $input.val().trim(); //类别名称
    var score = $("#categoryScore option:selected").text().trim(); //类别优先级
	if(cName==''||score==''){
		//如果类别名为空
		$input.parents('.form-group').addClass('has-error');
		$input.siblings('.help-block').text('类别名称不能为空！')
		return false;
	}
	//发起post请求，编辑或添加类别，类别ID 为 category_admin.$data.currentId
	if(category_admin.$data.currentId==''){
		//添加操作
        $.post('/seller/addUpdateCategory.action', {'name': cName,"score":score}, function(json) {
            if(json=='repeat'||json=="error"){
                alert("该类别已经存在");
                $input.parents('.form-group').addClass('has-error');
                $input.siblings('.help-block').text('该类名已存在！')
                return false;
            }else if(json=="noLogin"){
                window.location.href = "/seller/login.action";
            }else{
                window.location.href = "/seller/categoryPage.action";
            }
        });

	}else{
        console.log('edit')
		//编辑操作
        $.post('/seller/addUpdateCategory.action', {'id': category_admin.$data.currentId,'name':cName,'score':score}, function(json, textStatus) {
            console.log(json);
            if(json=='repeat'||json=="error"){
                alert("该类别已经存在");
                $input.parents('.form-group').addClass('has-error');
                $input.siblings('.help-block').text('该类名已存在！')
                return false;
            }else if(json=="noLogin"){
                window.location.href = "/seller/login.action";
            }else{
                window.location.href = "/seller/categoryPage.action";
            }
        });
	}
	$("#editModal").modal('hide');
})



//模态框消失后清除 currentId
$("#delModal").on('hide.bs.modal',function(){
	category_admin.$data.currentId = '';
})


//清除编辑弹框的遗留
$("#editModal").on('hide.bs.modal',function(){
	var $input = $("#editModal").find('input').val('');
	$input.parents('.form-group').removeClass('has-error');
	$input.siblings('.help-block').text('')
    category_admin.$data.currentId = ''
})









