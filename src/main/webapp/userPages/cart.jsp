<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <meta name="apple-mobile-web-app-capable" content="no">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="application-name" content="">
    <title>购物车</title>
    <meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
    <link href="/asset/user/css/font-awesome.min.css" rel="stylesheet">
    <link href="/asset/user/css/bootstrap.min.css" rel="stylesheet">
    <script src="/asset/user/js/zepto-1.1.6.min.js" type="text/javascript"></script>
    <script src="/asset/user/js/fx.js" type="text/javascript"></script>
    <script src="/asset/user/js/fastclick.js" type="text/javascript"></script>
    <script type="text/javascript">
        var sid = "d256b1d537fe186e53c0444399341c24";
    </script>
    <link href="/asset/user/css/alongsty.css" rel="stylesheet">
    <style type="text/css">

        .toasttj2{z-index:1003;font-size: 1.2em;position: fixed;bottom:25%;width: 100%;opacity:0;height: 24px;display: none;
            transition: opacity 1s ease-out;
        }
        div#nothing {
            display: none;
            width: 100%;
            margin-top: 150px; }
        div#nothing img {
            display: block;
            margin: 0 auto;
            width: 36%; }
        div#nothing p {
            margin-top: 24px;
            text-align: center;
            color: #888;
            font-size: 14px; }
        div#nothing p a {
            color: #eb0a34;
            font-style: italic; }

    </style>
</head>
<link rel="stylesheet" href="/asset/user/css/cart_v3.css">
<div class="toper navbar-fixed-top">
    <div class="row color_white " >
        <div class="col-xs-2" style="padding-left:25px;"><a class="cwhite" href="javascript:go()"><i class="icon-angle-left font32"></i></a></div>
        <div class="col-xs-8 text-center font20" style="padding-top: 2px"> 购物车</div>
        <div class="col-xs-2" style="padding-top: 2px"><a href="/user/index.action"><div class="photo_25" style="margin-top:3px;"><img src="/asset/user/images/home.png" alt="购物车"></div></a></div>
    </div>
</div><!-- toper -->
<div id="nothing" class="animated slideInUp">
    <img src="/asset/user/images/cart-empty-icon.png">
    <p>购物车里还是空空的，赶紧
        <a href="/user/index.action">去逛逛</a>
        吧！</p>
</div>
<div id="wrapper" style="height: 689px;margin-top: 53px" >
    <div class="viewport" id="scroller" style="-webkit-transition: 0ms cubic-bezier(0.1, 0.57, 0.1, 1); transition: 0ms cubic-bezier(0.1, 0.57, 0.1, 1); -webkit-transform: translate(0px, 0px) translateZ(0px);">
        <section class="content">
            <div class="block">
                <div class="cart_list" id="product-div">
                    <div class="shop_title" shop_id="6860">
                        <input type="checkbox" class="fl c_checkbox ">
                        <div class="fl " style="padding-left: 2rem"><a class="shopLink eclipse" href="">宅文体</a></div>
                        <a class="fl right_arrow pull-right" href=""></a>
                    </div>
                    <s:iterator value="cartitems" var="cartitem">
                    <div class="cart_item" id="<s:property value="#cartitem.id"/>" item_id="<s:property value="#cartitem.id"/>" stock="1000">
                        <input type="checkbox" class="fl c_checkbox real_checkbok" checked="">
                        <img src="<s:property value="#cartitem.product.image.split(',')[0]"/>" class="fl pro_pic">
                        <div class="detail">
                            <p class="fr prd_price">￥<span class="productPrice"><s:property value="#cartitem.product.price"/></span></p>
                            <p class="fl prd_tit"><a href=""><s:property value="#cartitem.product.name"/></a></p>
                            <p class="clear tags">
                                <a class="garbage" style="display: inline;"></a>
                                <a class="product-tag" style="display: inline;"><s:iterator value="#cartitem.requirement.split(',')" var="re"><span><s:property value="#re"/></span></s:iterator></a>
                            </p>
                        </div>
                        <div class="btn-group pull-right" style="padding-top: 5px;padding-bottom: 5px;" role="group" aria-label="...">
                            <span  class="btn btn-default"><i  class="icon-minus"></i></span>
                            <input type="hidden" id="cartitemId" value="<s:property value="#cartitem.id"/>">
                            <button type="button" class="btn btn-default disabled product-num"><s:property value="#cartitem.num"/></button>
                            <span   class="btn btn-default"><i  class="icon-plus"></i></span>
                        </div>

                        <div class="bottom_line"></div>
                    </div>
                    </s:iterator>
                </div>
            </div>
        </section>


    </div>
    <footer class="total_result" style="">
        <div class="fl ">
            <input type="checkbox" class="c_checkbox" id="cart_check_all" style="">
            <span >全选</span>
        </div>

        <div class="fr">
            <a style="border:.1rem solid red;" class="c_btn payBtn" id="do_checkout" href="javascript:;">去结算</a>
        </div>
        <div class="fr totalPrice">
            <span>商品金额总计</span>
            <p id="cart_price" ><span>￥</span><span class="totalFee"><s:property value="totalFee"/></span>
            </p>
        </div>
    </footer>
