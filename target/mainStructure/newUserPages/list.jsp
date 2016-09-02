<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>宅文体</title>
    <link rel="stylesheet" type="text/css" href="/asset/newUser/css/list.css">
</head>
<body class="bj-hui">
<header>
    <div class="header">
        <h1>商品列表</h1>
        <a href="javascript:window.history.go(-1)" class="return"><i></i></a>
    </div>
</header>
<div class="list-pic" style="margin-top: 40px">
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
<footer class="footer">
    <div class="nav-item nav-item-1 nav-item-home">  <a class="footer-menu" href="/user/index.action"> <i class="arrow-weixin"></i> <span class="footer-menu-text">首页</span> </a></div>
    <div class="nav-item nav-item-2"> <a class="footer-menu" href="javascript:window.location.href='tel:18068616580'"> <i class="arrow-weixin"></i> <span class="footer-menu-text">联系商家</span> </a></div>
    <div class="nav-item nav-item-3"> <a class="footer-menu" href="/user/cartPage.action"> <i class="arrow-weixin"></i> <span class="footer-menu-text">我的购物车</span> </a></div>
    <div class="nav-item nav-item-4"> <a class="footer-menu" href="/user/orderPage.action"> <span class="footer-menu-text">我的订单</span> </a> </div>
</footer>
</body>
</html>

