<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>购物车</title>
    <link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css">
    <link rel="stylesheet" type="text/css" href="/asset/newUser/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="/asset/newUser/css/loading.css"/>
    <link rel="stylesheet" type="text/css" href="/asset/newUser/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/asset/newUser/css/style.css"/>
    <link rel="stylesheet" href="/asset/newUser/css/common.css"/>
    <link rel="stylesheet" href="/asset/newUser/css/weui.min.css"/>
    <script src="/asset/main/js/jquery-1.10.2.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(window).load(function(){
            $(".loading").addClass("loader-chanage")
            $(".loading").fadeOut(300)
        })
    </script>
</head>
<body>
<header class="page-header">
    <h3 style="margin-top: .1rem;font-size: 2.2rem">购物车</h3>
    <a href="/user/index.action" style="margin-top: .7rem" class="return1"> <span data-type="icon" style="color: white;font-size: 30px" class="btn  am-icon-home " ></span></a>
    <a href="/user/index.action" style="margin-top: .7rem" class="return1"> <span data-type="icon" style="color: white;font-size: 30px" class="btn  am-icon-home " ></span></a>
</header>
<s:if test="cartitems==null||cartitems.size==0">
    <div id="nothing" class="animated slideInUp" >
        <img src="/images/cart-empty-icon.png">
        <p>购物车里还是空空的，赶紧
            <a href="/user/index.action">去逛逛</a>
            吧！</p>
    </div>
</s:if>
<s:else>
    <div class="contaniner fixed-contb product-content">
        <s:iterator value="cartitems" var="cartitem">
        <section class="shopcar">
            <figure><img src="<s:property value="#cartitem.product.headImage.image"/>"/></figure>
            <dl>
                <dt><s:property value="#cartitem.product.name"/></dt>
                <dd><s:property value="#cartitem.product.comments"/></dd>
                <div class="add">
                    <input type="hidden" class="product-id" value="<s:property value="#cartitem.id"/>"/>
                    <span class="product-reduce">-</span>
                    <input type="text" class="product-num" style="color: black" value="<s:property value="#cartitem.num"/>" readOnly="true" />
                    <span class="product-add">+</span>
                </div>
                <h3 class="fee"><s:property value="#cartitem.fee"/></h3>
                <small class="product-del"><img src="/images/shopcar-icon01.png"/></small>
            </dl>
        </section>
        </s:iterator>
    </div>

    <footer class="page-footer fixed-footer product-content">
        <div class="shop-go">
            <b class="heji"></b>
            <span class="qujiesuan"><a href="javascript;">去结算</a></span>
        </div>

    </footer>
    <div id="nothing" class="animated slideInUp" hidden>
        <img src="/images/cart-empty-icon.png">
        <p>购物车里还是空空的，赶紧
            <a href="/user/index.action">去逛逛</a>
            吧！</p>
    </div>
</s:else>

<div id="loadingToast" class="weui_loading_toast" style="display:none;">
    <div class="weui_mask_transparent"></div>
    <div class="weui_toast" style="width: 10em">
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
        <p class="weui_toast_content">加载中</p>
    </div>
</div>

</body>
<script src="/asset/main/js/jquery-1.10.2.min.js"></script>
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="/asset/newUser/js/alertPopShow.js"></script>
<script>
    window.onload = tongjiReload();
    $(".product-reduce").hammer().on("tap",function (e) {
        var num = $(this).siblings('.product-num').val().trim();
        var productId = $(this).siblings('.product-id').val().trim();
        var $producctNum = $(this).siblings('.product-num');
        if(num<=1){
            setTimeout(function() {
                webToast("数量已到下限","bottom", 1100);
            }, 100)
            return;
        }
        $.post('/user/cartChangeNum.action',{'id':productId,'num':-1},function (data) {
            if(data=='success'){
                $producctNum.val(--num);
                tongjiReload()
            }else {
                setTimeout(function() {
                    webToast("未知的错误","bottom", 1100);
                }, 300)
            }

        })

    })
    $(".qujiesuan").hammer().on("tap",function (e) {
        $("#loadingToast").show();
        $.post('/user/pay.action',{},function (data) {
            if(!isNaN(data)){
                window.location.href = "/user/payPage.action?id="+data;
            }else {
                setTimeout(function() {
                    webToast("未知的错误","bottom", 1100);
                }, 300)
            }

        })
    })
    $(".product-add").hammer().on("tap",function (e) {
        var $producctNum = $(this).siblings('.product-num');
        var num = $(this).siblings('.product-num').val().trim();
        var productId = $(this).siblings('.product-id').val().trim();
        $.post('/user/cartChangeNum.action',{'id':productId,'num':1},function (data) {
            if(data=='success'){
                $producctNum.val(++num);
                tongjiReload()
            }else {
                setTimeout(function() {
                    webToast("未知的错误","bottom", 1100);
                }, 300)
            }

        })
    })


    $(".product-del").hammer().on("tap",function (e) {
        var $target = $(this);
        var cartitemId = $target.parent().find('.product-id').val().trim();
        $.post('/user/delCartitem.action',{'id':cartitemId},function (data) {
            if(data=='success'){
                $target.parent().parent().remove();
                tongjiReload();
            }
        })
    })

    function tongjiReload() {

        if($(".shopcar").size()<=0){
            $(".product-content").hide();
            $("#nothing").show(500);
        }
        var totalNum = 0;
        var totalFee = 0;
        $(".shopcar").each(function () {
            var num = $(this).find('.product-num').val().trim();
            var fee = $(this).find('.fee').text().trim()
            totalNum+= num;
            totalFee += num* fee;
        })
        $(".heji").text(totalFee.toFixed(2))
    }
</script>
</html>
