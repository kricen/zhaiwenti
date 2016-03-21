package com.wenti.web.action;

/**
 * Created by Administrator on 2016/3/21 0021.
 */

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
@Scope("prototype")
@ParentPackage("user-default")
@Namespace(value="/user")
@Results({
})
public class UserCartAction extends ActionSupport{
    @Action(
            value = "cartPage",
            results = {
                    @Result(name = SUCCESS,location = "/userPages/cart.jsp")
            }
    )
    public String cartPage(){

        return SUCCESS;
    }
}
