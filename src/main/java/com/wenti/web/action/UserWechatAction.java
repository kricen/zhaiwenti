package com.wenti.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wenti.domain.User;
import com.wenti.service.UserService;
import com.wenti.wechat.AccessTokenHandler;
import com.wenti.wechat.ConstantUtil;
import com.wenti.wenxin.CommonUtil;
import com.wenti.wenxin.OAuthToken;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import javax.servlet.http.HttpSession;

/**
 * Created by lixiao on 16/8/30.
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
public class UserWechatAction extends ActionSupport {
    private UserService userService;
    private String code;
    private String openid;
    @Action(
            value = "weixinIndex",
            results ={
                    @Result(name="success",location="index",type = "redirectAction"),
                    @Result(name="findSchool",location="selectSchool",type = "redirectAction"),
                    @Result(name="error1",location="/err.jsp"),
                    @Result(name="error",location="/index.jsp")
            }
    )
    public String weixinIndex() {
        if(code==null){
            return "error1";
        }
        return mainCode();
    }

    //个人中心
    @Action(
            value = "weixinCart",
            results ={
                    @Result(name="success",location="cartPage",type = "redirectAction"),
                    @Result(name="findSchool",location="selectSchool",type = "redirectAction"),
                    @Result(name="error1",location="/index.jsp"),
                    @Result(name="error",location="/index.jsp")
            }
    )
    public String weixinCart(){
        if(code==null){
            return "error1";
        }
        return mainCode();
    }
    @Action(
            value = "weixinOrder",
            results ={
                    @Result(name="success",location="orderPage",type = "redirectAction"),
                    @Result(name="findSchool",location="selectSchool",type = "redirectAction"),
                    @Result(name="error1",location="/index.jsp"),
                    @Result(name="error",location="/index.jsp")
            }
    )
    public String weixinOrder(){
        if(code==null){
            return "error1";
        }
        return mainCode();
    }

    //private function
    public String mainCode(){
        try{
            HttpSession session = ServletActionContext.getRequest().getSession();
            /*下面这句话可以不要*/
            String openId = "";
            User user= null;
            //根据code 获得openId
            String openIdUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx8bcd7d1927133b9f&secret=781f236184cdd0bb2f143fc4a9303566&code=CODE&grant_type=authorization_code";
            openIdUrl = openIdUrl.replace("CODE",code);
            JSONObject jsonObject = CommonUtil.httpsRequest(openIdUrl, "GET", null);
            openId = jsonObject.getString("openid");
            if(openId==null){
                return ERROR;
            }
            User findWeixinUser = userService.getUserByOpenId(openId);
            if (findWeixinUser==null) {
//                OAuthToken userInfo = CommonUtil.getUserInfo(AccessTokenHandler.getAccessToken(), openId);
                user = new User();
                user.setOpenId(openId);
                user.setSchool(0);
                user.setName(null);
                user.setAddr(null);
                user.setState(0);
                userService.save(user);
                session.setAttribute("user", user);
            }else{
                user = (User)session.getAttribute("user");
                if(user==null){
                    user = userService.getUserByOpenId(openId);
                    session.setAttribute("user", user);
                }else {
                    user = userService.getUser(user.getId());
                }
            }
            if(user.getSchool()==0){
                return "findSchool";
            }
        }catch (Exception e){
            return ERROR;
        }
        return SUCCESS;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }
}
