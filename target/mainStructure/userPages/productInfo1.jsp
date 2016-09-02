
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>商品详情</title>
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <!-- 移动设备支持 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <link href="/asset/user/css/mall.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/asset/main/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/asset/user/js/jquery.Spinner.js"></script>

</head>

<body class="body_color">
<div class="mall_main">
    <div id="child_header">
        <div class="goback"><a href="javascript:history.back(-1)"><i></i></a></div>
        <div class="current_location"><span>商品详情</span></div>
    </div>

    <div id="banner_box" class="box_swipe">
        <ul>
            <li><img src="/asset/user/images/1.jpg"></li>
            <li><img src="/asset/user/images/2.jpg"></li>
            <li><img src="/asset/user/images/3.jpg"></li>
            <li><img src="/asset/user/images/4.jpg"></li>
        </ul>
        <ol>
            <li class="on"></li>&nbsp;
            <li></li>&nbsp;
            <li></li>&nbsp;
            <li></li>&nbsp;
        </ol>
    </div>
    <a class="praise_icon" href="#">2658</a>
    <div class="des_goods">
        <p>水果礼盒 山东红富士85#苹果 果径80-85mm 15只装 约10斤礼盒装 </p>
        <p><span class="sp_style1">皮薄爽脆 口口诱人</span><em class="em_integral">积分：20</em></p>
        <p><span class="pr">原价</span><span class="sp_style2">¥550</span></p>
        <p><span class="pr">促销价</span><span class="sp_style3">¥398</span></p>
        <p><span class="pr">促销有效期</span><span>2015-11-01~2015-11-30</span></p>
        <p><span class="pr">服务</span><span>由微分销销售和发货并提供售后服务</span></p>
        <p><span class="pr">运费</span><span>深圳至无锡</span><span>快递：6.00</span><span>EMS：14.00</span></p>
        <hr/>
        <div class="spec_select">
            <ul>
                <li>
                    <span>商品规格</span>
                    <em class="click">HX6730</em>
                    <em>HX6731</em>
                    <em>HX6732</em>
                </li>
                <li>
                    <span>颜色</span>
                    <em class="click">白色</em>
                    <em>蓝色</em>
                    <em>粉色</em>
                </li>
            </ul>
        </div>
        <hr/>
        <div class="goods_activity">
            <p><span class="pr">备注</span><a href=""><span class="sp_style3">满200减10 满599减30</span></a></p>
            <div class="num">
                <span>数量</span>
                <span id="a" class="Spinner"></span>
                <span>库存50套</span>
            </div>
            <p><span class="pr">服务承诺</span><span>7天无理由退货 正品保证</span></p>
            <p class="pay_type"><span class="pr">支付类别</span><span><i class="pay01"></i>信用卡</span><span><i class="pay02"></i>快捷支付</span><span><i class="pay03"></i>微信支付</span></p>
        </div>
    </div>

    <div class="box_list">
        <ul class="box_nav">
            <li class="current"><a>商品详情</a></li>
            <li><a>评论(230)</a></li>
            <li><a>成交记录</a></li>
            <li><a>商品咨询</a></li>
        </ul>
        <div class="goods_box">
            <img src="/asset/user/images/1.jpg" width="100%">
            <img src="/asset/user/images/2.jpg" width="100%">
            <img src="/asset/user/images/3.jpg" width="100%">
            <img src="/asset/user/images/4.jpg" width="100%">
        </div>
        <div class="goods_box" style="display: none">
            <h3>累计评价(25)：</h3>
            <div class="evaluate">
                <span>18762678928</span><span class="text_t">2015-10-19</span>
                <p>速度快，服务周到</p>
                <hr/>
            </div>
            <div class="evaluate">
                <span>18762678928</span><span class="text_t">2015-10-19</span>
                <p>速度快，服务周到速度快，服务周到速度快，服务周到速度快，服务周到速度快，服务周到</p>
                <hr/>
            </div>
            <div class="evaluate">
                <span>18762678928</span><span class="text_t">2015-10-19</span>
                <p>速度快，服务周到</p>
                <hr/>
            </div>
        </div>
        <div class="goods_box" style="display: none">
            <div class="deal_list">
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
                <p><span>18762678928</span> <span>1<em>[xl,深蓝]</em></span><span>2015-12-04</span></p>
            </div>
        </div>
        <div class="goods_box" style="display: none">
            <div class="ask_list">
                <textarea></textarea>
                <input class="btn_remove" type="button" value="提交"/>
            </div>
        </div>
    </div>
    <div class="bottomdiv clearfix">
        <div class="inner clearfix">
            <div class="fl btn_sure">
                <a href="">立即购买</a>
            </div>
            <div class="fl btn_buy_detail">
                <a class="addshop_cat">加入购物车</a>
            </div>
        </div>

    </div>
</div>
<script src="/asset/user/js/swipe2.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function(){
        new Swipe(document.getElementById('banner_box'), {
            speed: 500,
            auto: 3000,
            callback: function(){
                var lis = $(this.element).next("ol").children();
                lis.removeClass("on").eq(this.index).addClass("on");
            }
        });
    });
</script>
<script type="text/javascript">
    $(function(){
        $(".spec_select ul li em").click(function(){
            $(this).addClass("click").siblings().removeClass("click");
        })
    })
</script>
<!--商品数量加减-->
<script type="text/javascript">
    $(function(){
        $("#a").Spinner({value:1, min:0, len:3, max:10000});
    });
</script>
<script type="text/javascript">
    jQuery(function($){
        $('.box_list ul li').click(function(){
            var index = $('.box_list ul li').index(this);
            $(this).addClass('current').siblings('li').removeClass('current');
            $('.box_list .goods_box:eq('+index+')').show().siblings('.goods_box').hide();
        })
    })
</script>
</body>
</html>
