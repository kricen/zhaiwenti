package com.wenti.web.action;

/**
 * Created by Administrator on 2016/3/21 0021.
 */

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.*;
import com.wenti.service.CartService;
import com.wenti.service.OrderService;
import com.wenti.service.ProductService;
import com.wenti.service.UserService;
import com.wenti.utils.CommonUtils;
import com.wenti.wenxin.CommonUtil;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.context.annotation.Scope;

import java.io.PrintWriter;
import java.util.ArrayList;
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
//@ExceptionMappings({
//        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
//})
public class UserCartAction extends ActionSupport implements ModelDriven<Product>{
    private Product product = new Product();
    public Product getModel() {
        return product;
    }
    private ProductService productService;
    private OrderService orderService;
    private String  arrs;
    private int num;
    private UserService userService;
    private CartService cartService;



    //待处理订单
    @Action(
            value = "cartPage",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/cart.jsp")
            }
    )
    public String cartPage(){
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        List<Cartitem> cartitems = cartService.getCartitems(sessionUser.getId());
        ActionContext.getContext().getValueStack().set("cartitems",cartitems);
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "cartChangeNum",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String cartChangeNum(){
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        cartService.changeNum(product.getId(),product.getNum());
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }


    //待处理订单
    @Action(
            value = "delCartitem",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String delCartitem(){
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        Cartitem cartitem = cartService.getCartitem(product.getId());
        cartService.del(cartitem);
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }



    //增加到购物车操作
    @Action(
            value = "addCart",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String addCart(){
        PrintWriter writer = CommonUtil.getHtmlPrintWriter(ServletActionContext.getResponse());
        User sessionUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        Product findProduct = productService.getProduct(product.getId());
        if (findProduct==null){
            writer.write("error");
            writer.flush();
            writer.close();
            return SUCCESS;
        }
        Cartitem cartitem = cartService.getCartitem(findProduct.getId(),sessionUser.getId());
        if(cartitem==null){
            cartitem = new Cartitem();
            cartitem.setFee(findProduct.getPrice());
            cartitem.setNum(product.getNum());
            cartitem.setProduct(findProduct);
            cartitem.setUser(sessionUser.getId());
            cartService.save(cartitem);
        }else {
            cartitem.setNum(cartitem.getNum()+product.getNum());
            cartService.update(cartitem);
        }
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //properties
    public void setNum(int num) {
        this.num = num;
    }

    public void setArrs(String arrs) {
        this.arrs = arrs;
    }

    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setCartService(CartService cartService) {
        this.cartService = cartService;
    }
}
