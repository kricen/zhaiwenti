package com.wenti.web.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.wenti.wenxin.CommonUtil;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * Created by Lixiao on 11/26/2015.
 */
public class UserFromWeixin extends AbstractInterceptor {
    private static final long serialVersionUID = 1L;

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        if (session.getAttribute("user") == null) {
            String URL = "http://www.swying.com/user/wechatIndex.action";
            String shopUrl = CommonUtil.getRedirectUrlEncode(URL);
            ServletActionContext.getResponse().sendRedirect(shopUrl);
            return null;
        } else {
            return actionInvocation.invoke();
        }
    }
}