</div>
<section class="loading"></section>
<section class="f_mask"></section>
<section class="simple_block"></section>
<section class="m_block">
    <div class="m_content"></div>
    <div class="m_btns">
        <a class="m_ok_2">确定</a>
        <a class="m_cancel">取消</a><a class="m_ok">确定</a>
    </div>
</section>
<section direction="1" class="f_block" id="gift_block">
    <p class="f_title"><span></span><a class="c_close"></a></p>
    <div class="f_content">
        <div class="cart_list"></div>
    </div>
    <div class="f_foot">
        <a class="c_btn">确认</a>
    </div>
</section>

<section direction="0" class="f_block" id="choose_color_size">
</section>

<div id="toastId2" class="toasttj2" style="display: none; opacity: 0;"></div>

<script src="/asset/user/js/util.js" type="text/javascript"></script>
<script src="/asset/user/js/iscroll5.min.js" type="text/javascript"></script>
<script src="/asset/user/js/cart.js" type="text/javascript"></script>
<script type="text/javascript" src="/asset/main/js/zepto.js"></script>
<script type="text/javascript" src="/asset/main/js/jquery-1.10.2.min.js"></script>
<script src="/asset/user/js/stack.js" type="text/javascript"></script>
<script src="/asset/user/js/js_tracker.js"></script>
<script type="text/javascript">
    $(function () {
        jisuan();
        $(".icon-minus").on("tap",function (ev) {
            var productNum =parseInt($(this).parent().siblings(".product-num").text());
            var cartitemId = $(this).parent().parent().parent().attr("id");
            $(this).parent().siblings(".product-num").text(--productNum)
            jisuan();
            $.post("/user/changeCartitem.action",{"id":cartitemId,"sellNum":productNum},function (data) {
            })
        })
        $(".icon-plus").on("tap",function (ev) {
            var productNum = parseInt($(this).parent().siblings(".product-num").text());
            var cartitemId = $(this).parent().parent().parent().attr("id");
            $(this).parent().siblings(".product-num").text(++productNum)
            jisuan();
            $.post("/user/changeCartitem.action",{"id":cartitemId,"sellNum":productNum},function (data) {

            })
        })

        $(".c_checkbox").click(function () {
            jisuan();
        });


    })
    function jisuan() {
        var fee = 0;
        if($(".cart_item").size()<=0){
            $('#product-div').remove();
            $("#nothing").css("display","block");
        }else {
            $("#nothing").css("display","none");
        }
        $(".real_checkbok:checked").each(function () {
            var price = parseFloat($(this).parent().find(".productPrice").text());
            var num = parseInt($(this).parent().find(".product-num").text());
            fee += price*num;
        })
        $(".totalFee").text(fee);
    }
$("#do_checkout").click(function () {
    if($(".real_checkbok:checked").size()<=0){
        showLoding('请先选择要购买的商品');
        return ;
    }
    var arrs = new Array();
    $(".real_checkbok:checked").each(function () {
        arrs.push($(this).parent().attr("id"))
    })
    console.log(arrs);
    $.post("/user/cartToOrder.action",{"arrs":JSON.stringify(arrs)},function (data) {
        if(data=="success"){
            window.location.href="/user/orderInfoPage.action";
        }
    })
})
</script>
<script type="text/javascript">
    function $S(s){return document.getElementById(s);}
    function $html(s,html){$S(s).innerHTML=html;}
    var toastTime2=null;
    var displayTime2=null;
    function setToast3(html){
        if(toastTime2!=null){
            clearTimeout(toastTime2);
            clearTimeout(displayTime2);
        }
        $S('toastId2').style.display='block';
        $S('toastId2').style.opacity=1;
        $html('toastId2',html);
        toastTime2=setTimeout(function(){
            $S('toastId2').style.opacity=0;
            displayTime2=setTimeout(function(){$S('toastId2').style.display='none';},1000);
        },1000);
    }
    function showLoding(msg){
            setToast3('<div style="color:#fff;background: rgba(0, 0, 0, 0.6);border-radius: 2px;padding: 2px;text-align: center;width:200px;margin: 0 auto;">'+msg+'</div>');
    }
    function go()
    {
        window.history.go(-1);
    }
</script>
</body>
</html><!--LHC-2015-10-10-->

