<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>宅文体商品管理</title>

    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="/asset/sellerAsset/css/zyUpload.css" type="text/css">
    <link href="/asset/sellerAsset/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/asset/sellerAsset/css/sb-admin.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="/asset/sellerAsset/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/asset/sellerAsset/css/bookRepertory.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<div id="wrapper">
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/seller/pendingOrderPage.action"><s:property value="#session.seller.name"/> </a>
    </div>
    <!-- Top Menu Items -->

    <ul class="nav navbar-right top-nav">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <s:property value="#session.seller.username"/> <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <%--<li>--%>
                <%--<a href="#" class="switchModel" data-target="seller-info"><i class="fa fa-fw fa-user" ></i> 我的信息</a>--%>
                <%--</li>--%>
                <li class="divider"></li>
                <li>
                    <a href="/seller/exit.action"><i class="fa fa-fw fa-power-off"></i> 退出</a>
                </li>
            </ul>
        </li>
    </ul>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav side-nav">
            <li>
                <a href="/seller/pendingOrderPage.action"><i class="fa fa-fw fa-bar-chart-o"></i> 待处理订单</a>
            </li>
            <li>
                <a href="/seller/waitingOrderPage.action"><i class="fa fa-fw fa-table"></i> 已接受订单</a>
            </li>
            <li >
                <a href="/seller/completeOrderPage.action"><i class="fa fa-fw fa-edit"></i> 已完成订单</a>
            </li>
            <li class="active">
                <a href="/seller/repertoryPage.action"><i class="fa fa-fw fa-wrench"></i> 库存查看</a>
            </li>
            <li>
                <a href="/seller/categoryPage.action"><i class="fa fa-fw fa-file"></i> 分类管理</a>
            </li>
        </ul>
    </div>
</nav>
<!-- 类别编辑 -->
    <input type="hidden" id="productId" value="<s:property value="id"/>">
