<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>支付</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link href="/asset/user/css/bootstrap.min.css" rel="stylesheet">
    <link href="/asset/user/css/style.css" rel="stylesheet">
    <link href="/asset/user/css/iconfont/iconfont.css" rel="stylesheet">
    <link rel="stylesheet" href="/asset/user/css/app.css">
    <link rel="stylesheet" href="/asset/user/css/sweetalert.css">
    <script type="text/javascript" src="/asset/main/js/jquery_min1_11_2.js"></script>
    <script type="text/javascript" src="/asset/main/js/zepto.js"></script>
    <script type="text/javascript" src="/asset/user/js/sweetalert-dev.js"></script>

</head>
<body class="bgf7 item">
<div class="container">
    <div class="row">
        <div class="col-xs-12 clearPadding">
            <div class="ptb10 plr15 bg-white mt10 clearfix" id="changedetail">
                <div class="col-xs-1 clearPadding"><i class="iconfont text-dining">&#xe601;</i></div>
                <div class="col-xs-10 clearPadding basedetail">
                    <div id="username" class="col-xs-7 "><s:property value="user.name"/></div>
                    <div id="usertel" class="col-xs-5 "><s:property value="user.tel"/></div>
                </div>
                <div id="useraddr" class="col-xs-10 clearPadding" style="padding-left: 15px">
                    <s:if test="user.addr==null||user.addr==''">选择收货地址</s:if>
                    <s:else><s:property value="user.addr"/></s:else>
                </div>
                <div class="col-xs-1 clearPadding locationicon"><i class="iconfont pull-right">&#xe606;</i></div>
            </div>
            <div class="ptb10 plr15 bg-white mt10 clearfix" id="ordertime-div">
                    <div class="col-xs-1 clearPadding"><i class="iconfont text-dining">&#xe603;</i></div>
                    <div id="ordertime" class="col-xs-6 clearPadding" style="padding-left: 15px">选择配送时间 </div>
                    <div class="col-xs-4 " id="deliverTime" STYLE="color:#FF6600;">尽快</div>
                    <div class="col-xs-1 clearPadding locationicon"><i class="iconfont pull-right">&#xe606;</i></div>
            </div>
            <div class="mt10 bg-white">
                <div id="paystyle">
                    <div class="ptb10 plr15 borderbottom">
                        <span>货到付款</span><i class="iconfont pull-right text-dining">&#xe609;</i>
                    </div>
                </div>

                <div class="ptb10 plr15 borderbottom">
                    <div class="pb10">订单备注</div>
                    <textarea name="" id="remark" cols="10" rows="3" class="form-control font12" placeholder="请输入您要交待给我们的事情"></textarea>
                </div>

            </div>
            <div class="mt15 bg-white">
                <s:iterator value="orderitems" var="orderitem">
                <div class="plr15 ptb10 clearfix borderbottom">
                    <div class="col-xs-8 clearPadding"><s:property value="#orderitem.product.name"/></div>
                    <div class="col-xs-2 clearPadding text-center">×<s:property value="#orderitem.num"/></div>
                    <div class="col-xs-2 clearPadding text-right">￥<s:property value="#orderitem.fee"/></div>
                </div>
                </s:iterator>
                <div class="plr15 ptb10 text-dining">
                    <span class="text-dining">配送费</span><span class="pull-right">￥<s:property value="deliverFee"/></span>
                </div>
            </div>
            <div class="pl15 clearfix bg-white bordertop mt10 bottoms order-div">
                <div class="col-xs-8 clearPadding text-dining pt18">总价：￥<s:property value="order.totalFee"/></div>
                <div class="col-xs-4 clearPadding">
                    <button class="bg-dining bordernone ptb15lr20 font18 btn-block text-white" id="confirmOrder" type="submit">确认下单</button>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="orderId" value="<s:property value="order.id"/>">
<section class="layer order-addr">
    <div class="content">
        <div class="head">
            <span class="contenttext pull-right" >填写地址</span>
            <a class="close pull-right"></a>
        </div>
        <div class="bd">
            <div class="form-group">
                <label class="sr-only" for="inputname">小明</label>
                <div class="input-group">
                    <div class="input-group-addon">姓名&nbsp;&nbsp;&nbsp;&nbsp;</div>
                    <input type="text" class="form-control" id="inputname" placeholder="">
                </div>
            </div>
            <div class="form-group">
                <label class="sr-only" for="inputtel">eg:131......</label>
                <div class="input-group">
                    <div class="input-group-addon">手机号</div>
                    <input type="text" class="form-control" id="inputtel" pattern="^1[345678][0-9]{9}$" required placeholder="131......">
                </div>
            </div>
            <div class="form-group">
                <label class="sr-only" for="inputaddr">xx校xx楼206</label>
                <div class="input-group">
                    <div class="input-group-addon">地址&nbsp;&nbsp;&nbsp;&nbsp;</div>
                    <input type="text" class="form-control" id="inputaddr" placeholder="xx校xx楼206">
                </div>
            </div>
        </div>
        <div class="foot"><a class="next" id="addr-confirm"  data-id=10 href="">确认</a></div>
    </div>

