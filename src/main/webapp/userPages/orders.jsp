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
        <a class="iconfont home" href="/user/index.dhtml">&#xe60e;</a >
    </h1>
</header>

<div id="content">
    <!-- nav part -->
    <nav>
        <ul id="category">
            <li class="0">全部 (<span class="all0"><s:property value="allOrders.size()"/></span>)</li>
            <li class="1">进行中 (<span class="pending1"><s:property value="tradingOrders.size()"/></span>)</li>
            <li class="2">已完成 (<span class="complete2"><s:property value="completeOrders.size()"/></span>)</li>
        </ul>
        <p class="underline"></p>
        <div style="clear:both"></div>
    </nav>

    <!-- orders part -->
    <div id="a" class="model">
        <s:iterator value="allOrders" var="order">
            <s:if test="#order.order!=null">
            <section class="order <s:property value="#order.order.id"/> ">
                <h3>
                    <span class="name"><s:property value="#order.order.seller.name"/> </span>
                    <s:if test="#order.order.state==-1">
                         <span class="state waitMoney">剩余付款时间
						    <span class="remainTime"><s:property value="#order.order.ordertime.substring(11)"/> </span>
					    </span>
                    </s:if>
                    <s:elseif test="#order.order.state==0">
                        <span class="state accepted">下单成功,等待商家接单</span>
                    </s:elseif>
                    <s:elseif test="#order.order.state==1">
                        <span class="state accepted">商家已接单</span>
                    </s:elseif>
                    <s:elseif test="#order.order.state==2">
                        <span class="state">交易成功</span>
                    </s:elseif>
                    <s:elseif test="#order.order.state==3">
                        <span class="state">交易失败</span>
                    </s:elseif>
                </h3>
                <p>
                    <span class="num">订单号：<s:property value="#order.order.id"/></span>
                    <span class="time"><s:property value="#order.order.ordertime.substring(0,16)"/></span>
                </p>
                <p>
                        <span class="info">
                            共计 <s:property value="#order.order.num"/> 本书
                            <s:if test="#order.order.payWay==0">
                                <span class="pay cash">（货到付款）</span>
                            </s:if>
                            <s:elseif test="#order.order.payWay==2">
                                 <span class="pay wechat">(微信支付)</span>
                            </s:elseif>
                            <s:else>
                                <span class="pay alipay">（支付宝支付）</span>
                            </s:else>
                        </span>
                    <span class="price"><s:property value="#order.order.totalFee"/></span>
                </p>
                <div class="goods">
                    <ul>
                        <s:iterator value="#order.order.orderitems" var="orderitem">
                            <li>
                                <span class="iconfont dot">&#xe625;</span>
                                <span class="title"><s:property value="#orderitem.book.title"/> </span>
                                <s:if test="#orderitem.salesBook==null">
                                    <span class="price"><s:property value="@@round(#orderitem.book.price*0.82*10)/10d"/></span>
                                </s:if>
                                <s:else>
                                    <span class="price"><s:property value="#orderitem.salesBook.price"/></span>
                                </s:else>
                                <span class="amount"><s:property value="#orderitem.num"/></span>
                            </li>
                        </s:iterator>
                    </ul>
                </div>
                <ul class="btns">
                    <li>
                        <button class="tel" data-tel="<s:property value="#order.order.seller.tel"/>">联系商家</button>
                    </li>
                    <li>
                        <button class="lookInfo">查看详情</button>
                    </li>
                    <s:if test="#order.order.state==2||#order.order.state==3">
                        <li>
                            <button class="delOrder delBtn">删除记录</button>
                            <input type="hidden" class="orderId" value="<s:property value="#order.order.id"/>">
                        </li>
                    </s:if>
                </ul>
                <div style="clear:both"></div>
            </section>
            </s:if>
            <s:else>
            <section class="order">
                <h3>
                    <span class="name">待付款订单</span>
                         <span class="state waitMoney">剩余付款时间
						    <span class="remainTime"><s:property value="#order.ordertime.substring(11)"/> </span>
					    </span>
                </h3>
                <p>
                    <span class="num">订单编号：<s:property value="#order.orderNo"/></span>
                    <span class="time"><s:property value="#order.ordertime.substring(0,10)"/> <span class="orderTime"><s:property value="#order.ordertime.substring(10,16)"/></span></span>
                </p>
                <p>
                        <span class="infoa">
                            共计 <s:property value="#order.totalNum"/> 本书
                        </span>
                    <span class="price"><s:property value="@@round(#order.totalFee*10)/10d"/></span>
                </p>
                <div class="goods">
                    <ul>
                        <s:iterator value="#order.orderList" var="indexOrder">
                        <s:iterator value="#indexOrder.orderitems" var="orderitem">
                            <li>
                                <span class="iconfont dot">&#xe625;</span>
                                <span class="title"><s:property value="#orderitem.book.title"/> </span>
                                <s:if test="#orderitem.salesBook==null">
                                    <span class="price"><s:property value="@@round(#orderitem.book.price*0.82*10)/10d"/></span>
                                </s:if>
                                <s:else>
                                    <span class="price"><s:property value="#orderitem.salesBook.price"/></span>
                                </s:else>
                                <span class="amount"><s:property value="#orderitem.num"/></span>
                            </li>
                        </s:iterator>
                        </s:iterator>
                    </ul>
                </div>
                <ul class="btns">
                    <li>
                        <button class="payNow pay">立即支付</button>
                        <input type="hidden" class="orderNo" value="<s:property value="#order.orderList[0].orderNo"/>">
                    </li>
                    <li>
                        <button class="lookInfo">查看详情</button>
                    </li>
                     <li>
                         <button class="delBtn cancelOrder">取消订单</button>
                         <input type="hidden" class="orderNo" value="<s:property value="#order.orderList[0].orderNo"/>">
                     </li>
                </ul>
                <div style="clear:both"></div>
            </section>
            </s:else>

        </s:iterator>
    </div>

     <div id="b" class="model">
         <s:iterator value="tradingOrders" var="order">
             <section class="order <s:property value="#order.order.id"/>">
                 <h3>
                     <span class="name"><s:property value="#order.order.seller.name"/> </span>
                     <s:if test="#order.state==-1">
                        <span class="state waitMoney">剩余付款时间
						    <span class="remainTime"><s:property value="#order.order.ordertime.substring(11)"/> </span>
					    </span>
                     </s:if>
                     <s:elseif test="#order.order.state==0">
                         <span class="state accepted">下单成功,等待商家接单</span>
                     </s:elseif>
                     <s:elseif test="#order.order.state==1">
                         <span class="state accepted">商家已接单</span>
                     </s:elseif>
                     <s:elseif test="#order.order.state==2">
                         <span class="state">交易成功</span>
                     </s:elseif>
                     <s:elseif test="#order.order.state==3">
                         <span class="state">交易失败</span>
                     </s:elseif>
                 </h3>
                 <p>
                     <span class="num">订单号：<s:property value="#order.order.id"/></span>
                     <span class="time"><s:property value="#order.order.ordertime.substring(0,16)"/></span>
                 </p>
                 <p>
                        <span class="info">
                            共计 <s:property value="#order.order.num"/> 本书
                            <s:if test="#order.order.payWay==0">
                                <span class="pay cash">（货到付款）</span>
                            </s:if>
                            <s:elseif test="#order.order.payWay==2">
                                <span class="pay wechat">(微信支付)</span>
                            </s:elseif>
                            <s:else>
                                <span class="pay alipay">（支付宝支付）</span>
                            </s:else>
                        </span>
                     <span class="price"><s:property value="#order.order.totalFee"/></span>
                 </p>
                 <div class="goods">
                     <ul>
                         <s:iterator value="#order.order.orderitems" var="orderitem">
                             <li>
                                 <span class="iconfont dot">&#xe625;</span>
                                 <span class="title"><s:property value="#orderitem.book.title"/> </span>
                                 <s:if test="#orderitem.salesBook==null">
                                     <span class="price"><s:property value="@@round(#orderitem.book.price*0.82*10)/10d"/></span>
                                 </s:if>
                                 <s:else>
                                     <span class="price"><s:property value="#orderitem.salesBook.price"/></span>
                                 </s:else>

                                 <span class="amount"><s:property value="#orderitem.num"/></span>
                             </li>
                         </s:iterator>
                     </ul>
                 </div>
                 <ul class="btns">
                     <li>
                         <button class="tel" data-tel="<s:property value="#order.order.seller.tel"/>">联系商家</button>
                     </li>
                     <li>
                         <button class="lookInfo">查看详情</button>
                     </li>
                     <s:if test="#order.order.state==2||#order.order.state==3">
                         <li>
                             <button class="delOrder delBtn">删除记录</button>
                             <input type="hidden" class="orderId" value="<s:property value="#order.order.id"/>">
                         </li>
                     </s:if>
                 </ul>
                 <div style="clear:both"></div>
             </section>
         </s:iterator>
    </div>

    <div id="c" class="model">
        <s:iterator value="completeOrders" var="order">
            <section class="order <s:property value="#order.order.id"/>">
                <h3>
                    <span class="name"><s:property value="#order.order.seller.name"/> </span>
                    <s:if test="#order.order.state==-1">
                       <span class="state waitMoney">剩余付款时间
						    <span class="remainTime"><s:property value="#order.order.ordertime.substring(11)"/> </span>
					    </span>
                    </s:if>
                    <s:elseif test="#order.order.state==0">
                        <span class="state accepted">下单成功,等待商家接单</span>
                    </s:elseif>
                    <s:elseif test="#order.order.state==1">
                        <span class="state accepted">商家已接单</span>
                    </s:elseif>
                    <s:elseif test="#order.order.state==2">
                        <span class="state">交易成功</span>
                    </s:elseif>
                    <s:elseif test="#order.order.state==3">
                        <span class="state">交易失败</span>
                    </s:elseif>
                </h3>
                <p>
                    <span class="num">订单号：<s:property value="#order.order.id"/></span>
                    <span class="time"><s:property value="#order.order.ordertime.substring(0,16)"/></span>
                </p>
                <p>
                        <span class="info">
                            共计<s:property value="#order.order.num"/> 本书
                             <s:if test="#order.order.payWay==0">
                                 <span class="pay cash">（货到付款）</span>
                             </s:if>
                            <s:elseif test="#order.order.payWay==2">
                                <span class="pay wechat">(微信支付)</span>
                            </s:elseif>
                            <s:else>
                                <span class="pay alipay">（支付宝支付）</span>
                            </s:else>
                        </span>
                    <span class="price"><s:property value="#order.order.totalFee"/></span>
                </p>
                <div class="goods">
                    <ul>
                        <s:iterator value="#order.order.orderitems" var="orderitem">
                            <li>
                                <span class="iconfont dot">&#xe625;</span>
                                <span class="title"><s:property value="#orderitem.book.title"/> </span>
                                <s:if test="#orderitem.salesBook==null">
                                    <span class="price"><s:property value="@@round(#orderitem.book.price*0.82*10)/10d"/></span>
                                </s:if>
                                <s:else>
                                    <span class="price"><s:property value="#orderitem.salesBook.price"/></span>
                                </s:else>

                                <span class="amount"><s:property value="#orderitem.num"/></span>
                            </li>
                        </s:iterator>
                    </ul>
                </div>
                <ul class="btns">
                    <li>
                        <button class="tel" data-tel="<s:property value="#order.order.seller.tel"/>">联系商家</button>
                    </li>
                    <li>
                        <button class="lookInfo">查看详情</button>
                    </li>
                    <s:if test="#order.order.state==2||#order.order.state==3">
                        <li>
                            <button class="delOrder delBtn">删除记录</button>
                            <input type="hidden" class="orderId" value="<s:property value="#order.order.id"/>">
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
        var url = '/user/userDelOrder.dhtml';
        var allNum = parseInt($(".all0").text().trim());
        var completeNum = parseInt($(".complete2").text().trim());
        var args= {"id":orderId};
        var $target = $(this).parent().parent().parent();
        $.post(url,args, function (data) {
            if(data=="success"){
                $(".all0").text(--allNum);
                $("."+orderId).remove();
                $(".complete2").text(--completeNum)
                console.log(data);
                $target.remove();
            }
        })
    });
    $(".cancelOrder").click(function () {
        var orderId = $(this).siblings(".orderNo").val();
        var url = '/user/cancelOrder.dhtml';
        var allNum = parseInt($(".all0").text().trim());
        var args= {"orderNo":orderId};
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
        var url = '/user/payNow.dhtml';
        window.location.href="/user/payNow.dhtml?orderNo="+orderId;
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