<div id="page-wrapper">
            <div class="modal-header">
                <h1 class="modal-title">商品管理</h1>
            </div>
    <p class="remark" style="padding-left:10%;font-size: 12px; color: #888;margin: 0 0 10px;">
        注：商品头像的像素:320x320像素;轮播图像像素:640x300;商品详情图像:640x640!!
    </p>
            <div>
                <div id="uploadForm1" class="col-xs-10 col-xs-offset-1">
                    <div class="upload_box">
                        <div class="upload_main single_main">
                            <h3>商品头像</h3>
                            <div class="status_bar">
                                <div class="btns">
                                    <input onchange="javascript:headChange(event)" id="headImage" type="file" size="30" name="image">
                                    <div class="webuploader_pick">选择文件</div>
                                </div>
                            </div>
                            <div id="preview" class="upload_preview">
                                <s:if test="product.headImage!=null">
                                <div class="add_upload" >
                                    <div class="file_bar">
                                        <div style="padding:5px;">
                                            <p class="file_name">删除</p>
                                            <span class="file_del" data-index="'+image+'" title="删除"></span>
                                        </div>
                                    </div>
                                    <a  class="hightwith" title="点击添加文件" id="rapidAddImg" class="add_imgBox" href="javascript:void(0)">
                                        <div class="uploadImg" >
                                            <img class="upload_image hightwith" style="height: 120px;width: 100px;" src="<s:property value="product.headImage.image"/>" />
                                        </div>
                                    </a>
                                </div>
                                </s:if>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="uploadForm2" class="col-xs-10 col-xs-offset-1">
                    <div class="upload_box">
                        <div class="upload_main single_main">
                            <h3>商品轮播专区</h3>
                            <div class="status_bar">
                                <div class="btns">
                                    <input onchange="javascript:lunboChange(event)" id="lunboImage" type="file" size="30" name="image">
                                    <div class="webuploader_pick1">选择文件</div>
                                </div>
                            </div>
                            <div id="preview1" class="upload_preview">
                                <s:iterator value="product.lunboImages" var="lunboImage">
                                    <div class="add_upload" id="<s:property value="#lunboImage.id"/>">
                                        <div class="file_bar">
                                            <div style="padding:5px;">
                                                <p class="file_name">删除</p>
                                                <span class="file_del1" data-index="'+image+'" title="删除"></span>
                                            </div>
                                        </div>
                                        <a  class="hightwith" title="点击添加文件" id="rapidAddImg" class="add_imgBox" href="javascript:void(0)">
                                            <div class="uploadImg" >
                                                <img class="upload_image hightwith" style="height: 120px;width: 100px;" src="<s:property value="#lunboImage.image"/>" />
                                            </div>
                                        </a>
                                    </div>
                                </s:iterator>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="uploadForm" class="col-xs-10 col-xs-offset-1">
                    <div class="upload_box">
                        <div class="upload_main single_main">
                            <h3>商品详情专区</h3>
                            <div class="status_bar">
                                <div class="btns">
                                    <input onchange="javascript:detailChange(event)" id="detailImage" type="file" size="30" name="image">
                                    <div class="webuploader_pick2">选择文件</div>
                                </div>
                            </div>
                            <div id="preview2" class="upload_preview">
                                <s:iterator value="product.detailImages" var="detailImage">
                                    <div class="add_upload" id="<s:property value="#detailImage.id"/>">
                                        <div class="file_bar">
                                            <div style="padding:5px;">
                                                <p class="file_name">删除</p>
                                                <span class="file_del2" data-index="'+image+'" title="删除"></span>
                                            </div>
                                        </div>
                                        <a  class="hightwith" title="点击添加文件" id="rapidAddImg" class="add_imgBox" href="javascript:void(0)">
                                            <div class="uploadImg" >
                                                <img class="upload_image hightwith" style="height: 120px;width: 100px;" src="<s:property value="#detailImage.image"/>" />
                                            </div>
                                        </a>
                                    </div>
                                </s:iterator>
                            </div>
                        </div>
                    </div>
                </div>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-8">
                            <input type="text" maxlength="10" class="form-control product-name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-8">
                            <input type="text" maxlength="10" class="form-control product-price" >
                            <p id="productPriceE" hidden  class="pic-msg">请输入正确的数值,eg:1.1</p>

                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">商品备注</label>
                        <div class="col-sm-8">
                            <input class="form-control product-comments" maxlength="150"  rows="3" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">类别</label>
                        <div class="col-sm-8" style="height: 50px">
                            <select class="form-control product-category" >
                                <s:iterator value="categories" var="category">
                                    <option value="<s:property value="#category.id"/>"><s:property value="#category.name"/></option>
                                </s:iterator>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
    <button type="button" style="width: 20%;margin-left: 35%" class="btn btn-primary btn-lg productSubmit">确定</button>
</div>
</div>
<!-- 删除提醒 -->
<div class="modal" id="delModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p>添加商品成功</p>
            </div>
            <div class="modal-footer">
                <button type="button" id="del" class="btn btn-primary confirm">确定</button>
            </div>
        </div>
    </div>
</div>

