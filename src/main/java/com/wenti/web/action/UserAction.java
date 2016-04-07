package com.wenti.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.Cart;
import com.wenti.domain.Cartitem;
import com.wenti.domain.ProductBean;
import com.wenti.domain.User;
import com.wenti.service.CartService;
import com.wenti.service.ProductService;
import com.wenti.service.UserService;
import com.wenti.utils.CommonUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2016/3/17 0017.
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
        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
})
public class UserAction extends ActionSupport implements ModelDriven<User>{
    private User user = new User();
    private int page;
    public User getModel() {
        return user;
    }
    private UserService userService;
    private ProductService productService;
    private CartService cartService;



    @Action(
            value = "errorPage",
            interceptorRefs = {
                    @InterceptorRef(value = "userActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/userPages/error.jsp")
            }
    )
    public String errorPage(){

        return SUCCESS;
    }
    //选择主页面
    @Action(
            value = "centerPage",
            interceptorRefs = {
                    @InterceptorRef(value = "userActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/userPages/center.jsp")
            }
    )
    public String centerPage(){

        return SUCCESS;
    }

    //index 页面
    @Action(
            value = "index",
            interceptorRefs = {
                    @InterceptorRef(value = "userActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/userPages/index.jsp")
            }
    )
    public String index(){
        User sessionUser = (User)ServletActionContext.getRequest().getSession().getAttribute("user");
        Cart cart = cartService.getCartByUser(sessionUser.getId());
        List<Cartitem> cartitems = null;
        if(cart!=null){
            cartitems = cartService.getCartitemListByCart(cart.getId());
        }
        if(cartitems!=null){
            for(int i=0;i<cartitems.size();i++){
                if(cartitems.get(i).getNum()<=0){
                    cartService.delCartitem(cartitems.get(i));
                    cartitems.remove(cartitems.get(i));
                }
            }
        }
        List<ProductBean> productBeanList = productService.getProductBeanList(cartitems);
        ServletActionContext.getContext().getValueStack().set("productBeanList",productBeanList);
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

    //用户登录缓冲页面
    @Action(
            value = "huanchong",
            results = {
                    @Result(name = SUCCESS,location = "/userPages/huanchong.jsp")
            }
    )
    public String huanchong(){

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

    public void setCartService(CartService cartService) {
        this.cartService = cartService;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
