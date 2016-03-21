<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>注册页面</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8" />
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="yes" name="apple-touch-fullscreen"/>
    <meta content="telephone=no" name="format-detection"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="#ffffff" name="msapplication-TileColor" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <link rel="stylesheet" href="/asset/userAsset/css/login.css">
    <link rel="stylesheet" href="/asset/userAsset/css/login1.css">
</head>
<script src="/asset/sellerAsset/js/jquery.js"></script>
<script type="text/javascript">
    var phone = window.localStorage.getItem("phone");
    if(phone==null){
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
<body class="mWrap">
<header class="topHd">
    <span>会员登录</span>
</header>
<section class="mContent">

    <form id="loginForm" method="post">
        <input type="hidden" name="comeback" value="" />
        <ul class="form">
            <li>
                <input type="text" class="input" placeholder="手机号："  id="phone" name="username" />
            </li>
            <li class="other">
                <input type="text" hidden class="input" id="name" placeholder="姓名："  />
            </li>
            <li class="other">
                <input type="text" hidden class="input" id="addr" placeholder="地址："  />
            </li>
            <li class="btnArea" style="text-align: center">
                <button style="width: 8rem"  type="button" id="hlkOK"  class="btn"  >注&nbsp;&nbsp;册</button>
                <button type="button" id="otherInput"  style="width: 10rem" class="btn">展开其他信息</button>
            </li>
        </ul>
    </form>
</section>

</body>
<script type="text/javascript">
    $(function(){
        $("#otherInput").click(function (e) {
            $(".input").show();
            $("#otherInput").hide();
        });
        $("#hlkOK").click(function(){
            var phone = $("#phone").val().trim();
            if(!isPhone(phone)){
                $("#phone").val("");
                $("#phone").attr("placeholder",'Error:请输入标准的手机号');
            }else{
                var name = $("#name").val().trim();
                var addr = $("#addr").val().trim();
                $.post("/user/addUser.action",{"tel":phone,"name":name,"addr":addr}, function (data) {
                    if(data=="success"){
                        window.localStorage.setItem("phone",phone);
                        window.location.href="/user/center.action"
                    }
                })
            }
        })

        function isPhone(aPhone) {
            var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
            var isMob=/^1\d{10}$/;
            if(isMob.test(aPhone)||isPhone.test(aPhone)){
                return true;
            }
            else{
                return false;
            }
        }
    })
</script>
</html>
