<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <title>订单信息</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8" />
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="yes" name="apple-touch-fullscreen"/>
    <meta content="telephone=no" name="format-detection"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="#ffffff" name="msapplication-TileColor" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/orderInfo.css">
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/animate.css">
    <link rel="stylesheet" type="text/css" href="/asset/userAsset/css/weui.min.css">
    <link type="text/css" rel="stylesheet" href="/asset/userAsset/css/base.css">
</head>
<body>
<!-- 隐藏订单编号  -->
<span style="display:none" id="orderNo"><s:property value="order.id"/></span>
<header>
    <h1>
        <a class="iconfont back" href="javascript:window.history.go(-1)"></a>
        订单信息
    </h1>
</header>
<div id="content-footer" class="animated">
    <section id="content">
            <s:if test="user.addr!=null">
            <div id="address" style="display: block">
                <b class="top-line"></b>
                <div class="addrDiv">
                    <span class="iconfont addr">&#xe620;</span>
                </div>
                <ul class="info">
                    <li id="name-tel">
                        <s:property value="user.name"/>&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="user.tel"/>
                    </li>
                    <li id="addr">
                        <s:property value="user.addr"/>
                    </li>
                </ul>
                <div class="moreDiv">
                    <span class="iconfont more">&#xe622;</span>
                </div>
                <b class="bottom-line"></b>
            </div>
                <div id="addAddress" style="display: none">
                        <p>
                            <span class="iconfont remark">&#xe629;</span>
                            添加收货地址
                            <span class="iconfont more">&#xe622;</span>
                        </p>
                </div>
            </s:if>
            <s:if test="user.addr==null">
                 <div id="addAddress" style="display: block" >
                    <p>
                        <span class="iconfont remark">&#xe629;</span>
                        添加收货地址
                        <span class="iconfont more">&#xe622;</span>
                    </p>
                </div>
                <div id="address" style="display: none">
                    <b class="top-line"></b>
                    <div class="addrDiv">
                        <span class="iconfont addr">&#xe620;</span>
                    </div>
                    <ul class="info">
                        <li id="name-tel">
                            <s:property value="user.name"/>&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="user.tel"/>
                        </li>
                        <li id="addr">
                            <s:property value="user.addr"/>
                        </li>
                    </ul>
                    <div class="moreDiv">
                        <span class="iconfont more">&#xe622;</span>
                    </div>
                    <b class="bottom-line"></b>
                </div>
             </s:if>
        <div id="pay">
            <ul>
                <li >
                    <span class="iconfont logo cash">&#xe623;</span>货到付款
                    <span class="iconfont check cashCheck"></span>
                    <span class="info">另加运费 ￥<s:property value="#session.seller.deliveryFee"/></span>
                </li>
                <li style="display: none">
                    <span class="iconfont logo alipay">&#xe621;</span>支付宝支付
                    <span class="iconfont check"></span>
                </li>
                <li style="display: none">
                    <span class="iconfont logo weichat">&#xe60a;</span>微信支付
                    <span class="iconfont check">&#xe61f;</span>
                </li>
            </ul>
        </div>
        <div id="goods">
            <ul>
                    <s:iterator value="orderitems" var="orderitem">
                        <li>
                            <span class="iconfont dot">&#xe625;</span>
                            <span class="title"><s:property value="#orderitem.product.name"/></span>
                            <span class="price"><s:property value="#orderitem.product.price"/></span>
                            <span class="amount"><s:property value="#orderitem.num"/></span>
                        </li>
                    </s:iterator>
            </ul>
        </div>
        <div id="remark">
            <p>
                <span class="iconfont remark">&#xe626;</span>
                备注(填写配送时间或者其他要求)
                <span class="iconfont more">&#xe622;</span>
                <span class="remark-content">添加备注</span>
            </p>
        </div>
    </section>
    <footer>
        <p>
            <span class="totalAmount"><s:property value="num"/></span>
            <span class="totalPrice"><s:property value="order.totalFee"/></span>
        </p>
        <button id="confirmOrder">确定下单</button>
    </footer>
</div>

<!-- 添加备注部分 -->
<section id="addMark" class="animated">
    <textarea autofocus maxLength="40"></textarea>
    <button id="confirmMark">确定</button>
</section>

