package com.wenti.wechat;

//import domain.Orders;
//import domain.Seller;
//import net.sf.json.JSONObject;
//import utils.CommonUtil;
//import weixin.pojo.TemplateData;
//import weixin.pojo.TemplateMessage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Lixiao on 11/26/2015.
 */
public class WechatCommon {
//    public static void sendSuccessTemplate(List<Orders> orderses,String openid){
//        float totalMoney = 0l;
//        String sellers = "";
//        for(int i=0;i<orderses.size();i++){
//            totalMoney+=orderses.get(i).getTotalFee();
//            if(i!=orderses.size()-1){
//                sellers+=orderses.get(i).getSeller().getName()+"、";
//            }else {
//                sellers+=orderses.get(i).getSeller().getName();
//            }
//        }
//        TemplateMessage templateMessage = new TemplateMessage();
//        templateMessage.setUrl("");
//        templateMessage.setTouser(openid);
//        templateMessage.setTemplate_id("2xm6v-0I_PfQYFpl9v1i2N_23a7OMPDPrY2dNXZxk2o");
//        Map<String,TemplateData> m = new HashMap<String,TemplateData>();
//        TemplateData first = new TemplateData();
//        first.setColor("#173177");
//        first.setValue("下单成功,等待商家接单");
//        TemplateData product = new TemplateData();
//        product.setColor("#173177");
//        product.setValue("书籍");
//        TemplateData price = new TemplateData();
//        price.setColor("#173177");
//        price.setValue(totalMoney + "");
//        TemplateData time = new TemplateData();
//        time.setColor("#173177");
//        time.setValue(CommonUtil.getDate().substring(0, 10));
//        TemplateData remark = new TemplateData();
//        remark.setColor("#173177");
//        remark.setValue("来自"+orderses.size()+"个商家为您配货：" + sellers);
//        m.put("first", first);
//        m.put("product", product);
//        m.put("price", price);
//        m.put("time", time);
//        m.put("remark", remark);
//        templateMessage.setData(m);
//        String templage_message = JSONObject.fromObject(templateMessage).toString();
//        String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
//        url = url.replace("ACCESS_TOKEN",AccessTokenHandler.getAccessToken());
//        JSONObject jsonObject = CommonUtil.httpsRequest(url, "POST", templage_message);
//    }
//    public static void sellerAnnounce(List<Orders> orderses){
//        float totalMoney = 0l;
//        String sellers = "";
//        for(int i=0;i<orderses.size();i++){
//            Seller seller = orderses.get(i).getSeller();
//            TemplateMessage templateMessage = new TemplateMessage();
//            templateMessage.setUrl("");
//            if(seller.getMark()==null){
//                continue;
//            }
//            templateMessage.setTouser(seller.getMark());
//            templateMessage.setTemplate_id("3PSUkkJs0uSTEMOFHBFKhZoOV6naiBBDtkj86iGvJjI");
//            Map<String,TemplateData> m = new HashMap<String,TemplateData>();
//            TemplateData first = new TemplateData();
//            first.setColor("#173177");
//            first.setValue("订单通知:"+seller.getName());
//            TemplateData time = new TemplateData();
//            time.setColor("#173177");
//            time.setValue(CommonUtil.getDate());
//            TemplateData remark = new TemplateData();
//            remark.setColor("#173177");
//            remark.setValue("您有新的订单要处理,请及时处理");
//            m.put("first", first);
//            m.put("time",time);
//            m.put("remark", remark);
//            templateMessage.setData(m);
//            String templage_message = JSONObject.fromObject(templateMessage).toString();
//            String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
//            url = url.replace("ACCESS_TOKEN",AccessTokenHandler.getAccessToken());
//            JSONObject jsonObject = CommonUtil.httpsRequest(url, "POST", templage_message);
//        }
//    }
//    public static void sendFailTemplageMessage(Orders orders, String openid){
//        TemplateMessage templateMessage = new TemplateMessage();
//        templateMessage.setUrl("");
//        templateMessage.setTouser(openid);
//        templateMessage.setTemplate_id("jl19NAZt8eOT_G8e2QXyWfY0LWpcPAqUsasCaAmGQ5M");
//        Map<String,TemplateData> m = new HashMap<String,TemplateData>();
//        TemplateData first = new TemplateData();
//        first.setColor("#c91623");
//        first.setValue("不好意思，" + orders.getSeller().getName() + "取消您的订单");
//        TemplateData keyword1 = new TemplateData();
//        keyword1.setColor("#173177");
//        TemplateData keyword2 = new TemplateData();
//        keyword2.setColor("#173177");
//        keyword2.setValue(orders.getId() + "");
//        TemplateData keyword3 = new TemplateData();
//        keyword3.setColor("#173177");
//        TemplateData remark = new TemplateData();
//        remark.setColor("#173177");
//        if(orders.getIsPay()==0){
//            keyword3.setValue(0+"");
//            remark.setValue("如有疑问,请联系商家:"+orders.getSeller().getTel());
//        }else {
//            keyword3.setValue(orders.getTotalFee()+"");
//            remark.setValue("您已经付过款,若商家未联系您,请致电:"+orders.getSeller().getTel());
//        }
//        TemplateData keyword4 = new TemplateData();
//        keyword4.setColor("#173177");
//        if(orders.getPayWay()!=0){
//            keyword4.setValue("在线支付");
//        }else{
//            keyword4.setValue("货到付款");
//        }
//        if(orders.getSeller().getId()==1){
//            keyword1.setValue("新书预定");
//        }else {
//            keyword1.setValue("二手书");
//        }
//        m.put("first", first);
//        m.put("keyword1", keyword1);
//        m.put("keyword2", keyword2);
//        m.put("keyword3", keyword3);
//        m.put("keyword4", keyword4);
//        m.put("remark", remark);
//        templateMessage.setData(m);
//        String templage_message = JSONObject.fromObject(templateMessage).toString();
//        String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
//        url = url.replace("ACCESS_TOKEN",AccessTokenHandler.getAccessToken());
//        JSONObject jsonObject = CommonUtil.httpsRequest(url, "POST", templage_message);
//    }
//    public static void sendAcceptTemplageMessage(Orders orders,String openid){
//        TemplateMessage templateMessage = new TemplateMessage();
//        templateMessage.setUrl("");
//        templateMessage.setTouser(openid);
//        templateMessage.setTemplate_id("jvwsOWzv37e_9eA1sKziEcIPCYSxJhh6UnNTftyYkFY");
//        Map<String,TemplateData> m = new HashMap<String,TemplateData>();
//        TemplateData first = new TemplateData();
//        first.setColor("#173177");
//        first.setValue("您好，"+orders.getSeller().getName()+"已接单");
//        TemplateData keyword1 = new TemplateData();
//        keyword1.setColor("#173177");
//        keyword1.setValue(orders.getSeller().getName());
//        TemplateData keyword2 = new TemplateData();
//        keyword2.setColor("#173177");
//        keyword2.setValue(orders.getId() + "");
//        TemplateData keyword3 = new TemplateData();
//        keyword3.setColor("#173177");
//        TemplateData remark = new TemplateData();
//        remark.setColor("#173177");
//        if(orders.getSeller().getId()==1){
//            keyword3.setValue("新书预定");
//            remark.setValue("预计5个工作日之内到货,如有疑问，请联系商家客服"+orders.getSeller().getTel());
//        }else {
//            keyword3.setValue("二手书");
//            remark.setValue(" 预计当天到货,如有疑问，请联系商家客服:"+orders.getSeller().getTel());
//        }
//
//        TemplateData keyword4 = new TemplateData();
//        keyword4.setColor("#173177");
//        keyword4.setValue(orders.getTotalFee() + "");
//        TemplateData keyword5 = new TemplateData();
//        keyword5.setColor("#173177");
//        if(orders.getIsPay()==0){
//            keyword5.setValue("货到付款");
//        }else {
//            keyword5.setValue("在线支付");
//        }
//        m.put("first", first);
//        m.put("keyword1", keyword1);
//        m.put("keyword2", keyword2);
//        m.put("keyword3", keyword3);
//        m.put("keyword4", keyword4);
//        m.put("keyword5", keyword5);
//        m.put("remark", remark);
//        templateMessage.setData(m);
//        String templage_message = JSONObject.fromObject(templateMessage).toString();
//        String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
//        url = url.replace("ACCESS_TOKEN",AccessTokenHandler.getAccessToken());
//        JSONObject jsonObject = CommonUtil.httpsRequest(url, "POST", templage_message);
//    }
}
