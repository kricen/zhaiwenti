<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>宅文体</title>
    <!-- Bootstrap -->
    <link href="/asset/user/css/bootstrap.min.css" rel="stylesheet">
    <link href="/asset/user/css/font-awesome.min.css" rel="stylesheet">
    <link href="/asset/user/css/alongsty.css" rel="stylesheet">
    <link rel="stylesheet" href="/asset/user/css/allGoods.css"/>
    <link rel="stylesheet" href="/asset/user/css/"/>
    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="/asset/user/css/swiper.min.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="/asset/user/js/html5shiv_min.js"></script>
    <script src="/asset/user/js/respond_min.js"></script>
    <![endif]-->

    <style type="text/css">
        <!--
        body{ background:#ffffff;  font-family:"微软雅黑"; }
        -->
        .toasttj2{z-index:1003;font-size: 1.2em;position: fixed;bottom:25%;width: 100%;opacity:0;height: 24px;display: none;
            transition: opacity 1s ease-out;
        }

    </style>
</head>
<body >
<div class="toper navbar-fixed-top">
    <div class="row color_white " >
        <div class="col-xs-2">&nbsp;</div>
        <div class="col-xs-8 text-center font20">文体生鲜</div>
        <%--<div class="col-xs-2"><a href="#"><div class="photo_25" style="margin-top:3px;"><img src="/asset/user/images/icon_soso.png" alt="搜索"></div></a></div>--%>
    </div>
</div><!-- toper -->
<div class="height53"></div>
<div class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
            <div class="homephoto"><img src="/asset/user/images/shuiguotu.jpg"></div>
        </div>
        <div class="swiper-slide">
            <div class="homephoto"><img src="/asset/user/images/shucai.jpg"></div>
        </div>
        <div class="swiper-slide">
            <div class="homephoto"><img src="/asset/user/images/xuexi.jpg"></div>
        </div>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
</div>
<!-- Swiper JS -->
<!-- Swiper JS -->
<script src="/asset/main/js/swiper.min.js"></script>

<!-- Initialize Swiper -->
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true
    });
</script><!-- 焦点图 -->
<div class="height20"></div>
<div class=" container-fluid">
    <div class="row">
    <s:iterator value="categories" var="category" status="steps">
        <div class="col-xs-3  text-center">
            <a class="cgray" href="/user/cPListPage.action?id=<s:property value="#category.id"/>"><div class="photo_60"><img src="<s:property value="#category.image"/>"><br><s:property value="#category.name"/></div></a>
        </div>
        <s:if test="#steps.index==3">
            <div class="height20"></div>
        </s:if>
    </s:iterator>
    </div>
    <div class="height20"></div>
    <a href="#"><div class="adphoto"><img src="/asset/user/images/ad1.jpg" class="img-rounded"></div></a>
    <div class="height20"></div>
    <div class="body">
        <div class="tour font16">
            <p>全部商品<i class="xlmenu"></i></p>
        </div>
        <div class="allsp" id="vueproducts">
            <s:iterator value="products" var="product">
                <figure>
                    <a href="/user/productInfo.action?id=<s:property value="#product.id"/>"><img src="<s:property value="#product.image"/>" alt="商品" class="xqtp"/></a>
                    <p><s:property value="#product.name"/></p>
                    <div class="info">
                        <em class="sat">￥<s:property value="#product.price"/></em>
                        <a onclick="addCart(<s:property value="#product.id"/>)" ><img src="/asset/user/images/u20.png" alt="购物车" style="width: 35px;height: 35px" align="right"/></a>
                    </div>
                </figure>
            </s:iterator>
            <template v-for="product in products">
                <figure>
                    <a href="/user/productInfo.action?id={{ product.id }}"><img src="{{ product.image }}" alt="商品" class="xqtp"/></a>
                    <p>{{ product.name }}</p>
                    <div class="info">
                        <em class="sat">￥{{ product.price}}</em>
                        <a  onclick="addCart({{product.id}})"><img src="/asset/user/images/u20.png" alt="购物车" style="width: 35px;height: 35px" align="right"/></a>
                    </div>
                </figure>
        </template>
        </div>
    </div>
</div>
<div id="loading-area" style="width: 100%;height: 20px;text-align: center">
    <div class="load8">
        <div class="load8-container container1">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="load8-container container2">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="load8-container container3">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
    </div>
    <div class="height30"></div>
</div>
<div id="daodi" hidden style="width: 100%;height: 20px;text-align: center">到底啦*^_^*</div>
<i id="J_back_top" class="icons icons-back-top pull-right"></i>