<section id="receivingInfo" class="animated">
    <div class="userInfo">
        <p>
            <label for="name">姓名：</label>
            <input type="text" id="name" placeholder="请填写收货人姓名" value="<s:property value="user.name"/>" maxlength="7" autofocus>
        </p>
        <p>
            <label for="tel">手机：</label>
            <input type="tel" maxlength="11" id="tel" value="<s:property value="user.tel"/>" placeholder="请填写收货人手机号码">
        </p>
        <p>
            <label for="input-addr">地址：</label>
            <input type="text" id="input-addr" value="<s:property value="user.addr"/>"  placeholder="请填写收货人地址" maxlength="20">
        </p>
    </div>
    <button id="confirmMyInfo">确定</button>
</section>
<footer>
    <div class="h50"></div>
    <ul class="bottom_nav w tc">
        <li><a href="javascript:window.history.go(-1)">返回</a></li>
        <li><a href="/user/index.action"></a></li>
        <li><a href="/user/orderPage.action">我的订单</a></li>
    </ul>
</footer>
<!— 验证码弹框 —>
<section id="model" style="display: none">
    <div id="checkBox" class="animated ">
        <div class="title">用户手机验证
            <span class="iconfont close">&#xe62b;</span>
        </div>
        <p class="input-box">
            <input type="tel" maxLength="4" id="checkCode" placeholder="请输入4位短信验证码" autofocus>
            <button type="button" class="getCheckCodeAgain noUse">已发送(<span id="time">30</span>s)</button>
        </p >
        <button id="submitVertify">提交验证</button>
    </div>
</section>

<section id="box" class="animated fadeInUp">
    <p>请填写收获地址~</p>
</section>
<div id="loadingToast" class="weui_loading_toast" style="display:none;">
    <div class="weui_mask_transparent"></div>
    <div class="weui_toast">
        <div class="weui_loading">
            <!-- :) -->
            <div class="weui_loading_leaf weui_loading_leaf_0"></div>
            <div class="weui_loading_leaf weui_loading_leaf_1"></div>
            <div class="weui_loading_leaf weui_loading_leaf_2"></div>
            <div class="weui_loading_leaf weui_loading_leaf_3"></div>
            <div class="weui_loading_leaf weui_loading_leaf_4"></div>
            <div class="weui_loading_leaf weui_loading_leaf_5"></div>
            <div class="weui_loading_leaf weui_loading_leaf_6"></div>
            <div class="weui_loading_leaf weui_loading_leaf_7"></div>
            <div class="weui_loading_leaf weui_loading_leaf_8"></div>
            <div class="weui_loading_leaf weui_loading_leaf_9"></div>
            <div class="weui_loading_leaf weui_loading_leaf_10"></div>
            <div class="weui_loading_leaf weui_loading_leaf_11"></div>
        </div>
        <p class="weui_toast_content">正在加载,请稍候...</p>
    </div>
</div>
<!--分类弹框-->
<div id="popoverList" style="display:none">
    <div class="list-modal">
        <ul id="list">
            <li class="item" v-repeat="c in categories">
                <a href="{{c.url}}">{{c.name}}</a>
            </li>
        </ul>
        <p id="cancel" v-touch="tap:cancel">取消</p>
    </div>
