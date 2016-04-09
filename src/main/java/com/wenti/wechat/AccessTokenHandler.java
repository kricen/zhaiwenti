package com.wenti.wechat;

import com.wenti.wenxin.CommonUtil;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import java.util.Date;

/**
 * Created by Lixiao on 11/26/2015.
 */
public class AccessTokenHandler {
    public static String access_token;
    public static long refreshtoken;

    /**
     * 获取凭证access_token
     * @return
     */
    public static String getAccessToken() {
        if ("".equals(access_token)||null==access_token) {// 如果为空直接获取
            return getTokenReal();
        }

        if (tokenIsExpire()) {// 如果过期重新获取
            return getTokenReal();
        }
        return access_token;
    }

    /**
     * 实际获取access_token的方法
     * @return
     */
    protected static String getTokenReal() {
        String requestUrl = ConstantUtil.TOKENURL + "?grant_type=" + ConstantUtil.GRANT_TYPE + "&appid="
                + ConstantUtil.APP_ID + "&secret=" + ConstantUtil.APP_SECRET;
        //JsonObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);
        // 发起GET请求获取凭证
        JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);
        if (null != jsonObject) {
            try {
                access_token = jsonObject.getString("access_token");
            } catch (JSONException e) {
                access_token = null;
                // 获取token失败
            }
        }
        System.out.println(access_token);
        return access_token;
    }

    /**
     * 判断传递过来的参数access_token是否过期
     * @return
     */
    private  static boolean tokenIsExpire() {
        boolean flag = false;
            Date date = new Date();
            long latdate = date.getTime();
            System.out.println("相差"+(latdate-refreshtoken)+"毫秒");
            if(latdate-refreshtoken>7000000){
                refreshtoken = latdate;
            }else{
                flag=true;
            }
        return flag;
    }

    public static void main(String[] args) throws Exception{
        for(int i=0;i<10;i++){
            Thread.sleep(1000);
            System.out.println( tokenIsExpire());
        }
    }

}
