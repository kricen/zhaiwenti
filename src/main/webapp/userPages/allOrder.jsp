<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>全部订单</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link href="/asset/user/css/bootstrap.min.css" rel="stylesheet">
    <link href="/asset/user/css/style.css" rel="stylesheet">
    <link href="/asset/user/css/alongsty.css" rel="stylesheet">
    <link href="/asset/user/css/iconfont/iconfont.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/asset/user/css/weui.min.css">
    <script src="/asset/user/js/jquery-2.1.4.min.js"></script>
    <style>
        [v-cloak] {
            display: none;
        }
    </style>

</head>

<body class="bgf7">
<div class="container">
    <div class='row'>
        <div class="col-xs-12 clearPadding mb50">
            <div class="myotitle bg-white clearfix">
                <div class="col-xs-3 clearPadding text-center pt10 pull-left"><span data-id="10" class="activeborder">全&nbsp;&nbsp;&nbsp;部</span></div>
                <div class="col-xs-3 clearPadding text-center pt10"><span data-id="-1" class="pb8">待付款</span></div>
                <div class="col-xs-3 clearPadding text-center pt10"><span data-id="9">进行中</span></div>
                <div class="col-xs-3 clearPadding text-center pt10 pull-right" ><span data-id="8">已完成</span></div>
            </div>
            <div id="ocontent" >
                <div class="myolist" v-for="order in orders" v-cloak>
                    <div class="myorderid clearfix plr15 borderbottom">
                        <h4 class="pull-left font12">
                            <span>订单号: {{order.id}}</span>
                        </h4>
                        <h4 class="pull-right font12">{{order.ordertime.toString()}} &nbsp;&nbsp;<i class="iconfont arrowdown" onclick="javascript:xiala(event)">&#xe60c;</i></h4>
                    </div>

                    <div class="myddetailbox" v-cloak>
                        <div class="myodetail clearfix" v-for="item in order.items">
                            <div class="col-xs-2 clearPadding proimg">
                                <img src="{{item.product.image}}" alt=""  data-img="" class="productImage" style="width:50px;height: 50px">
                            </div>
                            <div class="col-xs-8 ">
                                <div class="clearPadding proname plr10 ">
                                    {{item.product.name}}
                                </div>
                                <div class="clearPadding proname plr10 pt7 " style="color:#f0ad4e" >
                                    {{item.requirement}}
                                </div>

                            </div>
                            <div class="col-xs-2 clearPadding text-right">
                                <span class="colorred2">￥{{item.fee}}</span><br>
                                <span class="font12 text-muted">× {{item.num}}</span>
                            </div>
                        </div>
                        <div class="ptb10 plr15 text-muted font12 clearfix">
                            <div class="pull-left font12">
                                <span class="badge bg-dining" style="font-weight:normal;">
                                    <span onclick="xiadan({{order.id}})" v-if="order.state==-1"">去付款</span>
                                    <span v-if="order.state==0" >已下单</span>
                                    <span v-if="order.state==1">商家已接单</span>
                                    <span v-if="order.state==2">已完成</span>
                                    <span v-if="order.state==3">失败</span>
                                </span>
                                <span class="badge bg-red" onclick="cancelOrder({{order.id}})" v-if="order.state==-1">取消订单</span>
                            </div>
                            <div class="pull-right">
                                <span>共{{order.items.length}}件商品</span>&nbsp;&nbsp;合计：<span class="colorred2">￥{{order.totalFee}}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer navbar-fixed-bottom">
                    <div class="row ">
                        <div class="col-xs-3 text-center" style=" padding-top:5px;">
                            <a class="cgray" href="/user/index.action"><div class="photo_30"><img src="/asset/user/images/nav1.png"><br>首页</div></a>
                        </div>

                        <div class="col-xs-6  text-center" style=" padding-top:5px;">
                            <a class="cgray" href="/user/cartPage.action"><div class="photo_30"><img src="/asset/user/images/nav3.png"><br>购物车</div></a>
                        </div>
                        <div class="col-xs-3  text-center" style="padding-top:5px;">
                            <a class="cgreen" href="/user/orderPage.action"><div class="photo_30"><img src="/asset/user/images/nav44.png"><br>我的</div></a>
                        </div>
                    </div>
                </div><!-- footer -->
        </div>
    </div>
