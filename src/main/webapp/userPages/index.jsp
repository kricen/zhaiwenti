<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="yes" name="apple-touch-fullscreen"/>
    <meta content="telephone=no" name="format-detection"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="#ffffff" name="msapplication-TileColor" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <title>文体</title>
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/swiper.min.css">
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/style.css">
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/index.css">
</head>
<body>
<script type="text/javascript" src="/asset/userAsset/js/jquery.min.js"></script>
<div style="height: 100%" class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide"><img src="/asset/userAsset/images/prt_1.jpg"></div>
        <div class="swiper-slide"><img src="/asset/userAsset/images/prt_1.jpg"></div>
        <div class="swiper-slide"><img src="/asset/userAsset/images/prt_1.jpg"></div>
    </div>
</div>
<div class="nav-lf">
    <ul id="nav">
    <s:iterator value="productBeanList" var="productBean" status="index">
        <li class="<s:if test="#index.index==0">current</s:if>"> <a href="#st<s:property value="#productBean.categoryId"/>"><s:property value="#productBean.categoryName"/></a><b <s:if test="#productBean.num>0"> style="display:inline;"</s:if> class="amount"><s:property value="#productBean.num"/></b></li>
    </s:iterator>
    </ul>
</div>

<div id="container" class="container">
    <s:iterator value="productBeanList" var="productBean">
    <div class="section" id="st<s:property value="#productBean.categoryId"/>">
        <s:iterator value="#productBean.list" var="product">
        <div class="prt-lt">
            <div class="lt-lt"><img src="<s:property value="#product.image"/>"></div>
            <div class="lt-ct">
                <p><s:property value="#product.name"/><s:if test="#product.hot==1"><span class="ltgreen"></span></s:if></p>
                <p class="pr">¥<span class="price"><s:property value="#product.price"/></span></p>
            </div>
            <div class="lt-rt">
                <input type="hidden" value="<s:property value="#product.id"/>" class="productId">
                <span type="button" class="minus"  value="-">-</span>
                <input type="text" class="result" value="<s:property value="#product.num"/>">
                <span type="button" class="add" value="+">+</span>
            </div>
        </div>
        </s:iterator>
    </div>
    </s:iterator>
    <div class="lastfooter" >
    </div>
</div>
</div>
<footer >
    <div class="ft-lt">
        <p>合计:<span id="total" class="total">163.00元</span><span class="nm">(<label class="share"></label>份)</span></p>
    </div>
    <div class="ft-rt">
        <p id="selectOk">去结算</p>
    </div>
</footer>
<script type="text/javascript" src="/asset/userAsset/js/Adaptive.js"></script>
<script type="text/javascript" src="/asset/userAsset/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/asset/userAsset/js/swiper.min.js"></script>
<script type="text/javascript" src="/asset/userAsset/js/jquery.nav.js"></script>
<script type="text/javascript">
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        spaceBetween: 30,
    });

    $(function(){
        $('#nav').onePageNav();
    });
    $(function(){
        $(".add").click(function(){
            var t=$(this).parent().find('input[class*=result]');
            t.val(parseInt(t.val())+1);
            var attrId = $(this).parent().parent().parent().attr("id");
            $("#nav").find("li.current").removeClass('current');
            $("#nav li").each(function () {
                var ahref =  $(this).find("a");
                if(ahref.attr('href')=='#'+attrId){
                    ahref.parent().addClass('current');
                }
            })
            setTotal();
            var productId = $(this).siblings('.productId').val();
            var productNum = $(this).siblings('.result').val()
            $.post("/user/addCart.action",{'id':productId,"num":productNum},function(data){
                if(data=="noLogin"){
                    window.location.href="/user/huanchong.action"
                }
            })
        })
        $(".minus").click(function(){
            var t=$(this).parent().find('input[class*=result]');
            var attrId = $(this).parent().parent().parent().attr("id");
            $("#nav").find("li.current").removeClass('current');
            $("#nav li").each(function () {
                var ahref =  $(this).find("a");
                if(ahref.attr('href')=='#'+attrId){
                    ahref.parent().addClass('current');
                }
            })

            t.val(parseInt(t.val())-1);
            if(parseInt(t.val())<0){
                t.val(0);
            }
            setTotal();
            var productId = $(this).siblings('.productId').val();
            var productNum = $(this).siblings('.result').val()
            $.post("/user/addCart.action",{'id':productId,"num":productNum},function(data){
                if(data=="noLogin"){
                    window.location.href="/user/huanchong.action"
                }
        })

        })

        function setTotal(){
            var s=0;
            var v=0;
            var n=0;
            <!--计算总额-->
            $(".lt-rt").each(function(){
                s+=parseInt($(this).find('input[class*=result]').val())*parseFloat($(this).siblings().find('span[class*=price]').text());

            });

            <!--计算菜种-->
            var nIn = $("li.current a").attr("href");
            $(nIn+" input[type='text']").each(function() {
                if($(this).val()!=0){
                    n++;
                }
            });

            <!--计算总份数-->
            $("input[type='text']").each(function(){
                v += parseInt($(this).val());
            });
            if(n>0){
                $(".current b").html(n).show();
            }else{
                $(".current b").hide();
            }
            $(".share").html(v);
            $("#total").html(s.toFixed(2));
        }
        setTotal();

    })
    $(function(){
        $("#selectOk").click(function (data) {
            $.post("/user/cartToOrder.action",{}, function (data) {
                console.log(data)
                if(data=="noLogin"){
                    window.location.href="/user/huanchong.action"
                }else if(data=='success'){
                    window.location.href = "/user/orderInfoPage.action"
                }else if(data=='index'){
                    alert("您还没选购商品");
                }else {

                }
            })
        })
    });
</script>
<script type="text/javascript" src="/asset/userAsset/js/waypoints.min.js"></script>
<script type="text/javascript" src="/asset/userAsset/js/navbar2.js"></script>
</body>
</html>
