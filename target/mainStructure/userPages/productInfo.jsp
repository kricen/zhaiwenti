<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1 user-scalable=no">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>商品详情</title>

    <!-- Bootstrap -->
    <link href="/asset/user/css/bootstrap.min.css" rel="stylesheet">
    <link href="/asset/user/css/font-awesome.min.css" rel="stylesheet">
    <link href="/asset/user/css/alongsty.css" rel="stylesheet">
    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="/asset/user/css/swiper.min.css">
    <link rel="stylesheet" href="/asset/user/css/app.css">
    <!--[if lt IE 9]>
    <script src="/asset/user/js/html5shiv_min.js"></script>
    <script src="/asset/user/js/respond_min.js"></script>
    <![endif]-->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- 时间轴导航所需css&js -->
    <script type="text/javascript" src="/asset/main/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/asset/main/js/zepto.js"></script>
    <script type="text/javascript" src="/asset/user/js/hammer.min.js"></script>
    <style type="text/css">

        .toasttj2{z-index:1003;font-size: 1.2em;position: fixed;bottom:25%;width: 100%;opacity:0;height: 24px;display: none;
            transition: opacity 1s ease-out;
        }

    </style>


</head>
<body class="item">
<div class="toper navbar-fixed-top">
    <div class="row color_white " >
        <div class="col-xs-2" style="padding-left:25px;"><a href="javascript:go()" class="cwhite" ><i class="icon-angle-left font32"></i></a></div>
        <div class="col-xs-8 text-center font20" style="padding-top: 2px"> 商品详情</div>
        <div class="col-xs-2" style="padding-top: 2px"><a href="/user/cartPage.action"><div class="photo_25" style="margin-top:3px;"><img src="/asset/user/images/icon_shopcar.png" alt="购物车"></div></a></div>
    </div>
</div><!-- toper -->
<div class="height53"></div>
<div class="swiper-container">
    <div class="swiper-wrapper">
        <s:iterator value="product.image.split(',')" var="image">
        <div class="swiper-slide">
            <div class="homephoto"><img class="imgs" src="<s:property value="#image"/>"></div>
        </div>
        </s:iterator>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
</div>
<!-- Swiper JS -->
<script src="/asset/main/js/swiper.min.js"></script>

<!-- Initialize Swiper -->
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true
    });
</script><!-- 焦点图 -->
<div class=" width100 bg_white" style="padding:10px;">
    <p><span class="pull-left font18" style="padding-top: 0.5em"><s:property value="product.name"></s:property></span><p class="pull-right color_gray font16"><span class="color_orange">&nbsp;&nbsp;&nbsp;&nbsp;¥:</span><span style="padding-top: 2rem" class="nowPrice color_orange font20 price"><s:property value="product.price"/></span></p></p>
    <section  class="sku guige">
        <hr class="height2"/>
        <dl class="sku-group">
            <dt class="font14">规格</dt>
        </dl >
        <hr class="height2"/>
    </section>
    <div class=" width100 bg_white" style="padding-left:10px;">
    <span class="pull-left" style="padding-top: 7px">数量</span>
    <span class="pull-left marginright2em" style="padding-left: 10px">
            <div class="btn-group" role="group" aria-label="...">
                <span id="icon-minus"  class="btn btn-default"><i  class="icon-minus"></i></span>
                <button type="button" class="btn btn-default disabled product-num">0</button>
                <span id="icon-plus"  class="btn btn-default"><i  class="icon-plus"></i></span>
            </div>
        </span>
    </div>
    <div class="height10"></div>
</div><!--a-->
<input type="hidden" id="product-id" value="<s:property value="product.id"/>">
<div class="height10"></div>
<div class=" width100 bg_white border_bottom" style="padding:10px;">
    <span class=" font16">商品介绍</span>
    <span class="pull-right "><a title="收起" class=" cgreen" href="#"><i class="icon-angle-up pull-right" style="font-size:24px;"></i></a></span>
</div>
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true
    });
</script><!-- 焦点图 -->
<div class=" width100 bg_white" style="padding:10px;">
    <div class="artic14">
        <p><s:property value="product.comments"/></p>
    </div>
</div><!--a-->
<section class="layer">
    <div class="content">
        <div class="head"><a class="close"></a></div>
        <div class="bd">
            <dl>
                <dt>本网价:</dt>
                <dd><span >￥<b class="nowPrice"><s:property value="product.price"/> </b></span></dd>
            </dl>
            <s:iterator value="additionals" var="addition">
            <dl>
                <dt><s:property value="#addition.name"/>:</dt>
                <dd>
                    <ul class="product-tag">
                        <s:iterator value="#addition.additionalItems" var="item" status="index">
                            <li><a data-id="<s:property value="#item.id"/>" data-sku="<s:property value="#item.fee"/>" <s:if test="#index.index==0">class="active"</s:if>> <s:property value="#item.name"/></a><i></i></li>
                        </s:iterator>
                    </ul>
                </dd>
            </dl>
            </s:iterator>
        </div>
        <div class="foot"><a class="next" id="nextSelect" data-id=10 href="">确定</a></div>
    </div>

