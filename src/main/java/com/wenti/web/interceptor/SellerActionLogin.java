package com.wenti.web.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.wenti.domain.Seller;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
public class SellerActionLogin  extends AbstractInterceptor {
    private static final long serialVersionUID = 1L;

    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        if (session.getAttribute("seller") == null) {
            return "sellerActionLogin";
        }
        return invocation.invoke();

    }

}
