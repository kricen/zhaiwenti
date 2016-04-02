<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的订单</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8" />
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="yes" name="apple-touch-fullscreen"/>
    <meta content="telephone=no" name="format-detection"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="#ffffff" name="msapplication-TileColor" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/myOrders.css">
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/animate.css">
</head>
<body>
<header>
    <h1>
        <a class="iconfont back" href="javascript:window.history.go(-1)">&#xe601;</a >
        我的订单
        <a class="iconfont home" href="/user/centerPage.action">&#xe60e;</a >
    </h1>
</header>

<div id="content">
    <!-- nav part -->
    <nav>
        <ul id="category">
            <li class="0">待处理(<span class="all0"><s:property value="pendingOrders.size()"/></span>)</li>
            <li class="1">进行中 (<span class="pending1"><s:property value="ongoingOrders.size()"/></span>)</li>
            <li class="2">已完成 (<span class="complete2"><s:property value="completeOrders.size()"/></span>)</li>
        </ul>
        <p class="underline"></p>
        <div style="clear:both"></div>
    </nav>

    <!-- orders part -->
    <div id="a" class="model">
        <s:iterator value="pendingOrders" var="order">
            <section class="order <s:property value="#order.id"/>">
                <h3>
                    <span class="name"><s:property value="#order.name"/> </span>
                    <s:if test="#order.state==-1">
                        <span class="state waitMoney">待提交
					    </span>
                    </s:if>
                    <s:elseif test="#order.state==0">
                        <span class="state accepted">下单成功,等待商家接单</span>
                    </s:elseif>
                    <s:elseif test="#order.state==1">
                        <span class="state accepted">商家已接单</span>
                    </s:elseif>
                    <s:elseif test="#order.state==2">
                        <span class="state">交易成功</span>
                    </s:elseif>
                    <s:elseif test="#order.state==3">
                        <span class="state">交易失败</span>
                    </s:elseif>
                </h3>
                <p>
                    <span class="num">订单号：<s:property value="#order.id"/></span>
                    <span class="time"><s:date name="#order.ordertime" format="yyyy-MM-dd" /></span>
                </p>
                <p>
                        <span class="info">
                            共计 <s:property value="#order.num"/> 件
                                <span class="pay cash">（货到付款）</span>
                        </span>
                    <span class="price"><s:property value="#order.totalFee"/></span>
                </p>
                <div class="goods">
                    <ul>
                        <s:iterator value="#order.orderitems" var="orderitem">
                            <li>
                                <span class="iconfont dot">&#xe625;</span>
                                <span class="title"><s:property value="#orderitem.product.name"/> </span>
                                    <span class="price"><s:property value="#orderitem.product.price"/></span>
                                <span class="amount"><s:property value="#orderitem.num"/></span>
                            </li>
                        </s:iterator>
                    </ul>
                </div>
                <ul class="btns">
                    <s:if test="#order.state!=-1">
                        <li>
                            <button class="tel" data-tel="<s:property value="#order.seller.tel"/>">联系商家</button>
                        </li>
                    </s:if>
                    <s:if test="#order.state==-1">
                        <li>
                            <button class="payNow pay">立即提交</button>
                            <input type="hidden" class="orderNo" value="<s:property value="#order.id"/>">
                        </li>
                    </s:if>
                    <li>
                        <button class="lookInfo">查看详情</button>
                    </li>
                    <s:if test="#order.state==-1">
                        <li>
                            <button class="delBtn cancelOrder">取消订单</button>
                            <input type="hidden" class="orderNo" value="<s:property value="#order.id"/>">
                        </li>
                    </s:if>
                    <s:if test="#order.state==2||#order.state==3">
                        <li>
                            <button class="delOrder delBtn">删除记录</button>
                            <input type="hidden" class="orderId" value="<s:property value="#order.id"/>">
                        </li>
                    </s:if>
                </ul>
                <div style="clear:both"></div>
            </section>
        </s:iterator>

    </div>

     <div id="b" class="model">
         <s:iterator value="ongoingOrders" var="order">
             <section class="order <s:property value="#order.id"/>">
                 <h3>
                     <span class="name"><s:property value="#order.name"/> </span>
                     <s:if test="#order.state==-1">
                        <span class="state waitMoney">待提交
					    </span>
                     </s:if>
                     <s:elseif test="#order.state==0">
                         <span class="state accepted">下单成功,等待商家接单</span>
                     </s:elseif>
                     <s:elseif test="#order.state==1">
                         <span class="state accepted">商家已接单</span>
                     </s:elseif>
                     <s:elseif test="#order.state==2">
                         <span class="state">交易成功</span>
                     </s:elseif>
                     <s:elseif test="#order.state==3">
                         <span class="state">交易失败</span>
                     </s:elseif>
                 </h3>
                 <p>
                     <span class="num">订单号：<s:property value="#order.id"/></span>
                     <span class="time"><s:date name="#order.ordertime" format="yyyy-MM-dd" /></span>
                 </p>
                 <p>
                        <span class="info">
                            共计 <s:property value="#order.num"/> 件
                                <span class="pay cash">（货到付款）</span>
                        </span>
                     <span class="price"><s:property value="#order.totalFee"/></span>
                 </p>
                 <div class="goods">
                     <ul>
                         <s:iterator value="#order.orderitems" var="orderitem">
                             <li>
                                 <span class="iconfont dot">&#xe625;</span>
                                 <span class="title"><s:property value="#orderitem.product.name"/> </span>
                                 <span class="price"><s:property value="#orderitem.product.price"/></span>
                                 <span class="amount"><s:property value="#orderitem.num"/></span>
                             </li>
                         </s:iterator>
                     </ul>
                 </div>
                 <ul class="btns">
                     <s:if test="#order.state!=-1">
                         <li>
                             <button class="tel" data-tel="<s:property value="#order.seller.tel"/>">联系商家</button>
                         </li>
                     </s:if>
                     <s:if test="#order.state==-1">
                         <li>
                             <button class="payNow pay">立即提交</button>
                             <input type="hidden" class="orderNo" value="<s:property value="#order.id"/>">
                         </li>
                     </s:if>
                     <li>
                         <button class="lookInfo">查看详情</button>
                     </li>
                     <s:if test="#order.state==-1">
                         <li>
                             <button class="delBtn cancelOrder">取消订单</button>
                             <input type="hidden" class="orderNo" value="<s:property value="#order.id"/>">
                         </li>
                     </s:if>
                     <s:if test="#order.state==2||#order.state==3">
                         <li>
                             <button class="delOrder delBtn">删除记录</button>
                             <input type="hidden" class="orderId" value="<s:property value="#order.id"/>">
                         </li>
                     </s:if>
                 </ul>
                 <div style="clear:both"></div>
             </section>
         </s:iterator>
    </div>
    <div id="c" class="model">
        <s:iterator value="completeOrders" var="order">
            <section class="order <s:property value="#order.id"/>">
                <h3>
                    <span class="name"><s:property value="#order.name"/> </span>
                    <s:if test="#order.state==-1">
                        <span class="state waitMoney">待提交
					    </span>
                    </s:if>
                    <s:elseif test="#order.state==0">
                        <span class="state accepted">下单成功,等待商家接单</span>
                    </s:elseif>
                    <s:elseif test="#order.state==1">
                        <span class="state accepted">商家已接单</span>
                    </s:elseif>
                    <s:elseif test="#order.state==2">
                        <span class="state">交易成功</span>
                    </s:elseif>
                    <s:elseif test="#order.state==3">
                        <span class="state">交易失败</span>
                    </s:elseif>
                </h3>
                <p>
                    <span class="num">订单号：<s:property value="#order.id"/></span>
                    <span class="time"><s:date name="#order.ordertime" format="yyyy-MM-dd" /></span>
                </p>
                <p>
                        <span class="info">
                            共计 <s:property value="#order.num"/> 件
                                <span class="pay cash">（货到付款）</span>
                        </span>
                    <span class="price"><s:property value="#order.totalFee"/></span>
                </p>
                <div class="goods">
                    <ul>
                        <s:iterator value="#order.orderitems" var="orderitem">
                            <li>
                                <span class="iconfont dot">&#xe625;</span>
                                <span class="title"><s:property value="#orderitem.product.name"/> </span>
                                <span class="price"><s:property value="#orderitem.product.price"/></span>
                                <span class="amount"><s:property value="#orderitem.num"/></span>
                            </li>
                        </s:iterator>
                    </ul>
                </div>
                <ul class="btns">
                    <s:if test="#order.state!=-1">
                        <li>
                            <button class="tel" data-tel="<s:property value="#order.seller.tel"/>">联系商家</button>
                        </li>
                    </s:if>
                    <s:if test="#order.state==-1">
                        <li>
                            <button class="payNow pay">立即提交</button>
                            <input type="hidden" class="orderNo" value="<s:property value="#order.id"/>">
                        </li>
                    </s:if>
                    <li>
                        <button class="lookInfo">查看详情</button>
                    </li>
                    <s:if test="#order.state==-1">
                        <li>
                            <button class="delBtn cancelOrder">取消订单</button>
                            <input type="hidden" class="orderNo" value="<s:property value="#order.id"/>">
                        </li>
                    </s:if>
                    <s:if test="#order.state==2||#order.state==3">
                        <li>
                            <button class="delOrder delBtn">删除记录</button>
                            <input type="hidden" class="orderId" value="<s:property value="#order.id"/>">
                        </li>
                    </s:if>
                </ul>
                <div style="clear:both"></div>
            </section>
        </s:iterator>
    </div>

