package com.wenti.wenxin;



import com.wenti.wechat.ConstantUtil;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigInteger;
import java.net.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;


public class CommonUtil {
    private static Logger log = LoggerFactory.getLogger(CommonUtil.class);
    private static final double EARTH_RADIUS = 6378137;
    // 凭证获取（GET）
    public final static String token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

    public final static String  requestMethodGet = "GET";
    public final static String  requestMethodPost = "POST";
    //购书宝appid
    private final static String APPID = ConstantUtil.APP_ID;
    public static final String DEF_CHATSET = "UTF-8";
    public static final int DEF_CONN_TIMEOUT = 30000;
    public static final int DEF_READ_TIMEOUT = 30000;
    public static String userAgent =  "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";

    /**
     * 获得json PrintWriter
     */
    public static PrintWriter getJsonPrintWriter(HttpServletResponse response){
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/json; charset=utf-8");
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return writer;
    }
    /**
     * 获得html PrintWriter
     */
    public static PrintWriter getHtmlPrintWriter(HttpServletResponse response){
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return writer;
    }

    /**
     * 智能机器人问答
     */
//    public static String getRobotInfo(String info,String userid){
//        String url ="http://op.juhe.cn/robot/index";//请求接口地址
//        Map<String, Object> params = new HashMap<String, Object>();//请求参数
//        params.put("key","f184afc7ef6f3b340ee7845817e4e6f3");//应用APPKEY(应用详细页查询)
//        params.put("dtype","json");//返回数据的格式,xml或json，默认json
//        params.put("info",info);//图书ISBN编码
//        params.put("userid",userid);
//        String result = "";
//        try {
//            result =net(url, params, "GET");
//            JSONObject object = JSONObject.fromObject(result);
//            if(object.getInt("error_code")==0){
//                object = JSONObject.fromObject(object.getString("result"));
//                result = object.getString("text");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return result;
//    }
//    public static synchronized String getOrderNo() {
//        String str = new SimpleDateFormat("yyMMddHHmmss").format(new Date());
//        return str;
//    }
    /**
     * 根据两个经纬度获得之间的距离
     */
    private static double rad(double d)
    {
        return d * Math.PI / 180.0;
    }
    public static double getDistance(double lat1, double lng1, double lat2, double lng2)
    {
        double radLat1 = rad(lat1);
        double radLat2 = rad(lat2);
        double a = radLat1 - radLat2;
        double b = rad(lng1) - rad(lng2);
        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) +
                Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
        s = s * EARTH_RADIUS;
        s = Math.round(s * 10000) / 10000;
        return s;
    }

    /**
     * 模糊查询算法
     */
    public static String getSortString(String s) {
        String replaceAll = s.replaceAll("%", "/%").replaceAll("\\+","\\\\+");
        String bf = new String("");
        for (int i = 0; i < replaceAll.length(); i++) {
            if (replaceAll.charAt(i) == '/') {
                if (i == 0) {
                    bf = "%" + replaceAll.charAt(i);
                } else {
                    bf += replaceAll.charAt(i);
                }
            } else {
                if (i == 0) {
                    bf = "%" + replaceAll.charAt(i) + "%";
                } else {
                    bf += replaceAll.charAt(i) + "%";
                }
            }
        }
        return bf;
    }
    /**
     * MD5加密
     */
    public static String getSecretByMd5(String plainText) {
        byte[] secretBytes = null;
        try {
            secretBytes = MessageDigest.getInstance("md5").digest(
                    plainText.getBytes());
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("没有md5这个算法！");
        }
        String md5code = new BigInteger(1, secretBytes).toString(16);// 16进制数字
        // 如果生成数字未满32位，需要前面补0
        for (int i = 0; i < 32 - md5code.length(); i++) {
            md5code = "0" + md5code;
        }
        return md5code;
    }


    /**
     * JSONP
     */
    public static String getJsonP(String jsonArray,String callback){
        String result = callback+"(";
        result += jsonArray+")";
        return result;
    }
    /**
     * uuid 获得唯一id
     */
    public static String UUID16(){

        return UUID.randomUUID().toString().replaceAll("-","");
    }


    //相似度查询
    public static float levenshtein(String str1,String str2) {
        //计算两个字符串的长度。
        int len1 = str1.length();
        int len2 = str2.length();
        //建立上面说的数组，比字符长度大一个空间
        int[][] dif = new int[len1 + 1][len2 + 1];
        //赋初值，步骤B。
        for (int a = 0; a <= len1; a++) {
            dif[a][0] = a;
        }
        for (int a = 0; a <= len2; a++) {
            dif[0][a] = a;
        }
        //计算两个字符是否一样，计算左上的值
        int temp;
        for (int i = 1; i <= len1; i++) {
            for (int j = 1; j <= len2; j++) {
                if (str1.charAt(i - 1) == str2.charAt(j - 1)) {
                    temp = 0;
                } else {
                    temp = 1;
                }
                //取三个值中最小的
                dif[i][j] = min(dif[i - 1][j - 1] + temp, dif[i][j - 1] + 1,
                        dif[i - 1][j] + 1);
            }
        }
        float similarity =1 - (float) dif[len1][len2] / Math.max(str1.length(), str2.length());
        return similarity;
    }
    //得到最小值
    private static int min(int... is) {
        int min = Integer.MAX_VALUE;
        for (int i : is) {
            if (min > i) {
                min = i;
            }
        }
        return min;
    }


    /**
     * 获得当前时间
     * @return
     */
    public static String getDate(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = simpleDateFormat.format(date);
        return time;
    }

    /**
     * 获得当前时间
     * @return
     */
    public static String getDate1(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String time = simpleDateFormat.format(date);
        return time;
    }
    /**
     * 获得当前时间
     * @return
     */
    public static String getDateYMDHM(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM-dd HH：mm");
        String time = simpleDateFormat.format(date);
        return time;
    }
    /**
     * 获得当前时间
     * @return
     */
    public static String getDateYM(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年M月");
        String time = simpleDateFormat.format(date);
        return time;
    }
    //发送http get请求
    public static String sendGet(String url, String param) {
        String result = "";
        BufferedReader in = null;
        try {
            String urlNameString = url + "?" + param;
            URL realUrl = new URL(urlNameString);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 遍历所有的响应头字段
            for (String key : map.keySet()) {
                System.out.println(key + "--->" + map.get(key));
            }
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送GET请求出现异常！" + e);
            e.printStackTrace();
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return result;
    }
    /**
     * 发送https请求
     *
     * @param requestUrl 请求地址
     * @param requestMethod 请求方式（GET、POST）
     * @param outputStr 提交的数据
     * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
     */
    public static JSONObject httpsRequest(String requestUrl, String requestMethod, String outputStr) {
        JSONObject jsonObject = null;
        try {
            // 创建SSLContext对象，并使用我们指定的信任管理器初始化
            TrustManager[] tm = { new MyX509TrustManager() };
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
            sslContext.init(null, tm, new java.security.SecureRandom());
            // 从上述SSLContext对象中得到SSLSocketFactory对象
            SSLSocketFactory ssf = sslContext.getSocketFactory();

            URL url = new URL(requestUrl);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(ssf);

            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            // 设置请求方式（GET/POST）
            conn.setRequestMethod(requestMethod);

            // 当outputStr不为null时向输出流写数据
            if (null != outputStr) {
                OutputStream outputStream = conn.getOutputStream();
                // 注意编码格式
                outputStream.write(outputStr.getBytes("UTF-8"));
                outputStream.close();
            }

            // 从输入流读取返回内容
            InputStream inputStream = conn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            String str = null;
            StringBuffer buffer = new StringBuffer();
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }

            // 释放资源
            bufferedReader.close();
            inputStreamReader.close();
            inputStream.close();
            inputStream = null;
            conn.disconnect();
            jsonObject = JSONObject.fromObject(buffer.toString());
        } catch (ConnectException ce) {
            log.error("连接超时：{}", ce);
        } catch (Exception e) {
            log.error("https请求异常：{}", e);
        }
        return jsonObject;
    }
    /**
     * 发送https请求
     *
     * @param requestUrl 请求地址
     * @param requestMethod 请求方式（GET、POST）
     * @param outputStr 提交的数据
     * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
     */
    public static void httpsRequestNull(String requestUrl, String requestMethod, String outputStr) {
        JSONObject jsonObject = null;
        try {
            // 创建SSLContext对象，并使用我们指定的信任管理器初始化
            TrustManager[] tm = { new MyX509TrustManager() };
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
            sslContext.init(null, tm, new java.security.SecureRandom());
            // 从上述SSLContext对象中得到SSLSocketFactory对象
            SSLSocketFactory ssf = sslContext.getSocketFactory();

            URL url = new URL(requestUrl);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(ssf);

            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            // 设置请求方式（GET/POST）
            conn.setRequestMethod(requestMethod);

            // 当outputStr不为null时向输出流写数据
            if (null != outputStr) {
                OutputStream outputStream = conn.getOutputStream();
                // 注意编码格式
                outputStream.write(outputStr.getBytes("UTF-8"));
                outputStream.close();
            }

            // 从输入流读取返回内容
            InputStream inputStream = conn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            String str = null;
            StringBuffer buffer = new StringBuffer();
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }

            // 释放资源
            bufferedReader.close();
            inputStreamReader.close();
            inputStream.close();
            inputStream = null;
            conn.disconnect();
        } catch (ConnectException ce) {
            log.error("连接超时：{}", ce);
        } catch (Exception e) {
            log.error("https请求异常：{}", e);
        }
    }

    /**
     * 获取接口访问凭证
     *
     * @param appid 凭证
     * @param appsecret 密钥
     * @return
     */
    public static Token getToken(String appid, String appsecret) {
        Token token = null;
        String requestUrl = token_url.replace("APPID", appid).replace("APPSECRET", appsecret);
        // 发起GET请求获取凭证
        JSONObject jsonObject = httpsRequest(requestUrl, "GET", null);

        if (null != jsonObject) {
            try {
                token = new Token();
                token.setAccessToken(jsonObject.getString("access_token"));
                token.setExpiresIn(jsonObject.getInt("expires_in"));
            } catch (JSONException e) {
                token = null;
                // 获取token失败
                log.error("获取token失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));
            }
        }
        return token;
    }


    //OAuth2.0网页授权
    public static String  getOpenId(String appId,String secret,String code){
        OAuthToken oAuthToken = null;
        String requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
        requestUrl = requestUrl.replaceAll("APPID", appId).replace("SECRET", secret).replace("CODE", code);
        log.info("=================requestUrl:" + requestUrl + "=================");

        JSONObject jsonObject = httpsRequest(requestUrl, requestMethodGet, null);
        String openId = jsonObject.getString("openid");

        return openId;

    }
    //OAuth2.0网页授权获得用户基本信息
    public static OAuthToken getUserInfo(String accessToken,String openId){
        String requestUrl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
        String url = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
        JSONObject jsonObject = httpsRequest(url, requestMethodGet, null);
        OAuthToken authToken = new OAuthToken();
        authToken.setOpenId(openId);
        authToken.setHeadUrl(jsonObject.getString("headimgurl"));
        authToken.setNickName(jsonObject.getString("nickname"));
        authToken.setSex(jsonObject.getInt("sex"));
        authToken.setAddr(jsonObject.getString("province") + jsonObject.getString("city"));
        return authToken;
    }

    //获得redirect_url
    public static String getRedirectUrlEncode(String redirectUrl) throws UnsupportedEncodingException{
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
        String URL=redirectUrl;
        String ENCODING = "utf-8";
        String strURL1= URLEncoder.encode(URL, ENCODING).replace("*","*").replace("~", "~").replace("+", " ");
        url = url.replace("REDIRECT_URI", strURL1);
        url = url.replace("APPID",APPID);
        log.info("url:"+url);
        return url;

    }

    //获得调用jssdk的Ticket
    public synchronized static String getJssdkTicket(String accessToken){
        String ticket = "";
        String requestUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
        requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken);
        JSONObject jsonObject = httpsRequest(requestUrl, requestMethodGet, null);
        if(null!=jsonObject){
            try {
                ticket=jsonObject.getString("ticket");
            } catch (JSONException e) {
                ticket = null;
            }
        }
        return ticket;
    }


    //获得特定长度的字符串
    private String createNonceStr(int length)
    {
        Random r = new Random();
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String str = "";
        for (int i = 0; i < length; i++)
        {
            str += chars.substring(r.nextInt(58), 1);
        }
        return str;
    }


