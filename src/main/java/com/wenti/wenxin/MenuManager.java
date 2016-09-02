package com.wenti.wenxin;



import com.wenti.wechat.ConstantUtil;
import com.wenti.wechat.MenuUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import java.io.UnsupportedEncodingException;


public class MenuManager {
    private static Logger log = LoggerFactory.getLogger(MenuManager.class);

    /**
     * 定义菜单结构
     *
     * @return
     * @throws UnsupportedEncodingException
     */
    private static Menu getMenu() throws UnsupportedEncodingException {

        String URL="http://www.swying.com/user/weixinIndex.action";
        String shopUrl  = CommonUtil.getRedirectUrlEncode(URL);
        ViewButton btn11 = new ViewButton();
        btn11.setName("商城中心");
        btn11.setType("view");
        btn11.setUrl(shopUrl);
       /* ViewButton btn12 = new ViewButton();
        btn12.setName("卖书");
        btn12.setType("view");
        btn12.setUrl("http://mp.weixin.qq.com/s?__biz=MzI1MjA4ODU1MA==&mid=402766205&idx=1&sn=5e76f3d398dc40516e232294fe674aba#rd");*/
        ViewButton btn21 = new ViewButton();
        URL="http://www.swying.com/user/weixinCart.action";
        shopUrl  = CommonUtil.getRedirectUrlEncode(URL);
        btn21.setName("我的购物车");
        btn21.setType("view");
        btn21.setUrl(shopUrl);
        ViewButton btn22 = new ViewButton();
        URL="http://www.swying.com/user/weixinOrder.action";
        shopUrl  = CommonUtil.getRedirectUrlEncode(URL);
        System.out.println(shopUrl);
        btn22.setName("我的订单");
        btn22.setType("view");
        btn22.setUrl(shopUrl);
//        ClickButton btn24 = new ClickButton();
//        btn24.setName("购书指南");
//        btn24.setType("click");
//        btn24.setKey("serviceGuide");
//        ViewButton btn26 = new ViewButton();
//        btn26.setName("教材回收");
//        btn26.setType("view");
//        btn26.setUrl("http://mp.weixin.qq.com/s?__biz=MzI1MjA4ODU1MA==&mid=402766205&idx=1&sn=5e76f3d398dc40516e232294fe674aba#rd");
//        ViewButton btn32 = new ViewButton();
//        btn32.setName("合作通道");
//        btn32.setType("view");
//        btn32.setUrl(shopUrl);
//        ViewButton btn33 = new ViewButton();
//        btn33.setName("团队招新");
//        btn33.setType("view");
//        btn33.setUrl(shopUrl);
//        ViewButton btn34 = new ViewButton();
//        btn34.setName("项目简介");
//        btn34.setType("view");
//        btn34.setUrl("http://mp.weixin.qq.com/s?__biz=MzI1MjA4ODU1MA==&mid=403050817&idx=1&sn=86c13192b66983f24a45d50e75745b7d#rd");
//        ClickButton btn35 = new ClickButton();
//        btn35.setName("网上报名");
//        btn35.setType("click");
//        btn35.setKey("phoneService");
//        ViewButton btn36 = new ViewButton();
//        btn36.setName("售后服务");
//        btn36.setType("view");
//        btn36.setUrl("http://mp.weixin.qq.com/s?__biz=MzI1MjA4ODU1MA==&mid=402793638&idx=1&sn=65968ae82c29cd1f3e5cb339c4bdee0c#rd");
//
        ComplexButton mainBtn1 = new ComplexButton();
        mainBtn1.setName("商城中心");
        /*mainBtn1.setSub_button(new Button[]{btn11, btn12});*/
        ComplexButton mainBtn2 = new ComplexButton();
        mainBtn2.setName("个人中心");
        mainBtn2.setSub_button(new Button[]{btn21, btn22});
//        ComplexButton mainBtn3 = new ComplexButton();
//        mainBtn3.setName("关于我们");
//       /* mainBtn3.setSub_button(new Button[]{btn34, btn32, btn33, btn35, btn36});*/
//        mainBtn3.setSub_button(new Button[]{btn34,btn36});
        Menu menu = new Menu();
//        menu.setButton(new Button[] {btn11, mainBtn2, mainBtn3 });
        menu.setButton(new Button[] {btn11,btn21,btn22});

        return menu;
    }

    public static void main(String[] args) throws UnsupportedEncodingException {

        // 第三方用户唯一凭证
        String appId = ConstantUtil.APP_ID;
        // 第三方用户唯一凭证密钥
        String appSecret = ConstantUtil.APP_SECRET;

        // 调用接口获取凭证
        Token token = CommonUtil.getToken(appId, appSecret);

        if (null != token) {
            // 创建菜单
            boolean result = MenuUtil.createMenu(getMenu(), token.getAccessToken());
            String menu = MenuUtil.getMenu(token.getAccessToken());
            // 判断菜单创建结果
            if (result)
                System.out.println("成功");
            else {
                log.info("菜单创建失败！");
                System.out.println("创建失败");
            }
        }
    }
}