<script src="/asset/sellerAsset/js/jquery.js"></script>
<script src="/asset/sellerAsset/js/bootstrap.min.js"></script>
<script src="/asset/sellerAsset/js/ajaxfileupload.js"></script>
<script src="http://cdn.bootcss.com/vue/0.12.16/vue.min.js"></script>
<script type="text/javascript">
    var image = 1;
    var productId = $("#productId").val();
    $(".productSubmit").click(function (e) {
        e.preventDefault();
        var category = $(".product-category").val().trim();
        var name =  $(".product-name").val().trim();
        var price =  $(".product-price").val().trim();
        var comments =  $(".product-comments").val().trim();
        if(comments==""||price==""||name==""){
            if(comments=='') $(".product-comments").attr('placeholder','商品备注不能为空');
            if(price=='') $(".product-price").attr('placeholder','商品价格不能为空');
            if(name=='') $(".product-name").attr('placeholder','商品民称不能为空');
            return;
        }
        if(isNaN(price)){
            $(".product-price").val('');
            $(".product-price").attr('placeholder','商品价格必须是数字')
            return;
        }

        var args = {"id":productId,"name":name,"price":price,"comments":comments,"categoryId":category};
        $.post('/seller/saveProduct.action',args,function (data) {
            console.log(data);
            if(data=='noLogin'){
                window.location.href="/seller/login.action"
            }else if(data=="success"){
                $("#delModal").modal('show');
            }else{
                alert('未知的错误');
            }
        })

    })

    $(".confirm").click(function () {
        window.location.href='/seller/repertoryPage.action';
    })
    $('.add_upload').on('mouseenter',function () {
        $(this).find(".file_bar").addClass("file_hover");
    })
    $('.add_upload').on('mouseleave',function () {
        $(this).find(".file_bar").removeClass("file_hover");
    })

    $('.file_del1').click(function (e) {
        var imageId = $(this).parent().parent().parent().attr('id').trim();
        var $target = $(this).parent().parent().parent();
        console.log(imageId)
        $.post('/seller/delImage.action',{'id':productId,'page':imageId,'index':0},function (data) {

            if(data=="success"){
                $target.remove();
            }else{
                alert("图片仅剩一张,无可删除的图片")
            }
        })
    })
    $('.file_del2').click(function (e) {
        var imageId = $(this).parent().parent().parent().attr('id').trim();
        var $target = $(this).parent().parent().parent();
        $.post('/seller/delImage.action',{'id':productId,'page':imageId,'index':1},function (data) {
            if(data=="success"){
                $target.remove();
            }else{
                alert("图片仅剩一张,无可删除的图片")
            }
        })
    })


    $(function () {
        $(".webuploader_pick").click(function () {
            $("#headImage").click();
        })
    })

    $(function () {
        $(".webuploader_pick1").click(function () {
            $("#lunboImage").click();
        })
    })

    $(function () {
        $(".webuploader_pick2").click(function () {
            $("#detailImage").click();
        })
    })
    function detailChange(e) {
        var imageId;
        $.ajaxFileUpload(
                {
                    url:'/seller/uploadDetailImage.action',
                    data:{"id":productId},
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId:'detailImage', //文件上传域的ID
                    dataType:'html', //返回值类型 一般设置为json
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                        var reg = new RegExp("^[0-9]*$");
                        if(reg.test(data.responseText)){
                            imageId = data.responseText;
                        }else if(data.responseText=="noLogin"){
                            window.location.href="/seller/login.action"
                        }else{
                            alert("未知的错误")
                        }
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        var reg = new RegExp("^[0-9]*$");
                        if(reg.test(data.responseText)){
                           imageId = data.responseText;
                        }else if(data.responseText=="noLogin"){
                            window.location.href="/seller/login.action"
                        }else{
                            alert("未知的错误")
                        }
                    }
                }
        )

        var target = $(e.target);
        var reader = new FileReader();
        //将文件以二进制形式读入页面
        reader.readAsDataURL(e.target.files[0]);
        reader.onload=function(e){
            var innerhtml = '<div class="add_upload" id="1">'
                    +'<div class="file_bar">		<div style="padding:5px;">			<p class="file_name">删除</p>                                                                         <span class="file_del" data-index="'+image+'" title="删除"></span>		</div>	</div>'
                    +'<a  class="hightwith" title="点击添加文件" id="rapidAddImg" class="add_imgBox" href="javascript:void(0)">'
                    +'<div class="uploadImg" >'
                    +'<img class="upload_image hightwith" style="height: 120px;width:100px" src="'+this.result+'" />'
                    +'</div></a></div>';
            var el = $(innerhtml);
            el.find(".file_del").bind('click',function(){
                var productId = $("#productId").val();
                var index = $(this).attr("data-index");
                console.log(imageId);
                $.post('/seller/delImage.action',{'id':productId,'page':imageId,'index':1},function (data) {
                    if(data=="success"){
                        el.remove();
                    }else{
                        alert("图片仅剩一张,无可删除的图片")
                    }
                })
            })
            el.bind({
                mouseenter: function(){
                    $(this).find(".file_bar").addClass("file_hover");
                },
                mouseleave: function(){
                    $(this).find(".file_bar").removeClass("file_hover");
                }
            })
            image++;
            $("#preview2").append(el);
        }
    }
    function headChange(e) {
        var imageId;
        $.ajaxFileUpload(
                {
                    url:'/seller/uploadHeadImage.action',
                    data:{"id":productId},
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId:'headImage', //文件上传域的ID
                    dataType:'html', //返回值类型 一般设置为json
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                        var reg = new RegExp("^[0-9]*$");
                        if(reg.test(data.responseText)){
                            imageId = data.responseText;
                        }else if(data.responseText=="noLogin"){
                            window.location.href="/seller/login.action"
                        }else{
                            alert("未知的错误")
                        }
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        var reg = new RegExp("^[0-9]*$");
                        if(reg.test(data.responseText)){
                            imageId = data.responseText;
                        }else if(data.responseText=="noLogin"){
                            window.location.href="/seller/login.action"
                        }else{
                            alert("未知的错误")
                        }
                    }
                }
        )

        var target = $(e.target);
        var reader = new FileReader();
        //将文件以二进制形式读入页面
        reader.readAsDataURL(e.target.files[0]);
        reader.onload=function(e){
            var innerhtml = '<div class="add_upload" id="1">'
                    +'<div class="file_bar">		<div style="padding:5px;">			<p class="file_name">删除</p>                                                                         <span class="file_del" data-index="'+image+'" title="删除"></span>		</div>	</div>'
                    +'<a  class="hightwith" title="点击添加文件" id="rapidAddImg" class="add_imgBox" href="javascript:void(0)">'
                    +'<div class="uploadImg" >'
                    +'<img class="upload_image hightwith" style="height: 120px;width:100" src="'+this.result+'" />'
                    +'</div></a></div>';
            var el = $(innerhtml);
            image++;
            $("#preview").children().remove();
            $("#preview").append(el);
        }
    }

    function lunboChange(e) {
        var imageId;
        $.ajaxFileUpload(
                {
                    url:'/seller/uploadLunboImage.action',
                    data:{"id":productId},
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId:'lunboImage', //文件上传域的ID
                    dataType:'html', //返回值类型 一般设置为json
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                        var reg = new RegExp("^[0-9]*$");
                        if(reg.test(data.responseText)){
                            imageId = data.responseText;
                        }else if(data.responseText=="noLogin"){
                            window.location.href="/seller/login.action"
                        }else{
                            alert("未知的错误");
                        }
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        var reg = new RegExp("^[0-9]*$");
                        if(reg.test(data.responseText)){
                            imageId = data.responseText;
                        }else if(data.responseText=="noLogin"){
                            window.location.href="/seller/login.action"
                        }else{
                            alert("未知的错误")
                        }
                    }
                }
        )

        var target = $(e.target);
        var reader = new FileReader();
        //将文件以二进制形式读入页面
        reader.readAsDataURL(e.target.files[0]);
        reader.onload=function(e){
            var innerhtml = '<div class="add_upload" id="1">'
                    +'<div class="file_bar">		<div style="padding:5px;">			<p class="file_name">删除</p>                                                                         <span class="file_del" data-index="'+image+'" title="删除"></span>		</div>	</div>'
                    +'<a  class="hightwith" title="点击添加文件" id="rapidAddImg" class="add_imgBox" href="javascript:void(0)">'
                    +'<div class="uploadImg" >'
                    +'<img class="upload_image hightwith" style="height: 120px;width:100" src="'+this.result+'" />'
                    +'</div></a></div>';
            var el = $(innerhtml);
            el.find(".file_del").bind('click',function(){
                var productId = $("#productId").val();
                var index = $(this).attr("data-index");
                console.log(imageId);
               $.post('/seller/delImage.action',{'id':productId,'page':imageId,'index':0},function (data) {
                   if(data=="success"){
                       el.remove();
                   }else{
                       alert("图片仅剩一张,无可删除的图片")
                   }
               })
            })
            el.bind({
                mouseenter: function(){
                    $(this).find(".file_bar").addClass("file_hover");
                },
                mouseleave: function(){
                    $(this).find(".file_bar").removeClass("file_hover");
                }
            })
            image++;
            $("#preview1").append(el);
        }
    }
</script>
</body>

</html>