//    public static String net(String strUrl, Map<String, Object> params,String method) throws Exception {
//        HttpURLConnection conn = null;
//        BufferedReader reader = null;
//        String rs = null;
//        try {
//            StringBuffer sb = new StringBuffer();
//            if(method==null || method.equals("GET")){
//                strUrl = strUrl+"?"+urlencode(params);
//            }
//            URL url = new URL(strUrl);
//            conn = (HttpURLConnection) url.openConnection();
//            if(method==null || method.equals("GET")){
//                conn.setRequestMethod("GET");
//            }else{
//                conn.setRequestMethod("POST");
//                conn.setDoOutput(true);
//            }
//            conn.setRequestProperty("User-agent", userAgent);
//            conn.setUseCaches(false);
//            conn.setConnectTimeout(DEF_CONN_TIMEOUT);
//            conn.setReadTimeout(DEF_READ_TIMEOUT);
//            conn.setInstanceFollowRedirects(false);
//            conn.connect();
//            if (params!= null && method.equals("POST")) {
//                try (DataOutputStream out = new DataOutputStream(conn.getOutputStream())) {
//                    out.writeBytes(urlencode(params));
//                }
//            }
//            InputStream is = conn.getInputStream();
//            reader = new BufferedReader(new InputStreamReader(is, DEF_CHATSET));
//            String strRead = null;
//            while ((strRead = reader.readLine()) != null) {
//                sb.append(strRead);
//            }
//            rs = sb.toString();
//        } catch (IOException e) {
//            e.printStackTrace();
//        } finally {
//            if (reader != null) {
//                reader.close();
//            }
//            if (conn != null) {
//                conn.disconnect();
//            }
//        }
//        return rs;
//    }

    //将map型转为请求参数型
    public static String urlencode(Map<String, ?> data) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, ?> i : data.entrySet()) {
            try {
                sb.append(i.getKey()).append("=").append(URLEncoder.encode(i.getValue() + "", "UTF-8")).append("&");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }
    public static void main(String[] args) {
       /* Double dis = getDistance(30.8361600000,121.5109500000,30.8400848,121.50449540000001);
        System.out.println(dis);*/
        //学校相似度
      /*  List<School> schools = new ArrayList<School>();
        School s1 = new School();
        s1.setName("上海应用技术学院");
        School s2 = new School();
        s2.setName("上海应用");
        School s3 = new School();
        s3.setName("上海华东理工大学");
        School s4 = new School();
        s4.setName("华东理工大学");
        schools.add(s1);schools.add(s2);schools.add(s3);schools.add(s4);
        schoolMatch(schools,"上应");*/

    }
}