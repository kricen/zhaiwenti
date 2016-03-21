package com.wenti.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.User;
import com.wenti.service.ProductService;
import com.wenti.service.UserService;
import com.wenti.utils.CommonUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;
import sun.print.PrinterJobWrapper;

import java.io.PrintWriter;
import java.util.List;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
@Scope("prototype")
@ParentPackage("user-default")
@Namespace(value="/user")
@Results({
})
@ExceptionMappings({
})
public class UserAction extends ActionSupport implements ModelDriven<User>{
    private User user = new User();
    private int page;
    public User getModel() {
        return user;
    }
    private UserService userService;
    private ProductService productService;

    //index 页面
    @Action(
            value = "index",
            results = {
                    @Result(name = SUCCESS,location = "/userPages/index.jsp")
            }
    )
    public String index(){
        List<ProductBean> productBeanList = productService.getProductBeanList();
        return SUCCESS;
    }
    //validateUser校验用户
    @Action(
            value = "validateUser",
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String validateUser(){
        User findUser = userService.getUser(user.getTel());
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        if(findUser!=null){
            ServletActionContext.getRequest().getSession().setAttribute("user",findUser);
            writer.write("success");
        }else {
            writer.write("not_find");
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }
    //新增用户
    @Action(
            value = "addUser",
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String addUser(){
        User findUser = userService.getUser(user.getTel());
        if(findUser==null){
            findUser = new User();
            findUser.setState(0);
            findUser.setTel(user.getTel());
            if(user.getName()!=null){
                findUser.setName(user.getName());
            }
            if(user.getAddr()!=null){
                findUser.setAddr(user.getAddr());
            }
            userService.save(findUser);
            //session中保存一份user
            ServletActionContext.getRequest().getSession().setAttribute("user",findUser);
        }

        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //用户登录页面
    @Action(
            value = "login",
            results = {
                    @Result(name = SUCCESS,location = "/userPages/login.jsp")
            }
    )
   public String login(){
        //如果 page为0 进入购买页面 如果page为1那么进入购物车页面，如果page为3进入购物车
        ServletActionContext.getContext().getValueStack().set("page",page);
       return SUCCESS;
   }


    public void setPage(int page) {
        this.page = page;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
