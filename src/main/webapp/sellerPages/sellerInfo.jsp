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

    <title>宅文体商家中心</title>
    <!-- Bootstrap Core CSS -->
    <link href="/asset/sellerAssets/sellerBack/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/asset/sellerAssets/sellerBack/css/sb-admin.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="/asset/sellerAssets/sellerBack/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/asset/sellerAssets/sellerBack/css/myInfo.css">
    <link rel="shortcut icon" type="image/x-icon" href="/images/goushubao.ico" media="screen" />
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
            <a class="navbar-brand" href="/seller/index.dhtml"><s:property value="#session.seller.name"/> </a>
        </div>
        <!-- Top Menu Items -->
        <ul class="nav navbar-right top-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <s:property value="#session.seller.username"/> <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="/seller/getSellerDetail.dhtml" class="switchModel" data-target="seller-info"><i class="fa fa-fw fa-user" ></i> 我的信息</a>
                    </li>
                    <li>
                        <s:url value="/seller/changePasswordPage.action" var="changePassword"></s:url>
                        <a href="<s:property value="#changePassword"/> "><i class="fa fa-fw fa-gear"></i> 修改密码</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/seller/exit.dhtml"><i class="fa fa-fw fa-power-off"></i> 退出</a>
                    </li>
                </ul>
            </li>
        </ul>
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
                <li class="active">
                    <a href="/seller/retailPage.dhtml"><i class="fa fa-fw fa-dashboard"></i> 线下零售</a>
                </li>
                <li>
                    <a href="/seller/pendingOrder.dhtml"><i class="fa fa-fw fa-bar-chart-o"></i> 待处理订单</a>
                </li>
                <li>
                    <a href="/seller/acceptOrder.dhtml"><i class="fa fa-fw fa-table"></i> 已接受订单</a>
                </li>
                <li>
                    <a href="/seller/completOrder.dhtml"><i class="fa fa-fw fa-edit"></i> 已完成订单</a>
                </li>
                <li >
                    <a href="/seller/pendingNewbookOrderPage.dhtml"><i class="fa fa-fw fa-maxcdn"></i>待处理新书</a>
                </li>
                <li>
                    <a href="/seller/uploadSBookPage.dhtml"><i class="fa fa-fw fa-desktop"></i> 上传图书</a>
                </li>
                <li>
                    <a href="/seller/bookRepertory.dhtml"><i class="fa fa-fw fa-wrench"></i> 库存查看</a>
                </li>
                <li>
                    <a href="/seller/categoriesPage.dhtml"><i class="fa fa-fw fa-file"></i> 分类管理</a>
                </li>
                <li>
                    <a href="/seller/offlineSalesRecord.dhtml"><i class="fa fa-fw fa-fighter-jet "></i> 线下零售记录</a>
                </li>
                <li>
                    <a href="/seller/sellerExchange.dhtml"><i class="fa fa-fw fa-book"></i>仓库补货</a>
                </li>
                <li>
                    <a href="/seller/financePage.dhtml"><i class="fa fa-fw fa-maxcdn"></i>销售统计</a>
                </li>
            </ul>
        </div>
    </nav>

    <div id="page-wrapper">
        <input type="hidden" id="username" value="<s:property value="seller.username"/>">
        <input type="hidden" id="name" value="<s:property value="seller.name"/>">
        <input type="hidden" id="addr" value="<s:property value="seller.addr"/>">
        <div class="container-fluid" id="seller-info">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        商家信息
                    </h1>
                </div>
            </div>
            <section class="content">
                <div class="left-col form-horizontal pull-left">
                    <div class="form-group">
                        <label for="name"  class="col-sm-3 control-label">店铺名称</label>
                        <div id="seller-name" class="col-sm-9">
                            <template v-if="modify==true">
                            <input v-model="name" type="text" class="form-control">
                        </template>
                            <template v-if="modify==false">
                                <p class="name" v-text="name"><s:property value="seller.name"/> </p>
                            </template>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-label">详细地址</label>
                        <div id="seller-addr" class="col-sm-9">
                            <template v-if="modify==true">
                                <input type="text" v-model="addr" class="form-control">
                            </template>
                            <template v-if="modify==false">
                                <p class="name" v-text="addr">新华书店</p>
                            </template>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-label">店主姓名</label>
                        <div id="seller-username" class="col-sm-9">
                            <template v-if="modify==true">
                                <input type="text" v-model="username" class="form-control">
                            </template>
                            <template v-if="modify==false">
                                <p class="username"><s:property value="seller.username"/></p>
                            </template>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-label">手机号码</label>
                        <div class="col-sm-4">
                            <p class="tel"><s:property value="seller.tel"/></p>
                        </div>
                        <div class="col-sm-5 editPhoneNum">
                            <a href="#" data-toggle="modal" data-target="#changePhoneNum">
                                <span class="glyphicon glyphicon-edit"></span> 修改手机号码
                            </a>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-label">所在城市</label>
                        <div class="col-sm-9">
                            <p class="city"><s:property value="school.serviceArea.city.name"/> </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-label">服务范围</label>
                        <div class="col-sm-9">
                            <p class="serviceArea"><s:property value="school.serviceArea.name"/> </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-label">主营学校</label>
                        <div class="col-sm-9">
                            <p class="school"><s:property value="school.name"/> </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <button id="editSellerInfo" v-on="click:edit" class="btn btn-primary form-control" data-loading-text="正在修改...">修改</button>
                        </div>
                    </div>
                </div>

                <div class="right-col pull-right">
                    <img class="img-thumbnail" src="<s:property value="seller.headImage"/>">
                    <input type="file" accept="image/*" style="display:none" v-on="change:pictureChangeHandle">
                </div>
                <div style="clear:both"></div>
                <hr>
                <p class="remark">
                    注：所在城市、服务范围、运营学校一经确定，不能再修改。
                </p>
            </section>
        </div>
    </div>
    <!-- 图片修改 -->
    <div class="modal" id="changeImg">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">图片修改</h4>
                </div>
                <div class="modal-body">
                    <center><img class="imageShow" v-attr="src:imgSrc"></center>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" v-on="click:changePic">选择图片</button>
                    <button type="button" v-on="click:confirm" id="del" class="btn btn-primary">确定</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="changePhoneNum" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">手机号码变更</h4>
                </div>
                <div class="modal-body" style="padding-bottom:0">
                    <div class="form-horizontal">
                        <div class="form-group newTelFg">
                            <label class="col-sm-3 control-label" for="tel">新号码</label>
                            <div class="col-sm-8">
                                <input id="tel" autofocus type="number" maxlength="11" class="form-control">
                            </div>
                        </div>
                        <div class="form-group codeFg">
                            <label class="col-sm-3 control-label" for="checkcode">验证码</label>
                            <div class="col-sm-8">
                                <div class="row">
                                    <div class="col-sm-7">
                                        <input id="checkcode" type="number" maxlength="6" class="form-control">
                                    </div>
                                    <div class="col-sm-4" style="padding-left:0">
                                        <button id="getCheckCode" class="btn btn-success">获取验证码</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <form class="form-horizontal">
                        <div class="row">
                            <div class="col-sm-6 col-sm-offset-3">
                                <a id="submitCode" disabled class="btn btn-primary form-control"> 提交 </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/asset/sellerAssets/sellerBack/js/jquery.js"></script>
<script src="/asset/sellerAssets/sellerBack/js/bootstrap.min.js"></script>
<script src="http://cdn.bootcss.com/vue/0.12.16/vue.min.js"></script>
<script type="text/javascript" src="/asset/sellerAssets/sellerBack/js/myInfo.js"></script>
</body>

</html>