</div>
</div>

<div id="loadingToast" class="weui_loading_toast" style="display:none;">
    <div class="weui_mask_transparent"></div>
    <div class="weui_toast">
        <div class="weui_loading">
            <!-- :) -->
            <div class="weui_loading_leaf weui_loading_leaf_0"></div>
            <div class="weui_loading_leaf weui_loading_leaf_1"></div>
            <div class="weui_loading_leaf weui_loading_leaf_2"></div>
            <div class="weui_loading_leaf weui_loading_leaf_3"></div>
            <div class="weui_loading_leaf weui_loading_leaf_4"></div>
            <div class="weui_loading_leaf weui_loading_leaf_5"></div>
            <div class="weui_loading_leaf weui_loading_leaf_6"></div>
            <div class="weui_loading_leaf weui_loading_leaf_7"></div>
            <div class="weui_loading_leaf weui_loading_leaf_8"></div>
            <div class="weui_loading_leaf weui_loading_leaf_9"></div>
            <div class="weui_loading_leaf weui_loading_leaf_10"></div>
            <div class="weui_loading_leaf weui_loading_leaf_11"></div>
        </div>
        <p class="weui_toast_content">正在加载,请稍候...</p>
    </div>
</div>
<script src="/asset/user/js/jquery-2.1.4.min.js"></script>
<script src="/asset/main/js/vue.min.js"></script>

<script>
    $("#loadingToast").show();
    var p=1;
    var example2 = new Vue({
        el: '#ocontent',
        data: {
            orders: [

            ]
        },

    })
    $.post("/user/stateOrders.action",{"state":10,"page":1},function (data) {

        if(data==""){

        }else if(data=="noLogin"){
            window.location.href = "/user/login.action"
        }else{
            example2.$data.orders = data;
            stop = true;
            p++;
        }

    })
    $("#loadingToast").hide();
    $(".myotitle >div").on('click',function(){
        if(!$(this).find("span").hasClass("activeborder")){
            $(this).find("span").addClass("activeborder");
            $(this).siblings().find("span").removeClass("activeborder");
            p=1; var state =  $(this).find("span").attr("data-id");
            $.post("/user/stateOrders.action",{"state":state,"page":p},function (data) {
                if(data==""){
                    example2.$data.orders = null;
                }else if(data=="noLogin"){
                    window.location.href = "/user/login.action"
                }else{
                    example2.$data.orders = data;
                    p++;
                }
            })
        }

    });
    function xiala(event) {
       $(event.srcElement).parent().parent().siblings(".myddetailbox").slideToggle("slow");
    }
    function xiadan(id) {
        window.location.href="/user/orderInfoPage.action?id="+id;
    }
    function cancelOrder(id) {
        $.post("/user/deleteOrder.action",{"id":id},function (data) {
            console.log(data);
            if(data=="success"){
                alert("取消成功");
                window.location.reload();
            }
        })
    }
</script>
    <script type="text/javascript">

        //当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
        //        $('img.lazy').lazyload();

        var visable = true;
        var state = 10;
        var stop=true;//触发开关，防止多次调用事件
        $(window).scroll(function() {
            //当内容滚动到底部时加载新的内容 100当距离最底部100个像素时开始加载.
            if ($(this).scrollTop() + $(window).height() + 100 >= $(document).height() && $(this).scrollTop()> 100) {
                if(stop==true){
                    stop = false;
                    $.post("/user/stateOrders.action",{"state":state,"page":p},function (data) {
                        p++;

                        if(data==""){

                        }else if(data=="noLogin"){
                            window.location.href = "/user/login.action"
                        }else{
                            example2.$data.orders = example2.$data.orders.concat(data);
                            stop = true;
                        }
                    })

                }
//
            }
        });
        $(function () {
            $(window).scroll(function () {
                if( $(this).scrollTop() + $(window).height() >= $(document).height() && $(this).scrollTop()> 100&&visable){

                }

            });

        });

    </script>
</body>
</html>
