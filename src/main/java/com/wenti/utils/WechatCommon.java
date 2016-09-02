package com.wenti.utils;

import com.wenti.domain.Order;
import com.wenti.domain.Seller;
import com.wenti.wechat.AccessTokenHandler;
import com.wenti.wenxin.CommonUtil;
import com.wenti.wenxin.TemplateData;
import com.wenti.wenxin.TemplateMessage;
import net.sf.json.JSONObject;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Lixiao on 11/26/2015.
 */
public class WechatCommon {

    public static void sellerAnnounce(Order order){
        TemplateMessage templateMessage = new TemplateMessage();
        templateMessage.setUrl("http://www.swying.com/user/sellerOrder.action?id="+order.getId());
        templateMessage.setTouser("os_ngsxVWj3xJvKOZuUPPevhWGTE");
        templateMessage.setTemplate_id("C5Yy5wm3-Y8_1MR2ImbpYNcjccn3Dksdwdc03nN2ro4");
        Map<String,TemplateData> m = new HashMap<String,TemplateData>();
        TemplateData first = new TemplateData();
        first.setColor("#173177");
        first.setValue("来订单拉");
        TemplateData keyword1 = new TemplateData();
        keyword1.setColor("#173177");
        keyword1.setValue(CommonUtil.getDate());
        TemplateData keyword2 = new TemplateData();
        keyword2.setColor("#173177");
        keyword2.setValue(order.getId()+"");
        TemplateData keyword3 = new TemplateData();
        keyword3.setColor("#173177");
        keyword3.setValue("自选");
        TemplateData keyword4 = new TemplateData();
        keyword4.setColor("#173177");
        keyword4.setValue(order.getName());
        TemplateData keyword5 = new TemplateData();
        keyword5.setColor("#173177");
        keyword5.setValue(order.getTel());
        TemplateData remark = new TemplateData();
        remark.setColor("#173177");
        remark.setValue("地址:"+order.getAddr());
        m.put("first", first);
        m.put("keyword1",keyword1);
        m.put("keyword2",keyword2);
        m.put("keyword3",keyword3);
        m.put("keyword4",keyword4);
        m.put("keyword5",keyword5);
        m.put("remark", remark);
        templateMessage.setData(m);
        String templage_message = JSONObject.fromObject(templateMessage).toString();
        System.out.println(templage_message);
        String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
        url = url.replace("ACCESS_TOKEN", AccessTokenHandler.getAccessToken());
        JSONObject jsonObject = CommonUtil.httpsRequest(url, "POST", templage_message);
    }
    public static void userSubmitSucc(Order order){
        TemplateMessage templateMessage = new TemplateMessage();
        templateMessage.setTouser(order.getUser().getOpenId());
        templateMessage.setTemplate_id("C5Yy5wm3-Y8_1MR2ImbpYNcjccn3Dksdwdc03nN2ro4");
        Map<String,TemplateData> m = new HashMap<String,TemplateData>();
        TemplateData first = new TemplateData();
        first.setColor("#173177");
        first.setValue("订单预约成功,请先和商家联系");
        TemplateData keyword1 = new TemplateData();
        keyword1.setColor("#173177");
        keyword1.setValue("自选商品");
        TemplateData keyword2 = new TemplateData();
        keyword2.setColor("#173177");
        keyword2.setValue(order.getTotalFee()+"元");
        TemplateData keyword3 = new TemplateData();
        keyword3.setColor("#173177");
        keyword3.setValue(order.getOrderitems().size()+"");
        TemplateData keyword4 = new TemplateData();
        keyword4.setColor("#173177");
        keyword4.setValue(order.getOrdertime()+"");
        TemplateData remark = new TemplateData();
        remark.setColor("#173177");
        remark.setValue("请先微信联系商家,商家微信号:youjiangwenti,联系时备注网上预约订单,如有问题,请联系:18068616580");
        m.put("first", first);
        m.put("keyword1",keyword1);
        m.put("keyword2",keyword2);
        m.put("keyword3",keyword3);
        m.put("keyword4",keyword4);
        m.put("remark", remark);
        templateMessage.setData(m);
        String templage_message = JSONObject.fromObject(templateMessage).toString();
        System.out.println(templage_message);
        String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
        url = url.replace("ACCESS_TOKEN", AccessTokenHandler.getAccessToken());
        JSONObject jsonObject = CommonUtil.httpsRequest(url, "POST", templage_message);
        System.out.println(jsonObject);

    }

    public static void main(String[] args) {
        Order order = new Order();
        Seller seller = new Seller();
        seller.setOpenid("os_ngs5afFJOHMo_xD8swAHrimE0");
        order.setSeller(seller);

        sellerAnnounce(order);
    }
}
