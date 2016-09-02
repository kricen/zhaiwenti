<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <!-- 声明文档使用的字符编码 -->
    <meta charset='utf-8'>
    <!-- 优先使用 IE 最新版本和 Chrome -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <!-- 页面描述 -->
    <meta name="description" content="不超过150个字符"/>
    <!-- 页面关键词 -->
    <meta name="keywords" content=""/>
    <!-- 网页作者 -->
    <meta name="author" content="guo,1057540638@qq.com"/>
    <!-- 搜索引擎抓取 -->
    <meta name="robots" content="index,follow"/>
    <!-- 为移动设备添加 viewport -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=3,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />
    <!-- `width=device-width` 会导致 iPhone 5 添加到主屏后以 WebApp 全屏模式打开页面时出现黑边 http://bigc.at/ios-webapp-viewport-meta.orz -->

    <!-- iOS 设备 begin -->
    <meta name="apple-mobile-web-app-title" content="标题">
    <!-- 添加到主屏后的标题（iOS 6 新增） -->
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <!-- 是否启用 WebApp 全屏模式，删除苹果默认的工具栏和菜单栏 -->

    <!--meta name="apple-itunes-app" content="app-id=myAppStoreID, affiliate-data=myAffiliateData, app-argument=myURL" -->
    <!-- 添加智能 App 广告条 Smart App Banner（iOS 6+ Safari） -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <!-- 设置苹果工具栏颜色 -->
    <meta name="format-detection" content="telphone=no, email=no"/>
    <!-- 忽略页面中的数字识别为电话，忽略email识别 -->

    <!-- 启用360浏览器的极速模式(webkit) -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 不让百度转码 -->
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!-- 针对手持设备优化，主要是针对一些老的不识别viewport的浏览器，比如黑莓 -->
    <meta name="HandheldFriendly" content="true">
    <!-- 微软的老式浏览器 -->
    <meta name="MobileOptimized" content="320">
    <!-- uc强制竖屏 -->
    <meta name="screen-orientation" content="portrait">
    <!-- QQ强制竖屏 -->
    <meta name="x5-orientation" content="portrait">
    <!-- UC强制全屏 -->
    <meta name="full-screen" content="yes">
    <!-- QQ强制全屏 -->
    <meta name="x5-fullscreen" content="true">
    <!-- UC应用模式 -->
    <meta name="browsermode" content="application">
    <!-- QQ应用模式 -->
    <meta name="x5-page-mode" content="app">
    <!-- windows phone 点击无高光 -->
    <meta name="msapplication-tap-highlight" content="no">
    <!-- iOS 图标 begin -->
    <!-- Retina iPad，144x144 像素，可以没有，但推荐有 -->
    <!-- iOS 图标 end -->

    <!-- iOS 设备 end -->
    <meta name="msapplication-TileColor" content="#000"/>
    <!-- Windows 8 磁贴颜色 -->
    <meta name="msapplication-TileImage" content="icon.png"/>
    <!-- Windows 8 磁贴图标 -->

    <link rel="alternate" type="application/rss+xml" title="RSS" href="/rss.xml"/>
    <!-- 添加 RSS 订阅 -->
    <link rel="shortcut icon" type="image/ico" href="/favicon.ico"/>
    <title>我的订单</title>
    <link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css">
    <link rel="stylesheet" href="/asset/newUser/css/newOrder.css">
    <link rel="stylesheet" href="/asset/newUser/css/responsive.css">
    <link rel="stylesheet" href="/asset/newUser/css/refresh.css">
</head>

<body ontouchstart="return true;">
<!--头部-->
<header>
    <div class="header">
        <h1>我的订单</h1>
        <a href="javascript:window.history.go(-1)" style="margin-top: -5px" class="return"><i></i></a>
        <a href="/user/index.action" class="return1"> <span data-type="icon" style="color: white;font-size: 30px" class="btn  am-icon-home " ></span></a>
    </div>
