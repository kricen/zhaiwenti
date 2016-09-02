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
    <title>水果拼团网站</title>
    <link rel="stylesheet" href="/asset/newUser/css/index.css"/>
    <link rel="stylesheet" href="/asset/newUser/css/common.css"/>
</head>
<body>
<div id="user-b" class="od-box">
    <!--html5 nav-->
    <nav class="j-nav navbar">
        <div class="logo fl">
            <a href="/user/orderPage.action"></a>
        </div>
        <span class="user-title">订单详情</span>
        <%--<div class="nav-item-home fr">--%>
            <%--<a href="/user/index.action"></a>--%>
        <%--</div>--%>
    </nav>
    <div class="od-details">
        <!-- 订单进度，生效追加样式“-cur”即可 -->
        <div class="od-express">
            <ul>
                <li class="place <s:if test="order.state==0">place-cur</s:if> ">
                    提交订单
                </li>
                <li class="delivery <s:if test="order.state==1">place-cur</s:if>">
                    配送中
                </li>
                <li class="sign <s:if test="order.state==2||order.state==3">place-cur</s:if>">
                    成功
                </li>
            </ul>
        </div>
    </div>
    <!-- 订单信息 -->
    <div class="od-infor">
        <table cellpadding="1" cellspacing="0">
            <tr>
                <td width="80px;">订单状态:</td>
                <td class="od-red">
                    <s:if test="order.state==-1">待付款</s:if>
                    <s:if test="order.state==0">已付款</s:if>
                    <s:if test="order.state==1">已接收</s:if>
                    <s:if test="order.state==2">成功</s:if>
                    <s:if test="order.state==3">失败</s:if>
                </td>
            </tr>
            <tr>
                <td>总额:</td>
                <td class="od-red"><s:property value="order.totalFee"/> <span>(微信支付)</span></td>
            </tr>
            <tr>
                <td>送至:</td>
                <td><s:property value="order.addr"/></td>
            </tr>
            <tr>
                <td>收货人:</td>
                <td><s:property value="order.name"/> <s:property value="order.tel"/></td>
            </tr>
            <tr>
                <td>下单时间:</td>
                <td><s:property value="order.strDate"/></td>
            </tr>
        </table>
    </div>
    <!-- 商品详情 -->
    <h4>商品详情</h4>
    <s:iterator value="order.orderitems" var="orderitem">
    <div class="mc-sum-box">
        <div class="myorder-sum fl"><img src="<s:property value="#orderitem.product.headImage.image"/>"></div>
        <div class="myorder-text">
            <h1><s:property value="#orderitem.product.name"/> </h1>
            <h2><s:property value="#orderitem.product.comments"/></h2>
            <div class="myorder-cost">
                <span>数量:<s:property value="#orderitem.num"/></span>
                <span class="mc-t">￥<s:property value="#orderitem.productFee"/></span>
            </div>
        </div>
    </div>
    </s:iterator>

    <div class="memberDetailFooter line" id="content">
        <s:if test="model.state==-1">
            <button id="payNow">去支付</button><button id="cancalOrder">取消订单</button>
        </s:if>
        <button id="call" style="margin-left: -.3rem" data-tel="<s:property value="model.seller.tel"/>">联系商家</button>
    </div>
    <!--footer begin-->
    <!--footer begin-->
    <!--footer end-->
    <!--footer end-->
</div>

<script src="/asset/main/js/jquery-1.10.2.min.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="/asset/newUser/js/handlebars.min.js"></script>
<script src="/asset/newUser/js/amazeui.widgets.helper.js"></script>
<script src="/asset/newUser/js/alertPopShow.js"></script>
<script type="text/javascript">
    var orderNo = <s:property value="model.id"/>;
    $("#call").hammer().on('tap', function(e) {
        window.location.href = "tel:" + $(e.target).data('tel');
    });
    $("#payNow").hammer().on('tap', function(e) {
        $.post('/user/rePay.action',{'id':orderNo},function (data) {
            if(!isNaN(data)){
                window.location.href = "/user/payPage.action?id="+data;
            }else {
                setTimeout(function() {
                    webToast("未知的错误","bottom", 1100);
                }, 300)
            }

        })

    });
    $("#cancalOrder").hammer().on('tap', function(e) {
        var like=window.confirm("确认取消订单吗?");
        console.log(like)
        var url = '/user/cancelOrder.dhtml';
        var args= {"id":orderNo};
        if(like){
            $.post(url,args, function (data) {
                if(data=="success"){
                    window.location.href = "/user/orderPage.action"
                }else {
                    setTimeout(function() {
                        webToast("未知的错误","bottom", 1100);
                    }, 300)
                }
            })

        }
    });
</script>
</body>
</html>
