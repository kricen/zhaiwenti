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
    <link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css">
    <link rel="stylesheet" href="/asset/newUser/css/widget/slider.css"/>
    <link rel="stylesheet" href="/asset/newUser/css/index.css"/>
    <link rel="stylesheet" href="/asset/newUser/css/common.css"/>
</head>
<body>
<div class="btngroup">
    <span data-type="icon" class="btn  am-icon-home " ></span>
    <span data-type="icon" class="btn am-icon-shopping-cart " ></span>
</div>
<!--a1轮播图-->
<div data-am-widget="slider"  class="am-slider am-slider-a1" data-am-slider='{"directionNav":false}' >
    <ul class="am-slides cl">
        <s:iterator value="lunboImages" var="lunbo">
        <li>
            <img src="<s:property value="#lunbo.image"/>">
        </li>
        </s:iterator>
    </ul>
</div>
<!--介绍-->
<div class="details-body-box">
    <div class="tm">
        <div class="td2">
            <div class="td2_price"><span>已售：<b><s:property value="product.sellNum"/></b></span></div>
            <div class="cl"></div>
            <div class="td2_name"> 越南进口白肉火龙果 </div>
            <div class="td2_cx">外皮红艳，果肉绵软白嫩，汁液丰富，富含维生素C.</div>
        </div>
    </div>
    <div class="outs-box">
        <h1>商品详情</h1>
        <s:iterator value="detailImages" var="detail">
        <img src="<s:property value="#detail.image"/>">
        </s:iterator>
    </div>
</div>

<!--detail_footer begin-->
<footer class="detail_footer">
    <div class="return_left_box">
        <a href="index.html"><div class="return_home fl"></div></a>
        <a href="javascript:void(0);"><div class="return_home share_tuan fl"></div></a>
    </div>
    <a href="javascript:" data-am-modal="{target: '#my-actions'}"><div class="promptly_tuan fl">加入购物车</div></a>

    <div class="cl"></div>

</footer>
<!--detail_footer end-->

<div class="am-modal-actions" id="my-actions" >
    <div class="am-modal-actions-group" style="margin-bottom: 0px">
        <ul class="am-list">
            <li class="am-modal-actions-header">
                <span data-type="icon" class="btn am-icon-close " data-am-modal-close style="float: right;"></span>
                <div style="clear: both;border-top: 1px solid #dedede;" >
                    <div class="dp-num">
                        <div class="dpn-l">购买数量</div>
                        <div class="dpn-r">
                            <span class="dpn-del">-</span>
                            <span class="dpn-buy">1</span>
                            <span class="dpn-add">+</span>
                        </div>
                    </div>
                </div>
            </li>

        </ul>

    </div>
    <div class="am-modal-actions-group" style="margin-top: 0px">
        <button class="am-btn am-btn-secondary am-btn-block" id="addCart">加入购物车</button>
    </div>
</div>



<!--引入js资源-->
<script src="/asset/main/js/jquery-1.10.2.min.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="/asset/newUser/js/handlebars.min.js"></script>
<script src="/asset/newUser/js/amazeui.widgets.helper.js"></script>
<script src="/asset/newUser/js/alertPopShow.js"></script>
<script>
    var productId = <s:property value="product.id" escape="false"/>;
    $(".dpn-del").hammer().on("tap",function (e) {
        var num = $(".dpn-buy").text().trim();
        if(num>0){
            $(".dpn-buy").text(--num);
        }
    })

    $(".am-icon-home").hammer().on("tap",function (e) {
        window.location.href = "/user/index.action"
    })
    $(".am-icon-shopping-cart").hammer().on("tap",function (e) {
        window.location.href = "/user/cartPage.action"
    })
    $(".dpn-add").hammer().on("tap",function (e) {
        var num = $(".dpn-buy").text().trim();
        $(".dpn-buy").text(++num);
    })

    $("#addCart").hammer().on("tap",function (e) {
        var num = $(".dpn-buy").text().trim();
        if(num<=0){
            setTimeout(function() {
                webToast("数量不能为零","bottom", 1100);
            }, 300)
            return;
        }
        $.post('/user/addCart.action',{'id':productId,'num':num},function (data) {
            if(data=='success'){
                $("#my-actions").modal('close');
                setTimeout(function() {
                    webToast("加入购物车成功","bottom", 1100);
                }, 300);
            }else{
                $("#my-actions").modal('close');
                setTimeout(function() {
                    webToast("未知的错误","bottom", 1100);
                }, 300);
            }
        })

    })
</script>
</body>
</html>
