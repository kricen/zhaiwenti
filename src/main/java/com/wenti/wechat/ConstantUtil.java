package com.wenti.wechat;

public class ConstantUtil {
	/**
	 * 商家可以考虑读取配置文件
	 */
	
	//初始化
	public static String APP_ID = "wx8bcd7d1927133b9f";//微信开发平台应用id
	public static String APP_SECRET = "12d7780b15cd72bee7890b00ffec2434";//应用对应的凭证
	//应用对应的密钥
	public static String APP_KEY = "L8LrMqqeGRxST5reouB0K66CaYAWpqhAVsq7ggKkxHCOastWksvuX1uvmvQclxaHoYd3ElNBrNO2DHnnzgfVG9Qs473M3DTOZug5er46FhuGofumV8H2FVR9qkjSlC5K";
	public static String PARTNER = "1286981701";//财付通商户号
	public static String PARTNER_KEY = "yzaHVZxbArKfs7v752b5fd00OeSgdexU";//商户号对应的密钥
	public static String TOKENURL = "https://api.weixin.qq.com/cgi-bin/token";//获取access_token对应的url
	public static String GRANT_TYPE = "client_credential";//常量固定值 
	public static String EXPIRE_ERRCODE = "42001";//access_token失效后请求返回的errcode
	public static String FAIL_ERRCODE = "40001";//重复获取导致上一次获取的access_token失效,返回错误码
	public static String GATEURL = "https://api.weixin.qq.com/pay/genprepay?access_token=";//获取预支付id的接口url
	public static String ACCESS_TOKEN = "access_token";//access_token常量值
	public static String ERRORCODE = "errcode";//用来判断access_token是否失效的值
	public static String SIGN_METHOD = "sha1";//签名算法常量值
    public static int BIGIMAGEWIDTH = 180;
    public static int BIGIMAGEHEIGHT = 200;
    public static int SMALLIMAGEWIDTH = 440;
    public static int SMALLIMAGEHEIGHT = 460;
    public static float NEWBOOKDISCOUNT = 0.82f;
    public static int NEWBOOKPRODUCT = 1;

	//package常量值

}
