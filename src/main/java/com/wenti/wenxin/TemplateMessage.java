package com.wenti.wenxin;

import net.sf.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Lixiao on 11/26/2015.
 */
public class TemplateMessage {
    private String template_id;
    private String touser;
    private String url;
    private Map<String,TemplateData> data;

    public String getTemplate_id() {
        return template_id;
    }
    public void setTemplate_id(String template_id) {
        this.template_id = template_id;
    }
    public String getTouser() {
        return touser;
    }
    public void setTouser(String touser) {
        this.touser = touser;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public Map<String,TemplateData> getData() {
        return data;
    }
    public void setData(Map<String,TemplateData> data) {
        this.data = data;
    }
    public static void main(String[] args) {
        TemplateMessage templateMessage = new TemplateMessage();
        templateMessage.setUrl("");
        templateMessage.setTouser("o5u7WwW3AidQOZK9jw96vbZaThBk");
        templateMessage.setTemplate_id("2xm6v-0I_PfQYFpl9v1i2N_23a7OMPDPrY2dNXZxk2o");
        Map<String,TemplateData> m = new HashMap<String,TemplateData>();
        TemplateData first = new TemplateData();
        first.setColor("#000000");
        first.setValue("这个是标题");
        TemplateData product = new TemplateData();
        product.setColor("#000000");
        product.setValue("商品名称");
        TemplateData price = new TemplateData();
        price.setColor("#000000");
        price.setValue("商品价格");
        TemplateData time = new TemplateData();
        time.setColor("#000000");
        time.setValue(CommonUtil.getDate().substring(0, 11));
        TemplateData remark = new TemplateData();
        remark.setColor("#000000");
        remark.setValue("这个是备注");
        m.put("first", first);
        m.put("product", product);
        m.put("price", price);
        m.put("time", time);
        m.put("remark", remark);
        templateMessage.setData(m);
        String templage_message = JSONObject.fromObject(templateMessage).toString();
        System.out.println(templage_message);
    }
}
