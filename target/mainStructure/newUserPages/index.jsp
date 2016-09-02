<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="no-js">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1,user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <!-- 启用360浏览器的极速模式(webkit) -->
    <meta name="renderer" content="webkit">
    <!-- 避免IE使用兼容模式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
    <!-- 适应移动端end -->
    <title>宅文体</title>
    <link rel="stylesheet" href="/asset/newUser/css/frameui.css"/>
    <link rel="stylesheet" href="/asset/newUser/css/widget/slider.css"/>
    <link rel="stylesheet" href="/asset/newUser/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="/asset/newUser/css/list.css">
</head>
<body>
<!--html5 nav-->
<nav class="j-nav navbar index-nav" >

    <div class="city">
        <a id="showSiteBtn" href="/user/selectSchool.action" target="_self"><s:property value="school.name"/></a>
        <input id="switchGPS" name="switchGPS" type="hidden">
    </div>
</nav>
<!--a1轮播图-->
<div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{"directionNav":false}' >
    <ul class="am-slides cl">
        <li>
            <img src="/images/wenti2.jpg">
        </li>
        <li>
            <img src="/images/wenti1.jpg">
        </li>
    </ul>
</div>
<div class="j-hint">二十元免运费</div>
<!--导航-->
<div class="j-component-func" id="m-banner">
    <ul class="list-unstyled" id="categoryMenu">
        <li class="route1 "><a href="/user/categoryList.action?id=10"><span class="glyphicon fdayicon fdayicon-all">健</span>健身餐</a></li>
        <li class="route2 "><a href="/user/categoryList.action?id=11"><span class="glyphicon fdayicon fdayicon-order">营</span>营养餐</a></li>
        <li class="route3 "><a href="/user/categoryList.action?id=12"><span class="glyphicon fdayicon fdayicon-contact">果</span>水果拼盘</a></li>
    </ul>
</div>
<!--内容-->
<div class="j-component-bestsell">
    <ul class="list-unstyled">
        <li><a href="javascript:void(0);"><img class="lazy" src="/images/wenti3.jpg"></a></li>
    </ul>
</div>
<div class="list-pic">
    <ul>
        <s:iterator value="products" var="product">
        <li>
            <a href="/user/productDetail.action?id=<s:property value="#product.id"/>">
                <div class="pic"><img src="<s:property value="#product.headImage.image"/>" width="100%"></div>
                <div class="neirong">
                    <div class="biao"><img src="/images/biao-rm.png" width="100%" height="100%"></div>
                    <h3 class="dbt"><s:property value="#product.name"/></h3>
                    <p class="xzsm"><s:property value="#product.comments"/></p>
                    <p class="jiage"><span class="bold">￥</span><span class="jgsz"><s:property value="#product.price"/></span></p>
                </div>
          </a>
        </li>
        </s:iterator>
    </ul>
</div>
<!--footer begin-->
<footer class="footer">
    <div class="nav-item nav-item-1 nav-item-home">  <a class="footer-menu" href="/user/index.action"> <i class="arrow-weixin"></i> <span class="footer-menu-text">首页</span> </a></div>
    <div class="nav-item nav-item-2"> <a class="footer-menu" href="javascript:window.location.href='tel:18068616580'"> <i class="arrow-weixin"></i> <span class="footer-menu-text">联系商家</span> </a></div>
    <div class="nav-item nav-item-3"> <a class="footer-menu" href="/user/cartPage.action"> <i class="arrow-weixin"></i> <span class="footer-menu-text">我的购物车</span> </a></div>
    <div class="nav-item nav-item-4"> <a class="footer-menu" href="/user/orderPage.action"> <span class="footer-menu-text">我的订单</span> </a> </div>
</footer>
<!--footer end-->

<!--引入js资源-->
<script src="/asset/main/js/jquery_min1_11_2.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="/asset/newUser/js/handlebars.min.js"></script>
<script src="/asset/newUser/js/amazeui.widgets.helper.js"></script>
<script type="text/javascript">
    window.onload=function(){
        $("#categoryMenu li").addClass("route")
    }
</script>
</body>
</html>