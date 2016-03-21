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

    <title>SB Admin - Bootstrap Admin Template</title>
    <link rel="shortcut icon" type="image/x-icon" href="/images/goushubao.ico" media="screen" />
    <!-- Bootstrap Core CSS -->
    <link href="/asset/sellerAssets/sellerBack/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/asset/sellerAssets/sellerBack/css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/asset/sellerAssets/sellerBack/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/asset/sellerAssets/sellerBack/css/completedOrders.css">
    <link rel="stylesheet" type="text/css" href="/asset/sellerAssets/css/animate.css">
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
                <li>
                    <a href="/seller/retailPage.dhtml"><i class="fa fa-fw fa-dashboard"></i> 线下零售</a>
                </li>
                <li>
                    <a href="/seller/pendingOrder.dhtml"><i class="fa fa-fw fa-bar-chart-o"></i> 待处理订单</a>
                </li>
                <li>
                    <a href="/seller/acceptOrder.dhtml"><i class="fa fa-fw fa-table"></i> 已接受订单</a>
                </li>
                <li class="active">
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
        <div class="container-fluid" id="orderShow">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        已完成订单
                    </h1>
                </div>
            </div>
            <form action="/seller/orderSearch.dhtml" method="post">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="input-group">
                            <input type="text" name="phone" class="form-control" placeholder="请输入用户手机号...">
                            <input type="hidden" name="state" value="10">
                        <span class="input-group-btn">
                             <button type="submit" class="btn btn-default">
                                 <span class="glyphicon glyphicon-search"></span>
                                 订单查找</button>
                        </span>
                        </div>
                    </div>
                </div>
            </form>
            <table class="table table-bordered table-hover">
                <thead>
                <th>订单号</th>
                <th>完成时间</th>
                <th>收货地址</th>
                <th>付款方式</th>
                <th>交易结果</th>
                <th>操作</th>
                </thead>
                <tbody>
                <s:iterator value="pageBean.list" var="order" status="index">
                    <tr id="<s:property value="#order.id"/>">
                        <td><s:property value="#order.id"/></td>
                        <td><s:property value="#order.date"/></td>
                        <td class="address"><s:property value="#order.orderAddr.addr"/></td>
                        <s:if test="#order.payWay==0">
                            <td class="payWay cash">货到付款</td>
                        </s:if>
                        <s:elseif test="#order.payWay==1">
                            <td class="payWay alipay">支付宝支付</td>
                        </s:elseif>
                        <s:else >
                            <td class="payWay wechat">微信支付</td>
                        </s:else>
                        <s:if test="#order.state==3">
                            <td class="iconfont fail"> &#xe606;</td>
                        </s:if>
                        <s:else>
                            <td class="iconfont succe">&#xe605;</td>
                        </s:else>
                        <td>
                                <button class="btn btn-xs btn-primary">查看订单</button>
                        </td>
                    </tr>
                </s:iterator>
                </tbody>
            </table>
            <nav>
                <ul class="pagination pagination-sm">
                    <s:url value="/seller/completOrder.action" var="bookRepertory"></s:url>
                    <s:if test="pageBean.page!=pageBean.startIndex">
                        <li>
                            <a href="<s:property value="#bookRepertory"/>?page=1" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </s:if>


                    <s:if test="pageBean.page!=pageBean.startIndex||pageBean.page!=pageBean.endIndex">
                        <s:iterator var="i" begin="pageBean.startIndex" end="pageBean.endIndex">
                            <s:if test="pageBean.page==#i">
                                <li class="active">
                                    <span aria-hidden="true"><s:property value="#i"/></span>
                                </li>
                            </s:if>
                            <s:else>
                                <li>
                                    <a href="<s:property value="#bookRepertory"/>?page=<s:property value="#i"/>" aria-label="Previous">
                                        <span aria-hidden="true"><s:property value="#i"/></span>
                                    </a>
                                </li>
                            </s:else>
                        </s:iterator>
                    </s:if>

                    <s:if test="pageBean.page!=pageBean.endIndex">
                        <li>
                            <a href="<s:property value="#bookRepertory"/>?page=<s:property value="pageBean.totalPage" />" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </s:if>
                </ul>
                <ul class="info">
                    <li class="pages"><s:property value="pageBean.totalPage"/></li>
                    <li class="orders"><s:property value="pageBean.totalCount"/></li>
                </ul>
            </nav>
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
                <p>您确定要删除这一个订单嘛？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="del" class="btn btn-primary">确定</button>
            </div>
        </div>
    </div>
