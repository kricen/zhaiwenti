<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>微信网站模板</title>

    <meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta charset="utf-8">

    <link href="/asset/userAsset/css/center.css" rel="stylesheet" type="text/css" />
    <link href="/asset/userAsset/css/iscroll.css" rel="stylesheet" type="text/css" />
    <style>
        .banner img {width: 100%;}
    </style>

    <script type="text/javascript" src="/asset/userAsset/js/iscroll.js"></script>
    <script type="text/javascript">
        var myScroll;
        function loaded(){
            myScroll = new iScroll('wrapper', {
                snap: true,
                momentum: false,
                hScrollbar: false,
                onScrollEnd: function () {
                    document.querySelector('#indicator > li.active').className = '';
                    document.querySelector('#indicator > li:nth-child(' + (this.currPageX+1) + ')').className = 'active';
                }
            });
        }
        document.addEventListener('DOMContentLoaded', loaded, false);
    </script>

</head>

<body>



<script type="text/javascript" src="/asset/userAsset/js/jquery.min.js"></script>
<div class="banner">

    <div id="wrapper">
        <div id="scroller">
            <ul id="thelist">
                <li><p>幻灯片01</p><a href="javascript:void(0)"><img src="/asset/userAsset/images/3.jpg" /></a></li>
                <li><p>幻灯片02</p><a href="javascript:void(0)"><img src="/asset/userAsset/images/4.jpg" /></a></li>
            </ul>
        </div>
    </div>

    <div id="nav">
        <ul id="indicator">
            <li class="active" ></li>
            <li></li>
        </ul>
    </div>

</div>

<ul class="mainmenu">
    <li><a href="/user/index.action" ><b><img src="/asset/userAsset/images/tb01.png" /></b><span>购物中心</span></a></li>
    <li><a href="/user/orderPage.action" ><b><img src="/asset/userAsset/images/plugmenu10.png" /></b><span>我的订单</span></a></li>
    <li><a href="javascript:zhuxiao();" ><b><img src="/asset/userAsset/images/tb04.png" /></b><span>注销登陆</span></a></li>

</ul>

<script type="text/javascript">
    var count = document.getElementById("thelist").getElementsByTagName("img").length;

    var count2 = document.getElementsByClassName("menuimg").length;
    for(i=0;i<count;i++){
        document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:"+document.body.clientWidth+"px";
    }
    document.getElementById("scroller").style.cssText = " width:"+document.body.clientWidth*count+"px";

    setInterval(function(){
        myScroll.scrollToPage('next', 0,400,count);
    },3500 );

    window.onresize = function(){
        for(var i=0;i<count;i++){
            document.getElementById("thelist").getElementsByTagName("img").item(i).style.cssText = " width:"+document.body.clientWidth+"px";
        }
        document.getElementById("scroller").style.cssText = " width:"+document.body.clientWidth*count+"px";
    }

    function zhuxiao(){
        window.localStorage.removeItem("phone");
        window.location.href = "/user/huanchong.action"
    }
</script>

</body>
</html>
