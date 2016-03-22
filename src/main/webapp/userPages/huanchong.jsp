<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>购书宝</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8" />
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="yes" name="apple-touch-fullscreen"/>
    <meta content="telephone=no" name="format-detection"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="#ffffff" name="msapplication-TileColor" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <link rel="shortcut icon" type="image/x-icon" href="/images/goushubao.ico" media="screen" />
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/animate.css">
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/notFound.css">
    <script src="/asset/sellerAsset/js/jquery.js"></script>
</head>
<script type="text/javascript" >
    var phone = window.localStorage.getItem("phone");
    console.log(phone)
    if(phone==null){
        window.location.href="/user/login.action"
    }else {
        $.post("/user/validateUser.action",{"tel":phone},function(data){
            if(data=="success"){
                //购物车
                <s:if test="page==1">
                window.location.href = "/user/cartPage.action"
                </s:if>
                //订单中心
                <s:elseif test="page==2">
                window.location.href = "/user/orderPage.action"
                </s:elseif>
                //选购页面
                <s:else>
                window.location.href = "/user/index.action"
                </s:else>
            }else {
                window.localStorage.removeItem("phone");
            }
        })
    }
</script>
<body>
<header>
    <h1>文体</h1>
</header>
<div id="nothing" class="animated slideInUp">
    <img style="margin:0 auto" src="/asset/userAsset/images/huanchong.jpg">
</div>
</body>
</html>