</div>
<!-- 订单详情弹框 -->
<div class="modal" id="orderInfo">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <h4 class="modal-title">订单详情</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid" id="orderShow">
                    <h3 class="orderHead">
                        <ul class="bottomInfo">
                            <li>
                                <label>收货人：</label><span v-text="name"></span>
                            </li>
                            <li>
                                <label>手机号码：</label><span v-text="tel"></span>
                            </li>
                            <li>
                                <label>收货地址：</label><span v-text="addr"></span>
                            </li>
                        </ul>
                    </h3>
                    <table class="table table-strip table-hover detail">
                        <thead>
                        <tr>
                            <th>图片</th>
                            <th>书名</th>
                            <th>出版社</th>
                            <th>ISBN</th>
                            <th>价格</th>
                            <th>数量</th>
                        </tr>
                        </thead>
                        <tr v-repeat="book in books">
                            <td>
                                <img class="bookPic" v-attr="src:book.bigImage">
                            </td>
                            <td v-text="book.title"></td>
                            <td v-text="book.publisher"></td>
                            <td v-text="book.isbn"></td>
                            <td class="price" v-text="book.price"></td>
                            <td v-text="book.num"></td>
                        </tr>
                    </table>
                    <hr>
                    <h3 class="orderHead" style="margin-top:-14px">
                        <ul class="bottomInfo">
                            <li>
                                <label>备注：</label><span v-text="remark"></span>
                            </li>
                            <li class="orderedTime" v-text="date"></li>
                        </ul>
                    </h3>
                    <div id="orderFooter">
                        <ul style="margin-top:0">
                            <li>
                                <label>共计<span class="amount" v-text="num"></span>本</label>
                            </li>
                            <li>
                                <label>总价：</label><span class="totalPrice" v-text="'¥'+price"></span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary"  data-dismiss="modal">我知道了</button>
            </div>
        </div>
    </div>
</div>
<script src="/asset/sellerAssets/sellerBack/js/jquery.js"></script>
<script src="/asset/sellerAssets/sellerBack/js/bootstrap.min.js"></script>
<script src="http://cdn.bootcss.com/vue/0.12.16/vue.min.js"></script>
<script type="text/javascript">
    //查看订单详情  绑定vue对象
    var orderInfo = new Vue({
        el:'#orderInfo',
        data:{
            name:'',
            tel:'',
            addr:'',
            date:'',
            num:'',
            remark:'',
            price:'',
            books:[]
        }
    })
    //查看订单交互
    $("tbody").on('click','.btn-primary',function(e){
        var orderId = $(this).parents('tr').attr('id');
        var $btn = $(this).button('loading')
        $.post("/seller/orderInfo.dhtml",{"id":orderId},function(data){
            data = JSON.parse(data);
            if(data=="noLogin"){
                window.location.href = "/seller/loginPage.dhtml"
            }else{
                $btn.button('reset')
                for(var key in data){
                    orderInfo.$data[key] = data[key];
                }
            }
        })
        $("#orderInfo").modal('show');
        setTimeout(function(){
            var images = $(".bookPic");
            for(var i = 0 ; i<images.length;i++){
                $(images[i]).popover({
                    html:true,
                    content:'<img class="largeImg" src="'+orderInfo.$data.books[i].bigImage+'">',
                    trigger:'hover'
                });
            }
        },1000);

    })
    //手机号码校验函数
    function isPhone(aPhone) {
        var bValidate = RegExp(/^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$/).test(aPhone);
        if (bValidate) {
            return true;
        } else
            return false;
    }

</script>
</body>

</html>