<div class="height60"></div>
<div class="footer navbar-fixed-bottom">
    <div class="row ">
        <div class="col-xs-3 text-center" style=" padding-top:5px;">
            <a class="cgreen" href="/user/index.action"><div class="photo_30"><img src="/asset/user/images/nav11.png"><br>首页</div></a>
        </div>

        <div class="col-xs-6  text-center" style=" padding-top:5px;">
            <a class="cgray" href="/user/cartPage.action"><div class="photo_30"><img src="/asset/user/images/nav3.png"><br>购物车</div></a>
        </div>
        <div class="col-xs-3  text-center" style="padding-top:5px;">
            <a class="cgray" href="/user/orderPage.action"><div class="photo_30"><img src="/asset/user/images/nav4.png"><br>我的</div></a>
        </div>
    </div>
</div><!-- footer -->
<div class="modal fade" id="shopcar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h5 class="modal-title font16" id="myModalLabel">我的购物车</h5>
            </div>
            <div class="modal-body aligncenter">
                <div class="photo_60"><img src="/asset/user/images/icon_shopcar_ok.png"></div><br>
                您选购的商品已加入购物车<br>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <a href="/user/cartPage.action"><button type="button" class="btn btn-success">去结算</button></a>
            </div>
        </div>
    </div>
</div>
<div id="toastId2" class="toasttj2" style="display: none; opacity: 0;"></div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="/asset/main/js/jquery_min1_11_2.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="/asset/main/js/bootstrap.min.js"></script>
<script src="/asset/main/js/vue.min.js"></script>
<script type="text/javascript">
    var example2 = new Vue({
        el: '#vueproducts',
        data: {
            products: [

            ]
        }
    })
    $('#form1').submit(function(){
        var sub=true;
        $("form :input.required").each(function(){
            if($(this).val().trim()==""){
                sub=false;
            }
        });
        if(!sub){
            return false;
        }
    });

    var imgWidth=$(".products-li").width();
    if(imgWidth<300){
        $(".products-box").width(imgWidth);
        $(".products-box").height(imgWidth);
        $(".lazy").width(imgWidth);
        $(".lazy").height(imgWidth);
    }


    //当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
        $(function () {
            $(window).scroll(function(){
                if ($(window).scrollTop()>100){
                    $("#J_back_top").fadeIn(1500);
                }
                else
                {
                    $("#J_back_top").fadeOut(1500);
                }
            });

            //当点击跳转链接后，回到页面顶部位置
            $("#J_back_top").click(function(){
                $('body,html').animate({scrollTop:0},1000);
                return false;
            });
        });


//        $('img.lazy').lazyload();
        var p=2;
        var visable = false;
        var stop=true;//触发开关，防止多次调用事件
        $(window).scroll(function() {
            //当内容滚动到底部时加载新的内容 100当距离最底部100个像素时开始加载.
            if ($(this).scrollTop() + $(window).height() + 100 >= $(document).height() && $(this).scrollTop()> 100) {
                if(stop==true){
                    $("#loading-area").show();
                    stop = false;
                    $.post("/user/hotProducts.action",{"page":p},function (data) {
                        p++;
                        if(data==""){
                            visable = true;
                            $("#loading-area").hide();
                            $("#daodi").show();

                        }else if(data=="noLogin"){
                            window.location.href = "/user/login.action"
                        }else{
                            example2.$data.products = example2.$data.products.concat(data);
                            stop = true;
                        }
                        $("#loading-area").hide();
                    })

                }
//
            }

        });
    $(function () {
        $(window).scroll(function () {
            if( $(this).scrollTop() + $(window).height() >= $(document).height() && $(this).scrollTop()> 100&&visable){
                setTimeout("showLoding(1)",800)
                visable = false;
            }

        });

    });
    function addCart(productId) {
        $.post("/user/addCart.action",{"num":-1,"id":productId},function (data) {
            if(data=="success"){
                $("#shopcar").modal();
            }
        })
    }
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
            setToast3('<div style="color:#fff;background: rgba(0, 0, 0, 0.6);border-radius: 2px;padding: 2px;text-align: center;width:200px;margin: 0 auto;">没有更多内容了</div>');
        }else if(2==f){
            setToast3('<div style="color:#fff;background: rgba(0, 0, 0, 0.6);border-radius: 2px;padding: 2px;text-align: center;width:235px;margin: 0 auto;">没有更多内容了</div>');
        }
    }
</script>
</body>
</html>

