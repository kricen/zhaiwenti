package com.wenti.web.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.wenti.utils.CommonUtils;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
public class UserJsonLogin extends AbstractInterceptor {

    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        if (session.getAttribute("user") == null) {
            PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
            writer.write("noLogin");
            if (writer != null) {
                writer.flush();
                writer.close();
            }
            return "userJsonLogin";
        }
        return invocation.invoke();

    }

}