</header>
<input type="hidden" value="8" id="orderState">
<!--内容区-->
<article class="main-container" id="vueRoot">
    <!--选项卡-->
    <nav class="memberOrder-nav line"><a href="#"  data-category="8" class="line orderstate select">全部</a><a href="#"  data-category="-1"  class="line orderstate">待付款</a><a href="#"  data-category="5"  class="line orderstate">进行中</a><a  data-category="7" class="line orderstate"  href="#">已完成</a></nav>
    <div class="memberOrder-header"></div>
    <!--列表-->
    <s:iterator value="orders" var="order">
        <div class="memberOrder-list line initdata" onclick="location.href='/user/orderDetailPage.action?id=<s:property value="#order.id"/>'">
            <p>订单编号：<s:property value="#order.id"></s:property> <span style="float: right"><s:property value="#order.sellerName"/> </span>
                <span>
                    <s:if test="#order.state==-1">（待付款）</s:if>
                    <s:if test="#order.state==0">（已付款）</s:if>
                    <s:if test="#order.state==1">（已接收）</s:if>
                    <s:if test="#order.state==2">（订单成功）</s:if>
                    <s:if test="#order.state==3">（（订单失败）</s:if>
                </span>
            </p>
            <div class="order-product line">
                <ul>
                    <li><s:iterator value="#order.images" var="image"> <img src="<s:property value="#image"/>" style="height: 60px;width: 60px" alt=""></s:iterator></li>
                </ul>
            </div>
            <p >共<span><s:property value="#order.num"/></span>件，总价：<span>￥<s:property value="#order.fee"/></span><button>查看详情</button></p>
        </div>
    </s:iterator>
    <template v-for="order in vueorder">
        <div class="memberOrder-list line" onclick="location.href='/user/orderDetailPage.action?id={{order.id}}'">
            <p>订单编号：{{order.id}}<span style="float: right">{{order.sellerName}}</span>
                <span v-if="order.state==-1">（待付款）</span>
                <span v-if="order.state==0">（已付款）</span>
                <span v-if="order.state==1">（已接收）</span>
                <span v-if="order.state==2">（订单成功）</span>
                <span v-if="order.state==3">（订单失败）</span>
            </p>
            <div class="order-product line">
                <ul>
                    <li>
                        <template v-for="image in order.images">
                            <img src="{{image}}" style="height: 100px;width: 80px" alt="">
                        </template>

                    </li>
                </ul>
            </div>
            <p >共<span>{{order.num}}</span>件，总价：<span>￥{{order.fee}}</span><button>查看详情</button></p>
        </div>
    </template>
</article>
<div id="wrapper" data-am-widget="list_news" class="am-list-news am-list-news-default">
    <span id="flash-finsh" class=" pull-label" style="display: none;font-size: 1rem"> 加载完成</span>
    <span id="flashing" class="content-loading" style="font-size: 1rem"><i class="am-icon-spinner am-icon-spin"></i>   加载中...</span>
</div>
</body>
</html>
<script type="text/javascript" src="/asset/main/js/jquery_min1_11_2.js"></script>
<script type="text/javascript" src="/asset/newUser/js/swiper3.1.0.min.js"></script>
<script type="text/javascript" src="/asset/main/js/vue.min.js"></script>
<script type="text/javascript" src="/asset/newUser/js/newOrder.js"></script>

<script type="text/javascript">
    if($(".initdata").size()<=10){
        $("#flash-finsh").hide();
        $("#flashing").hide();
    }
    var selectedState = $('#orderState').val().trim();
    var p=2;
    $(function () {
        var vueOrders = new Vue({
            el: '#vueRoot',
            data: {
                vueorder: [

                ]
            }
        })

        $('.orderstate').click(function () {
            var selectState = $(this).attr('data-category').trim()
            console.log(selectedState==selectState)
            if(selectedState==selectState){
                return;
            }
            $(".orderstate").removeClass('select');
            $(this).addClass('select');
            p=1;
            $('.initdata').remove();
            selectedState = selectState;
            $("#flashing").show();
            $("#flash-finsh").hide();
            $.post("/user/jsonOrders.action",{"page":p,'state':selectedState},function (data) {
                p++;
                if(data==""){
                    vueOrders.$data.vueorder = '';
                    $("#flashing").hide();
                    $("#flash-finsh").hide();


                }else if(data=="noLogin"){
                    window.location.href = "/user/login.action"
                }else{

                    vueOrders.$data.vueorder =  data;
                    if(data.length<10){
                        $("#flashing").hide();
                        $("#flash-finsh").show();
                    }
                    stop = true;
                }
            })

        });
        var stop=true;//触发开关，防止多次调用事件
        $(window).scroll(function() {
            //当内容滚动到底部时加载新的内容 100当距离最底部100个像素时开始加载.
            if ($(this).scrollTop() + $(window).height() + 100 >= $(document).height() && $(this).scrollTop()> 100) {
                if(stop==true){
                    stop = false;
                    $.post("/user/jsonOrders.action",{"page":p,'state':selectedState},function (data) {
                        p++;
                        if(data==""){
                            $("#flashing").hide();
                            $("#flash-finsh").show();


                        }else if(data=="noLogin"){
                            window.location.href = "/user/login.action"
                        }else{
                            vueOrders.$data.vueorder =  vueOrders.$data.vueorder.concat(data)
                            stop = true;
                        }
                    })
                }
//
            }

        });

    })
</script>


