package com.wenti.web.action;

/**
 * Created by Administrator on 2016/3/21 0021.
 */

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.*;
import com.wenti.dto.OrderBaseBean;
import com.wenti.dto.UserOrderJsonBean;
import com.wenti.service.*;
import com.wenti.utils.CommonUtils;
import com.wenti.utils.WechatCommon;
import com.wenti.wechat.*;
import com.wenti.wenxin.CommonUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.*;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
@Scope("prototype")
@ParentPackage("user-default")
@Namespace(value="/user")
@Results({
        @Result(name="userJsonLogin",type="json"),
        @Result(name="userActionLogin",location="huanchong",type="redirectAction"),
        @Result(name = "notFound",location="huanchong",type="redirectAction" )
})
@ExceptionMappings({
//        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
})
public class UserOrderAction extends ActionSupport implements ModelDriven<Order>{
    private Order order = new Order();
    public Order getModel() {
        return order;
    }
    private int page;
    private OrderService orderService;
    private UserService userService;
    private CartService cartService;
    private SellerService sellerService;
    private ProductService productService;

    //待处理订单
    @Action(
            value = "pay",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json"),
                    @Result(name = ERROR,type = "json")
            }
    )
    public String pay(){
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        User findUser = userService.getUser(sessionUser.getId());
        List<Cartitem> cartitems = cartService.getEffectiveCartitems(findUser.getId());
        Seller seller = sellerService.getSeller(1);
        if(cartitems.size()<=0){
            writer.write("error");
            writer.flush();
            writer.close();
            return ERROR;
        }
        Order order = new Order();
        try {
        order.setOrdertime(CommonUtils.getNowTime());
        order.setAddr(findUser.getAddr());
        order.setVisible(0);
        order.setName(findUser.getName());
        order.setTel(findUser.getTel());
        order.setUser(findUser);
        order.setSeller(seller);
        order.setState(-1);
        orderService.save(order);
        float productFee = 0;
        for(int i=0;i<cartitems.size();i++){
            Cartitem cartitem = cartitems.get(i);
            Orderitem orderitem = new Orderitem();
            orderitem.setNum(cartitem.getNum());
            orderitem.setOrder(order);
            orderitem.setProductFee(cartitem.getProduct().getPrice());
            orderitem.setProduct(cartitem.getProduct());
            orderService.save(orderitem);
            cartService.del(cartitem);
            productFee += cartitem.getNum()*cartitem.getProduct().getPrice();
        }
        order.setProductFee(productFee);
        float startPrice = seller.getStartingPrice();
        float deliveryFee = seller.getDeliveryFee();
        if(productFee>=startPrice) deliveryFee = 0;
        order.setDeliveryFee(deliveryFee);
        order.setTotalFee(productFee+deliveryFee);
        order.setOrderNo(CommonUtils.getOrderNo(order.getId()));
        orderService.update(order);
        }catch (Exception e){
            orderService.delOrder(order);
            writer.write("error");
            writer.flush();
            writer.close();
            return ERROR;
        }
        writer.write(order.getId()+"");
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "rePay",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json"),
                    @Result(name = ERROR,type = "json")
            }
    )
    public String rePay(){
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        User findUser = userService.getUser(sessionUser.getId());
        Order findOrder = orderService.getOrder(order.getId());
        if(findOrder==null||!findOrder.getState().equals(-1)){
            writer.write("error");
            writer.flush();
            return ERROR;
        }
        String orderNo = CommonUtils.getOrderNo(findOrder.getId());
        findOrder.setOrderNo(orderNo);
        orderService.update(findOrder);
        writer.write(findOrder.getId()+"");
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "payPage",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/pay.jsp")
            }
    )
    public String payPage(){
        order = orderService.getOrder(order.getId());
        order.setOrderitemList(orderService.getOrderitemByOrder(order.getId()));
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        User findUser = userService.getUser(sessionUser.getId());
        ActionContext.getContext().getValueStack().set("user",findUser);
        ActionContext.getContext().getValueStack().set("order",order);
        return SUCCESS;
    }



    //待处理订单
    @Action(
            value = "orderPage",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/newOrder.jsp")
            }
    )
    public String orderPage(){
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        List<Order> findOrders = orderService.getOrdersByStateUser(7,sessionUser.getId(),page);
        List<UserOrderJsonBean> jsonBeens = new ArrayList<UserOrderJsonBean>();
        for(int i=0;i<findOrders.size();i++){
            Order findOrder = findOrders.get(i);
            UserOrderJsonBean orderJsonBean = new UserOrderJsonBean();
            orderJsonBean.setFee(findOrder.getTotalFee());
            orderJsonBean.setId(findOrder.getId());
            orderJsonBean.setOrderNo(findOrder.getOrderNo());
            orderJsonBean.setState(findOrder.getState());
            orderJsonBean.setSellerName(findOrder.getSeller().getName());
            Iterator<Orderitem> iterator  =findOrder.getOrderitems().iterator();
            int num = 0;
            while (iterator.hasNext()){
                Orderitem orderitem = iterator.next();
                num += orderitem.getNum();
                String image = orderitem.getProduct().getHeadImage().getImage();
                orderJsonBean.getImages().add(image);
            }
            orderJsonBean.setNum(num);
            jsonBeens.add(orderJsonBean);
        }

        ServletActionContext.getContext().getValueStack().set("orders",jsonBeens);
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "jsonOrders",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json"),
            }
    )
    public String jsonOrders(){
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        List<Order> findOrders = orderService.getOrdersByStateUser(order.getState(),sessionUser.getId(),page);
        List<UserOrderJsonBean> jsonBeens = new ArrayList<UserOrderJsonBean>();
        for(int i=0;i<findOrders.size();i++){
            Order findOrder = findOrders.get(i);
            UserOrderJsonBean orderJsonBean = new UserOrderJsonBean();
            orderJsonBean.setFee(findOrder.getTotalFee());
            orderJsonBean.setId(findOrder.getId());
            orderJsonBean.setOrderNo(findOrder.getOrderNo());
            orderJsonBean.setState(findOrder.getState());
            orderJsonBean.setSellerName(findOrder.getSeller().getName());
            Iterator<Orderitem> iterator  =findOrder.getOrderitems().iterator();
            int num = 0;
            while (iterator.hasNext()){
                Orderitem orderitem = iterator.next();
                num += orderitem.getNum();
                String image = orderitem.getProduct().getHeadImage().getImage();
                orderJsonBean.getImages().add(image);
            }
            orderJsonBean.setNum(num);
            jsonBeens.add(orderJsonBean);
        }

        String json = JSONArray.fromObject(jsonBeens).toString();
        PrintWriter writer = CommonUtil.getJsonPrintWriter(ServletActionContext.getResponse());
        writer.write(json);
        writer.flush();
        writer.close();
        return SUCCESS;
    }


    //待处理订单
    @Action(
            value = "orderDetailPage",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/orderDetail.jsp")
            }
    )
    public String orderDetailPage(){
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        order = orderService.getOrder(order.getId());
        order.setStrDate(CommonUtils.getDate(order.getOrdertime()));
        ActionContext.getContext().getValueStack().set("order",order);
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "orderSubmit",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String orderSubmit(){
        User findUser = (User)ServletActionContext.getRequest().getSession().getAttribute("user");
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        findUser = userService.getUser(findUser.getId());
        Order findOrder = orderService.getOrder(order.getId());
        findOrder.setName(order.getName());
        findOrder.setAddr(order.getAddr());
        findOrder.setTel(order.getTel());
        findUser.setName(order.getName());
        findUser.setAddr(order.getAddr());
        findUser.setTel(order.getTel());
        findOrder.setRemark(order.getRemark());
        findOrder.setDeliveryTime( order.getDeliveryTime());
//        findOrder.setState(0);
        userService.update(findUser);
        orderService.update(findOrder);
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "paySuccess",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String paySuccess(){
        User findUser = (User)ServletActionContext.getRequest().getSession().getAttribute("user");
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        Order findOrder = orderService.getOrder(order.getId());
        findOrder.setState(0);
        orderService.update(findOrder);
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }
    /**
     * 用户取消订单
     */
    @Action(
            value = "cancelOrder",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String cancelOrder(){
        Order findOrder = orderService.getOrder(order.getId());
        orderService.delOrder(findOrder);
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        writer.write("success");
        if(writer!=null){
            writer.flush();
            writer.close();
        }
        return SUCCESS;
    }

    /**
     * 得到微信支付参数
     */
    @Action(
            value = "getWechatCode",
            results = {
                    @Result(name = SUCCESS,type = "json"),
            }
    )
    public String getWechatCode(){
        User findUser = (User)ServletActionContext.getRequest().getSession().getAttribute("user");
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        Order findOrder = orderService.getOrder(order.getId());
        WechatBean wechatBean = wechatPay(findOrder, findUser);
        if(wechatBean==null){
            writer.write("error");
            writer.flush();
            writer.close();
            return SUCCESS;
        }
        String jsonStr = JSONObject.fromObject(wechatBean).toString();
        writer.write(jsonStr);
        writer.flush();
        writer.close();

        return SUCCESS;
    }



    @Action(
            value = "wechatNotify",
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String wechatNotify()throws Exception{
        HttpServletRequest request = ServletActionContext.getRequest();
        BufferedReader br = new BufferedReader(new InputStreamReader((ServletInputStream)request.getInputStream()));
        String line = null;
        StringBuilder sb = new StringBuilder();
        while((line = br.readLine())!=null){
            sb.append(line);
        }
        Map map = GetWxOrderno.doXMLParse(sb.toString());
        String returnCoce = map.get("return_code").toString();
        if(returnCoce.equals("SUCCESS")){
            User findUser = userService.getUserByOpenId(map.get("openid").toString());
            String orderNo = map.get("out_trade_no").toString();
            //日志记录
        }
        ServletActionContext.getResponse().getWriter().write("success");
        return SUCCESS;
    }







    //private functions
    private JsonConfig getConfig(){
        JsonConfig config = new JsonConfig();
        config.setIgnoreDefaultExcludes(false);
        config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
        config.setExcludes(new String[]{
                "cartitems","orderitems","seller","category","sellNum","hot","visible","deliveryTime","addr","tel"
                ,"user","order.orderitems.order","product.orderitems","additionals","order.orderitems.product.orderitems",
                "com.wenti.domain.Product.orderitems","Product.orderitems","comments","order"
        });
        return config;
    }
    private WechatBean wechatPay(Order order,User user){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();

        double sessionmoney = order.getTotalFee();

        String finalmoney = String.format("%.2f", sessionmoney);
        finalmoney = finalmoney.replace(".", "");

        //商户相关资料
        String appid = ConstantUtil.APP_ID;
        String appsecret = ConstantUtil.APP_SECRET;
        String partner = ConstantUtil.PARTNER;
        String partnerkey = ConstantUtil.PARTNER_KEY;

        String openId ="";
        openId = user.getOpenId();
        //获取openId后调用统一支付接口https://api.mch.weixin.qq.com/pay/unifiedorder
        String currTime = TenpayUtil.getCurrTime();
        //8位日期
        String strTime = currTime.substring(8, currTime.length());
        //四位随机数
        String strRandom = TenpayUtil.buildRandom(4) + "";
        //10位序列号,可以自行调整。
        String strReq = strTime + strRandom;


        //商户号
        String mch_id = partner;
        //设备号   非必输
        String device_info="";
        //随机数
        String nonce_str = strReq;
        //商品描述

        //商品描述根据情况修改
        String body = "书籍";
        //附加数据
        //商户订单号
        String out_trade_no = order.getOrderNo();
        int intMoney = Integer.parseInt(finalmoney);

        //总金额以分为单位，不带小数点
        int total_fee = intMoney;
        //订单生成的机器 IP
        String spbill_create_ip = request.getRemoteAddr();
        //这里notify_url是 支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
        String notify_url ="http://www.swying.com/user/wechatNotify.action";
        String trade_type = "JSAPI";
        String openid = openId;
        //非必输
//				String product_id = "";
        SortedMap<String, String> packageParams = new TreeMap<String, String>();
        packageParams.put("appid", appid);
        packageParams.put("mch_id", mch_id);
        packageParams.put("nonce_str", nonce_str);
        packageParams.put("body", body);
        packageParams.put("out_trade_no", out_trade_no);


        //这里写的金额为1 分到时修改
       /* packageParams.put("total_fee", finalmoney);*/
        packageParams.put("total_fee", finalmoney);
        packageParams.put("spbill_create_ip", spbill_create_ip);
        packageParams.put("notify_url", notify_url);

        packageParams.put("trade_type", trade_type);
        packageParams.put("openid", openid);

        RequestHandler reqHandler = new RequestHandler(request, response);
        reqHandler.init(appid, appsecret, partnerkey);

        String sign = reqHandler.createSign(packageParams);
        String xml="<xml>"+
                "<appid>"+appid+"</appid>"+
                "<mch_id>"+mch_id+"</mch_id>"+
                "<nonce_str>"+nonce_str+"</nonce_str>"+
                "<sign>"+sign+"</sign>"+
                "<body><![CDATA["+body+"]]></body>"+
                "<out_trade_no>"+out_trade_no+"</out_trade_no>"+
                //金额，这里写的1 分到时修改
                /*"<total_fee>"+finalmoney+"</total_fee>"+*/
                "<total_fee>"+finalmoney+"</total_fee>"+
                "<spbill_create_ip>"+spbill_create_ip+"</spbill_create_ip>"+
                "<notify_url>"+notify_url+"</notify_url>"+
                "<trade_type>"+trade_type+"</trade_type>"+
                "<openid>"+openid+"</openid>"+
                "</xml>";
        String allParameters = "";
        try {
            allParameters =  reqHandler.genPackage(packageParams);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
        String createOrderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
        String prepay_id="";
        try {
            prepay_id = new GetWxOrderno().getPayNo(createOrderURL, xml);
            if(prepay_id.equals("")){
                request.setAttribute("ErrorMsg", "统一支付接口获取预支付订单出错");
                return null;
            }
        } catch (Exception e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        SortedMap<String, String> finalpackage = new TreeMap<String, String>();
        String appid2 = appid;
        String timestamp = Sha1Util.getTimeStamp();
        String nonceStr2 = nonce_str;
        String prepay_id2 = "prepay_id="+prepay_id;
        String packages = prepay_id2;
        finalpackage.put("appId", appid2);
        finalpackage.put("timeStamp", timestamp);
        finalpackage.put("nonceStr", nonceStr2);
        finalpackage.put("package", packages);
        finalpackage.put("signType", "MD5");
        String finalsign = reqHandler.createSign(finalpackage);
        request.setAttribute("appid",appid2);request.setAttribute("timeStamp",timestamp);request.setAttribute("nonceStr", nonceStr2);
        request.setAttribute("packages",packages);request.setAttribute("sign", finalsign);
        WechatBean wechatBean = new WechatBean();
        wechatBean.setAppid(appid2);
        wechatBean.setTimeStamp(timestamp);
        wechatBean.setNonceStr(nonceStr2);
        wechatBean.setPackages(packages);
        wechatBean.setSign(finalsign);
        return wechatBean;
    }

    //properties
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setSellerService(SellerService sellerService) {
        this.sellerService = sellerService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setCartService(CartService cartService) {
        this.cartService = cartService;
    }

    public void setPage(int page) {
        this.page = page;
    }
}