</section>
<section class="layer order-time">
    <div class="content">
        <div class="head">
            <span class="contenttext pull-right" >填写配送时间</span>
            <a class="close pull-right"></a>
        </div>
        <div class="bd">
            <div class="form-group" style="padding-bottom: 5%">
                <label class="sr-only" for="inputname"></label>
                <div class="input-group">
                    <div class="input-group-addon">时间&nbsp;&nbsp;&nbsp;&nbsp;</div>
                    <select id="select-time"  class="form-control" placeholder="">
                        <option selected>尽快</option>
                        <option>中午12点</option>
                        <option>下午5点</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="foot"><a class="next" id="time-confirm" data-id=10 href="">确定</a></div>
    </div>

</section>
<script>
    $('#paystyle div').click(function(){
        $(this).find('i').addClass('text-dining').removeClass('text-grey');
        $(this).siblings().find('i').removeClass('text-dining').addClass('text-grey');
    });
</script>
<script type="text/javascript">
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
        $('#changedetail').on('touchend',function(ev){
            ev.preventDefault();
            $("#inputname").val($("#username").text().trim())
            if($("#useraddr").text().trim()!="选择收货地址"){
                $("#inputaddr").val($("#useraddr").text().trim())
            }
            $("#inputtel").val($("#usertel").text().trim()  )
            $(".order-div").hide();
            $('.order-addr').addClass('acitve');
        })
        $('.close').on('touchend',function(ev){
            ev.preventDefault();
            $(".order-div").show();
            $('.order-addr').removeClass('acitve');
            $('.order-time').removeClass('acitve');
        });

        $('#ordertime-div').on('touchend',function(ev){
            ev.preventDefault();
            $(".order-div").hide();
            $('.order-time').addClass('acitve');
        })

        $('#addr-confirm').on('touchend',function(ev){
            ev.preventDefault();
            var inputName = $("#inputname").val().trim();
            var inputAddr = $("#inputaddr").val().trim();
            var inputTel = $("#inputtel").val().trim();
            if(inputName==''||inputTel==''||!checkMobile(inputTel)||inputAddr==''){
                if(inputName==''){
                    $("#inputname").attr("placeholder","用户名不能为空")
                }
                if(inputAddr==''){
                    $("#inputaddr").attr("placeholder","地址不能为空")
                }
                if(inputTel==''||!checkMobile(inputTel)){
                    $("#inputtel").val("")
                    $("#inputtel").attr("placeholder","手机号格式错误")
                }
                return;
            }
            $("#useraddr").text(inputAddr);
            $("#username").text(inputName);
            $("#usertel").text(inputTel);
            $(".order-div").show();
            $('.order-addr').removeClass('acitve');
            $('.order-time').removeClass('acitve');
        })
        $('#time-confirm').on('touchend',function(ev){
            ev.preventDefault();
            $(".order-div").show();
            $("#deliverTime").text($("#select-time").find("option:selected").text());
            $('.order-addr').removeClass('acitve');
            $('.order-time').removeClass('acitve');
        })
        $("#confirmOrder").on('click',function () {
            var inputAddr = $("#useraddr").text().trim();
            var inputName = $("#username").text().trim();
            var inputTel = $("#usertel").text().trim();
            var orderId = $("#orderId").val();
            var deliverTime = $("#deliverTime").text().trim();
            var remark = "(配送时间:"+deliverTime+"),备注:"+$("#remark").val();
            console.log(orderId);
            console.log(remark);
            if(inputName==''||inputTel==''||!checkMobile(inputTel)||inputAddr==''){
                swal("" ,"请先完善地址信息", "error");
                return;
            }
            $.post("/user/orderSubmit.action",{"id":orderId,"name":inputName,"addr":inputAddr,"tel":inputTel,"remark":remark},function (data) {
                if(data=='success'){
                    window.location.href="/user/orderPage.action"
                }
            })

        })

    })
    function  checkMobile(str) {
        var re = /^1\d{10}$/
        if (re.test(str)) {
            return true;
        } else {
            return false;
        }
    }

</script>
</body>
</html>
