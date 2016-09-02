<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>全部订单</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link href="/asset/user/css/bootstrap.min.css" rel="stylesheet">
    <link href="/asset/user/css/style.css" rel="stylesheet">
    <link href="/asset/user/css/iconfont/iconfont.css" rel="stylesheet">
    <style type="text/css">

        .toasttj2{z-index:1003;font-size: 1.2em;position: fixed;bottom:25%;width: 100%;opacity:0;height: 24px;display: none;
            transition: opacity 1s ease-out;
        }

    </style>
</head>
<body class="bgf7">
<div class="container">
    <div class='row'>
        <div class="col-xs-12 clearPadding mb50">
            <div class="myotitle bg-white clearfix">
                <div class="col-xs-4 clearPadding text-center pt10"><span></span></div>
                <div class="col-xs-4 clearPadding text-center pt10"><span class="activeborder">订单详情&nbsp;&nbsp;&nbsp;</span></div>

            </div>
            <div id="ocontent">
                <div class="myolist">
                    <div class="myorderid clearfix plr15 borderbottom">
                        <h4 class="pull-left font12">
                            <span>订单号: <s:property value="order.id"/> </span>
                        </h4>
                        <h4 class="pull-right font12">2015-11-30 17:23 &nbsp;&nbsp;<i class="iconfont arrowdown">&#xe60c;</i></h4>
                    </div>
                    <div class="myddetailbox">
                        <s:iterator value="order.orderitems" var="item">
                        <div class="myodetail clearfix">
                            <div class="col-xs-2 clearPadding proimg">
                                <img src="<s:property value="#item.product.image.split(',')[0]"/>" alt="" style="width:50px;height: 50px">
                            </div>
                            <div class="col-xs-8 clearPadding proname plr10 ">
                                <div class="clearPadding proname plr10 ">
                                    <s:property value="#item.product.name"/>
                                </div>
                                <div class="clearPadding proname plr10 pt7 " style="color:#f0ad4e" >
                                    <s:property value="#item.requirement"/>
                                </div>
                            </div>
                            <div class="col-xs-2 clearPadding text-right">
                                <span class="colorred2">￥<s:property value="#item.fee"/></span><br>
                                <span class="font12 text-muted">× <s:property value="#item.num"/></span>
                            </div>
                        </div>
                        </s:iterator>
                        <div class="ptb10 plr15 text-muted font12 clearfix">
                            <div class="myodetail clearfix ">
                                <div class="col-xs-3 clearPadding text-right">
                                    <span class="">tel:<s:property value="order.tel"/></span><br>
                                </div>
                                <div class="col-xs-offset-2 col-xs-7 clearPadding text-right">
                                    <span class="">name:<s:property value="order.name"/></span><br>
                                </div>
                                <div class=" col-xs-11 clearPadding" style="margin-top:0.2rem">
                                    <span class="">addr:<s:property value="order.addr"/></span><br>
                                </div>
                                <div class=" col-xs-11 clearPadding" style="margin-top:0.2rem">
                                    <span class="">备注:<s:property value="order.remark"/></span><br>
                                </div>
                            </div>
                            <div class="pull-left font12" style="margin-top:0.8rem">
                                <span class="badge bg-dining" style="font-weight:normal;" id="conform">
                                    <s:if test="order.state==0">确认订单</s:if>
                                    <s:else>已处理</s:else>
                                </span>
                                <s:if test="order.state==0||order.state==1">
                                <span class="badge bg-dining" style="font-weight:normal;" id="cancel">
                                    取消订单
                                </span>
                                </s:if>
                            </div>
                            <div class="pull-right" style="margin-top:1rem">
                                <span>共<s:property value="order.orderitems.size"/>件商品</span>&nbsp;&nbsp;合计：<span class="colorred2">￥<s:property value="order.totalFee"/></span>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
            <div class="bottoms plr15" style="bottom:10px;">
                <%--<button class="bg-dining bordernone btn-block text-white ptb5">返回</button>--%>
            </div>
        </div>
    </div>
</div>
<div id="toastId2" class="toasttj2" style="display: none; opacity: 0;"></div>

<script src="/asset/user/js/jquery-2.1.4.min.js"></script>
<script>
    var orderId = <s:property value="order.id"/>;
    $(".myotitle >div").click(function(){
        $(this).find("span").addClass("activeborder");
        $(this).siblings().find("span").removeClass("activeborder");
    });
    $('.arrowdown').click(function(){
        $(this).parent().parent().next().slideToggle("slow");
    });
    $("#conform").click(function () {
        var confirmText = $("#conform").text().trim();

        if(confirmText=="已接单"){
            showLoding(2);
            return;
        }
        $.post("/user/confirmOrder.action",{"id":orderId},function (data) {
            if(data=="success"){
                $("#conform").text("已接单");
                showLoding(1);
            }
        })
    })
    $("#cancel").click(function () {
        var confirmText = $("#conform").text().trim();

        if(confirmText=="已接单"){
            showLoding(2);
            return;
        }
        $.post("/user/deleteOrder.action",{"id":orderId},function (data) {
            if(data=="success"){
                $("#conform").text("已取消");
                showLoding(1);
                $("#cancel").hide();
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
            setToast3('<div style="color:#fff;background: rgba(0, 0, 0, 0.6);border-radius: 2px;padding: 2px;text-align: center;width:200px;margin: 0 auto;">成功</div>');
        }else if(2==f){
            setToast3('<div style="color:#fff;background: rgba(0, 0, 0, 0.6);border-radius: 2px;padding: 2px;text-align: center;width:235px;margin: 0 auto;">已经结果单,请勿重复接单</div>');
        }
    }
</script>
</body>
</html>