</section>
<div class="height50"></div>
<div class=" width100 bg_white navbar-fixed-bottom cart-div" style="padding:10px;">
    <div class="row" style="width:100%; margin:0 auto;">
        <div class="col-xs-7 pull-right" style="padding-left:5px; padding-right:0px;">
            <button class="btn btn-lg btn-success btn-group-justified" type="submit" id="addCart" >加入购物车</button>
        </div>
    </div>
</div>
<div id="toastId2" class="toasttj2" style="display: none; opacity: 0;"></div>

</body>
<script type="text/javascript">
    var openDia = true;
    (function(doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function() {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    var docElWidth = 100 * (clientWidth / 640);
                    if (docElWidth > 100) docElWidth = 100;
                    docEl.style.fontSize = docElWidth + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);

    $(function () {
        $('#nextSelect').on('touchend',function(ev){
            ev.preventDefault();
            openDia = false;
            $("body").click();
            $(".cart-div").show();
            $('.layer').removeClass('acitve');
        })
        $('#addCart').on('touchend',function(ev){
            ev.preventDefault();
            if(openDia){
               guigeTouched();
            }else {
                var productNum = $(".product-num").text().trim();
                if(productNum<=0){
                    showLoding(1);
                    return;
                 }
                $("body").click();
                addCart();
            }


        })
        $('.guige').on('touchend',function(ev){
            guigeTouched();
        })
        function guigeTouched() {
            openDia = false;
            $("body").click();
            $(".cart-div").hide();
            $('.layer').addClass('acitve');
        }
        $('.close').on('touchend',function(ev){
            ev.preventDefault();
            $(".cart-div").show();
            $('.layer').removeClass('acitve');
        });
        $('.product-tag li').on('tap',function () {
            var prePrice = parseInt($(this).parent().find('li a.active').attr('data-sku'));
            $(this).parent().find('li a').removeClass('active');
            $(this).find('a').addClass('active')
            var nowPrice = parseInt($(this).find('a').attr('data-sku'));
            //如果现选的tag价格大于原来tag的价格
            var tagPrice = nowPrice-prePrice;
            var price = parseInt($('.nowPrice:first').text());
            $('.nowPrice').text(price+tagPrice)
            openDia = false;

        })
        var hammertime = new Hammer(document.getElementById("icon-plus"));
        hammertime.on('tap',function (ev) {
            ev.preventDefault()
            var productNum = parseInt($(".product-num").text());
            $(".product-num").text(++productNum)

        });
        var hammertime = new Hammer(document.getElementById("icon-minus"));
        hammertime.on('tap',function (ev) {
            ev.preventDefault()
            var productNum = parseInt($(".product-num").text());

            if(productNum>0){
                $(".product-num").text(--productNum)

            }

        });

    })
    function addCart(){
        var arr = new Array();
        $('.product-tag li').find('a.active').each(function () {
            arr.push($(this).attr('data-id'))
        })
        var productNum = parseInt($(".product-num").text());
        var productId = parseInt($("#product-id").val());
        $.post("/user/addCart.action",{"arrs":JSON.stringify(arr),"num":productNum,"id":productId},function (data) {
            if(data=="success"){
                showLoding(2);
                $(".cart-div").show();
                $('.layer').removeClass('acitve');
            }
        })
    }
</script>

<script type="text/javascript">
    $(function () {
        $(".imgs").each(function () {
            var image=new Image();
            image.src=$(this).attr('src');
            if(image.width>0 && image.height>0){
                if(image.width<=image.height){
                    $(this).width('50%');
                    $(this).css('margin-left','25%');
                }
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
    function showLoding(f){
        if(1==f){
            setToast3('<div style="color:#fff;background: rgba(0, 0, 0, 0.6);border-radius: 2px;padding: 2px;text-align: center;width:200px;margin: 0 auto;">购买数量不能为空</div>');
        }else if(2==f){
            setToast3('<div style="color:#fff;background: rgba(0, 0, 0, 0.6);border-radius: 2px;padding: 2px;text-align: center;width:235px;margin: 0 auto;">加入购物车成功</div>');
        }
    }
    function go()
    {
        window.history.go(-1);
    }
</script>
</html>