</div>
<script type="text/javascript" src="/asset/userAsset/js/hammer.min.js"></script>
<script type="text/javascript" src="/asset/userAsset/js/zepto.js"></script>
<script type="text/javascript">
    $(".delOrder").click(function () {
        var orderId = $(this).siblings(".orderId").val();
        var url = '/user/userDelOrder.action';
        var allNum = parseInt($(".all0").text().trim());
        var completeNum = parseInt($(".complete2").text().trim());
        var args= {"id":orderId};
        var $target = $(this).parent().parent().parent();
        $.post(url,args, function (data) {
            if(data=="success"){
                $(".all0").text(--allNum);
                $("."+orderId).remove();
                $(".complete2").text(--completeNum)
                $target.remove();
            }
        })
    });
    $(".cancelOrder").click(function () {
        var orderId = $(this).siblings(".orderNo").val();
        var url = '/user/cancelOrder.action';
        var allNum = parseInt($(".all0").text().trim());
        var args= {"id":orderId};
        var $target = $(this).parent().parent().parent();
        $.post(url,args, function (data) {
            if(data=="success"){
                $(".all0").text(--allNum);
                console.log(data);
                $target.remove();
            }
        })
    });
    $(".payNow").click(function () {
        var orderId = $(this).siblings(".orderNo").val();
        window.location.href="/user/orderInfoPage.action?id="+orderId;
    });
    //nav part's animation
    $("#category").on('tap', 'li', function(event) {
        var target = $(event.target);
        var value = parseInt(target.attr('class'));
        $("div.model").hide()
        //数字到模块id的切换
        var model  ;
        if(value==0) model = 'a';
        if(value==1) model = 'b';
        if(value==2) model = 'c';
        $("#"+model).show();
        var margin = (100/3)*value + '%';
        $("p.underline").animate({'margin-left': margin}, 100);
    });
    /*查看订单详情*/
    $("#content").on('tap', '.lookInfo', function(event) {
        event.preventDefault();
        $(event.target).parents('.btns').siblings('.goods').toggle();
    });
    /*联系商家*/
    $("#content").on('tap', '.tel', function(e) {
        window.location.href = "tel:" + $(e.target).data('tel');
    });
    function down(min , sec , el){
        $(el).parents('.order').find('.remainTime').text(min + ":" +sec);
        var drop= setTimeout(function(){
            sec--;
            if(sec<1){
                min--;
                if(min<0){
                    min = '00';
                    sec = '00';
                    $(el).parents('.order').find('.remainTime').text(min + ":" +sec);
                    clearTimeout(drop)
                    //在这里写删除订单的程序,el即为初始的时间元素
                    window.location.href="/user/orderPage.action"
                }else{
                    sec = 59;
                }
                if(min<10) min = '0' + min;
            }else if(sec<10){
                sec = '0'+sec;
            }
            $(el).parents('.order').find('.remainTime').text(min + ":" +sec);
            down(min,sec,el);
        }, 1000)
    }
    /*
     拿到所有<span class="time">值，并对其解析做倒计时
     */
    $(function(){
        var times = document.getElementsByClassName('orderTime');
        for(var i = 0 ;i<times.length;i++){
            var hourAndSec = times[i].innerText.split(':')
            var date = new Date();
            date.setHours(hourAndSec[0],hourAndSec[1] ,0);
            timeDown(date,times[i]);
        }
    })
</script>
</body>
</html>