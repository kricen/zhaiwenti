package com.wenti.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.Seller;
import com.wenti.service.SellerService;
import com.wenti.utils.CommonUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import java.io.PrintWriter;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
@Scope("prototype")
@ParentPackage("seller-default")
@Namespace(value="/seller")
@Results({
        @Result(name="sellerJsonLogin",type="json"),
        @Result(name="sellerActionLogin",location="login",type="redirectAction"),
        @Result(name = "notFound",location="pendingOrderPage",type="redirectAction" ),
        @Result(name = "loginPage",location="login",type="redirectAction" )
})
@ExceptionMappings({
        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
})
public class SellerAction extends ActionSupport implements ModelDriven<Seller>{
    private Seller seller = new Seller();
    public Seller getModel() {
        return seller;
    }

    private SellerService sellerService;

    //商家退出
    @Action(
            value = "exit",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "login",type = "redirectAction")
            }
    )
    public String exit(){
        ServletActionContext.getRequest().getSession().invalidate();
        return SUCCESS;
    }

    //商家登陆页面
    @Action(
            value = "login",
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/login.jsp")
            }
    )
    public String login(){
        return SUCCESS;
    }

    @Action(
            value = "validateSeller",
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String validateSeller(){
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        Seller findSeller = sellerService.getSellerByTelPwd(seller.getTel(),seller.getPassword());
        if(findSeller==null){
            writer.write("not_find");
        }else {
            writer.write("success");
            ServletActionContext.getRequest().getSession().setAttribute("seller",findSeller);
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    public void setSellerService(SellerService sellerService) {
        this.sellerService = sellerService;
    }
}