</div>
<script type="text/javascript" src="/asset/userAsset/js/hammer.min.js"></script>
<script src="http://cdn.bootcss.com/vue/0.12.16/vue.min.js"></script>
<script type="text/javascript" src="/asset/userAsset/js/zepto+.js"></script>
<script type="text/javascript" src="/asset/userAsset/js/vue-touch.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    $(function(){
        //<3> 请求微信付 支付完成后跳转至 myOrders.html 页面

        //为底部菜单栏添加链接


        //添加分类交互

        /* 弹出框的基本方法封装 */
        //弹出
        var list = $("#popoverList");
        var popList = {
            show: function() {
                list.css({
                    'display': 'flex',
                    'display': '-ms-flexbox',
                    'display': '-webkit-flex',
                    'display': '-webkit-box'
                });
                $('html').toggleClass('alpha');
            },
            hide: function() {
                list.css('display', 'none');
                $('html').toggleClass('alpha');
            }
        }
        //为类别项绑定 vue 对象


        //为弹框中的close键绑定事件
        var close = new Hammer(document.getElementsByClassName('close')[0]);
        close.on('tap',function(){
            //关闭弹框
            $("#model").hide();
        })


        //为Back键绑定事件
        var back_hammer = new Hammer(document.getElementsByClassName('back')[0])
        back_hammer.on('tap',function(e){
            e.preventDefault
            if($("#content-footer").css('display')!='none') history.go(-1)
            else{
                //当前在分页面
                var parts = document.getElementsByClassName('animated');
                for(var i = 0;i<parts.length;i++){
                    if($(parts[i]).css('display')!='none'){
                        //这个分页在显示
                        goBack($(parts[i]))
                        break;
                    }
                }
            }
        })

        var payWay = new Number() , address , name , remark , tel;
        var info = {};

        //手机验证码提交校验
        var submitVertify_hammer = new Hammer(document.getElementById('submitVertify'));
        submitVertify_hammer.on('tap',function(){
            //提交验证码
            var checkCode = document.getElementById('checkCode').value;
            var $submitBtn =  $("#submitVertify");
            if(checkCode.length==4){
                //验证码必须为4位 <5> 发起post请求 传输验证码
                var address = $("#input-addr").val().trim();
                var tel = $("#tel").val().trim();
                var name = $("#name").val().trim();
                var remark = $("textarea").val()==''?'':$("textarea").val().trim();
                $submitBtn.css('background-color', '#36903a').attr('disabled', 'disabled').text("正在验证…");
                $.post('/user/checkCode.action', {'code':checkCode,'addr': address,'phone':tel,'orderNo':orderNo,'name':name,'remark':remark}, function(json) {
                    if(json=='success'){
                        //传输数据,验证码校验完成,跳至 myOrders.html
                        window.location.href= "/user/orderPage.action";
                    }else if(json=='handled'){
                        alertMsg("您已经对订单做过处理");
                        window.location.href= "/user/orderPage.action";
                    }
                    else{
                        //验证码错误
                        $submitBtn.css('background-color', '#44b549').attr('disabled', 'false').text("提交验证");
                        $("#checkBox").addClass('wobble').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend', function(){
                            $(this).removeClass('wobble');
                        });
                        $("#checkCode").val("").attr('palceholder','验证码错误');
                    }
                });
            }
        })




        /*
         封装页面跳转动画
         从分页跳到总页：goBack($hidedEl)
         从总页到分页：goPartPage($pageEl)
         */
        function goBack($hidedEl){
            $hidedEl.addClass('flipOutX').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend', function(){
                $(this).hide().removeClass('flipOutX');
                $("#content-footer").show();
            });

            //在back时传输数据
            if($hidedEl.attr('id')=='receivingInfo'){
                //如果用户修改了信息但没有点击确定，back后将信息重置回原来的
                $("#name").val($("#spanName").text().trim());
                $("#tel").val($("#spanTel").text().trim());
                $("#input-addr").val($("#addr").text().trim());
            }
        }

        function goPartPage($pageEl){
            $("#content-footer").addClass('flipOutX').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend', function(){
                $(this).hide().removeClass('flipOutX');
                $pageEl.show();
            });
        }




        //填写收货地址页面跳转动画
        var addAddress = new Hammer(document.getElementById('addAddress'));
        addAddress.on('tap',function(){
            goPartPage($("#receivingInfo"))
        })

        //修改收货地址跳转页面
        var address_hammer = new Hammer(document.getElementById('address'));
        address_hammer.on('tap',function(){
            goPartPage($("#receivingInfo"))
        })


        //确认收货信息校验
        var confirmMyInfo_hammer = new Hammer(document.getElementById('confirmMyInfo'));
        confirmMyInfo_hammer.on('tap',function(){
            var name = document.getElementById('name').value;
            var addr = document.getElementById('input-addr').value;
            var tel = document.getElementById('tel').value

            if(!isPhone(tel)){
                //如果不是手机号码，弹出错误弹框
                alertMsg('请填写正确的手机号码');
                return;
            }else if(name==''){
                alertMsg('收货人姓名不能为空!');
                return ;
            }else if(addr==''){
                alertMsg('收货地址不能为空!');
                return;
            }else{
                //信息填写完成且正确，跳转至前页
                //信息写入前页
                document.getElementById('name-tel').innerHTML = '<span id="spanName">' + name + '</span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanTel">' + tel + "</span>"
                document.getElementById('addr').innerText = addr
                //隐藏掉前边添加地址的<li>
                $("#addAddress").hide();
                $("#address").show();
                //页面跳转动画
                goBack($("#receivingInfo"));
            }
        })

        //手机号码校验函数
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

        //错误弹框显示，封装成函数
        function alertMsg(msg){
            $("#box").children('p').text(msg).parent().show().one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend', function(){
                setTimeout(function(){
                    $("#box").hide();
                }, 1200);
            });
        }


        //“添加备注”过程的动画交互
        var remark_hammer = new Hammer(document.getElementById('remark'))
        remark_hammer.on('tap',function(){
            goPartPage($("#addMark"));
            document.getElementsByTagName('textarea')[0].focus();
        })

        //备注所填内容与content中数据的传递
        var confirmMark_hammer = new Hammer(document.getElementById('confirmMark'));
        confirmMark_hammer.on('tap',function(){
            var remark = document.getElementsByTagName('textarea')[0].value.trim();
            if(remark!=''){
                document.getElementsByClassName('remark-content')[0].innerText = remark.length>12?remark.substring(0,10)+'...':remark;
            }
            goBack($("#addMark"));
        })


        //限制输入框内字符串长度
        function maxLength(el) {
            if (!('maxLength' in el)) {
                var max = el.attributes.maxLength.value;
                el.onkeypress = function () {
                    console.log(this.value.length)
                    if (this.value.length >= max) return false;
                };
            }
        }
        maxLength(document.getElementsByTagName('textarea')[0]);

        //为页面写错误弹框
        var btn_hammer = new Hammer(document.getElementById('confirmOrder'));
        btn_hammer.on('tap',function(){
            /*
             提交订单时的校验
             1. 地址为必填项
             2. 若选择货到付款，验证手机号码
             */
            //检测地址是否填写
            if($("#addAddress").css('display')!='none'){
                //用户未填写地址信息
                alertMsg('请填写收获信息！');
                return false;
            }else{
                var address = $("#input-addr").val().trim();
                var tel = $("#tel").val().trim();
                var name = $("#name").val().trim();
                var remark = $("textarea").val()==''?'':$("textarea").val().trim();
                var orderNo = $("#orderNo").text().trim();
                //判断是否是货到付款
                var cashCheck = document.getElementsByClassName('cashCheck')[0];
                if(cashCheck.innerText!=''){
                    //用户选择的是货到付款,验证手机号码
                    $("#loadingToast").show();
                    //向服务器发起post请求，做 “tel” 校验
                            //号码已有，不需要校验
                            $.post('/user/orderSubmit.action', {'addr': address,'tel':tel,'id':orderNo,'name':name,'remark':remark}, function(data) {
                               if(data=="noLogin"){
                                   window.location.href="/user/huanchong.action?page=2"
                               }else if(data=="error"){
                                    window.location.href="/user/errorPage.action"
                               }else if(data=="notNull"){
                                    alertMsg("请检查您的地址栏")
                               }else if(data=="success"){
                                   window.location.href="/user/orderPage.action"
                               }

                            });
                }else{
                }
            }
        })

        //封装倒计时函数
        function numDown(el){
            var value = el.innerText;
            if(parseInt(value)>0){
                //做倒计时操作
                setTimeout(function(){
                    el.innerText = --value;
                    numDown(el);
                },1000);
            }else{
                // do something after 0
                $(el).parent().css('background-color', '#8cc665').text('重新发送').bind('click',function(event) {
                    //重新发送验证码
                    $(this).text('正在发送...').attr('disabled','disabled');
                    var tel = $("#tel").val().trim();
                    var $btn = $(this)
                    $.post('/user/getTelFromOA.action', {phone: tel}, function(data) {
                        $btn.html('已发送(<span id="time">30</span>s)').css('background-color', '#c1c1c1');
                        numDown(document.getElementById('time'));
                    })
                });;
            }
        }

        //为“check”添加交互
        var pay_hammer = new Hammer(document.getElementById('pay'));
        var haveAddShipment = false;    //若用户选择货到付款方式，要加5元运费
        pay_hammer.on('tap',function(e){
            var target = e.target;
            if(target.tagName=='LI'){
                target = $(target).find('.check')[0];
            }
            if(!$(target).hasClass('check')){
                target = $(target).parents('li').find('.check')[0];
            }
            if(target.className.split(' ')[1]=='check'){
                if(target.innerText==''){
                    //打勾,(只允许一种支付方式被打勾)
                    var checks = document.getElementsByClassName('check');
                    for(var i = 0;i<checks.length;i++){
                        checks[i].innerText = '';
                    }
                    target.innerHTML = '&#xe61f;'
                    //数据变化
                    var totalPrice = document.getElementsByClassName('totalPrice')[0];
                    if($(target).siblings('.logo').attr('class').split(' ')[2]=='cash'){
                        //选择的是货到付款
                        totalPrice.innerText = (parseFloat(totalPrice.innerText)+5).toFixed(2);
                        haveAddShipment = true;
                    }else{
                        //选择的是网上支付
                        if(haveAddShipment){
                            totalPrice.innerText = (parseFloat(totalPrice.innerText)-5).toFixed(2);
                            haveAddShipment = false;
                        }
                    }
                }
            }
        })
    })
</script>
</body>
</html>