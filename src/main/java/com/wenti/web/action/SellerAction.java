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
})
@ExceptionMappings({
})
public class SellerAction extends ActionSupport implements ModelDriven<Seller>{
    private Seller seller = new Seller();
    public Seller getModel() {
        return seller;
    }

    private SellerService sellerService;

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
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    public void setSellerService(SellerService sellerService) {
        this.sellerService = sellerService;
    }
}
