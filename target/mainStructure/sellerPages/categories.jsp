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

    <title>宅文体类别管理</title>

    <!-- Bootstrap Core CSS -->
    <link href="/asset/sellerAsset/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/asset/sellerAsset/css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/asset/sellerAsset/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/asset/sellerAsset/css/category.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<div id="wrapper">

    <!-- Navigation -->
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
                <li >
                    <a href="/seller/repertoryPage.action"><i class="fa fa-fw fa-wrench"></i> 库存查看</a>
                </li>
                <li class="active">
                    <a href="/seller/categoryPage.action"><i class="fa fa-fw fa-file"></i> 分类管理</a>
                </li>
            </ul>
        </div>
    </nav>
    <div id="page-wrapper">
        <div class="container-fluid" id="category-admin">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        类别管理
                    </h1>
                </div>
            </div>
            <section class="content">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>类别名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <s:iterator value="categories" var="category" status="index">
                    <tr id="<s:property value="#category.id"/>">
                        <td><s:property value="#index.index+1"/></td>
                        <td class="cName">
                            <s:property value="#category.name"/>
                        </td>
                        <input type="hidden" class="score" value="<s:property value="#category.score"/>"/>
                        <td>
                            <div class="btn-group btn-group-xs">
                                <button class="btn btn-danger delete" v-on="click:deleteRow">
                                    删除
                                </button>
                                <button class="btn btn-primary edit" v-on="click:editCategoryName">
                                    编辑
                                </button>
                            </div>
                        </td>
                    </tr>
                    </s:iterator>
                </table>
                <footer class="row">
                     共<span class="amount" v-text="cNum"> </span> 种分类
                    <div class="col-xs-2 pull-right">
                        <button class="btn btn-success btn-xs" v-on="click:addRow">
                            <span class="glyphicon glyphicon-plus"></span>
                            添加类别
                        </button>
                    </div>
                </footer>
                <hr>
                <p class="remark">
                    注：类别长度建议在4个字以内，类别个数最好不要超过10个。
                </p>
            </section>
        </div>

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
                <p>您确定要删除这一个类别嘛？删除之后该类书数据将永久删除！</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="del" class="btn btn-primary">确定</button>
            </div>
        </div>
    </div>
</div>
<!-- 类别编辑 -->
<div class="modal" id="editModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-2 control-label">类别名称</label>
                        <div class="col-sm-8">
                            <input type="text" maxlength="10" class="name form-control" id="categoryName" placeholder="请输入类别名称...">
                            <span id="helpBlock" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-2 control-label">优先级</label>
                        <div class="col-sm-8">
                            <select class="form-control" id="categoryScore">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="confirmEdit" class="btn btn-primary">确定</button>
            </div>
        </div>
    </div>
</div>
<script src="/asset/sellerAsset/js/jquery.js"></script>
<script src="/asset/sellerAsset/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/asset/sellerAsset/js/vue.min.js"></script>
<script src="/asset/sellerAsset/js/ajaxfileupload.js"></script>

</body>
<script type="text/javascript">
    $(function () {
        $("#changePic").click(function () {
            $("#bookImage").click();
        })
    })

    function imageChange(e) {

//        var productId = $("#productId").val();
//        $.ajaxFileUpload(
//                {
//                    url:'/seller/saveImage.action',
//                    data:{"id":productId},
//                    secureuri: false, //是否需要安全协议，一般设置为false
//                    fileElementId:'fileImage', //文件上传域的ID
//                    dataType:'html', //返回值类型 一般设置为json
//                    success: function (data, status)  //服务器成功响应处理函数
//                    {
//                        var reg = new RegExp("^[0-9]*$");
//                        if(reg.test(data.responseText)){
//                            $("#productId").val(data.responseText);
//                        }else if(data.responseText=="noLogin"){
////                                window.location.href="/seller/pendingOrderPage.action"
//                        }else{
//                            $("#imageE").show();
//                        }
//                    },
//                    error: function (data, status, e)//服务器响应失败处理函数
//                    {
//                        var reg = new RegExp("^[0-9]*$");
//                        if(reg.test(data.responseText)){
//                            $("#productId").val(data.responseText);
//                        }else if(data.responseText=="noLogin"){
//                            window.location.href="/seller/pendingOrderPage.action"
//                        }else{
//                            $("#imageE").show();
//                        }
//                    }
//                }
//        )

        var target = $(e.target);
        var reader = new FileReader();
        //将文件以二进制形式读入页面
        reader.readAsDataURL(e.target.files[0]);
        reader.onload=function(e){
            target.parent().siblings('img').attr('src',this.result);
        }
    }
</script>
<script type="text/javascript" src="/asset/sellerAsset/js/category.js"></script>
</html>

