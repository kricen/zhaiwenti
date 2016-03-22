package com.wenti.web.action;

/**
 * Created by Administrator on 2016/3/21 0021.
 */

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.*;
import com.wenti.service.CartService;
import com.wenti.service.OrderService;
import com.wenti.service.ProductService;
import com.wenti.utils.CommonUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
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
})
public class UserCartAction extends ActionSupport implements ModelDriven<Product>{
    private Product product = new Product();
    public Product getModel() {
        return product;
    }
    private ProductService productService;
    private CartService cartService;
    private OrderService orderService;

    @Action(
            value = "cartToOrder",
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String cartToOrder(){
        User user = (User)ServletActionContext.getRequest().getSession().getAttribute("user");
        Cart cart = cartService.getCartByUser(user.getId());
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        if(cart==null){
            writer.write("index");
        }else {
            List<Cartitem> cartitemList = cartService.getCartitemListByCart(cart.getId());
            if(cartitemList.size()<=0){
                cartService.delCart(cart);
                writer.write("index");
            }else {
                Order order = new Order();
                order.setState(-1);
                order.setUser(user);
                order.setOrdertime(CommonUtils.getNowTime());
                order.setTotalFee(0);
                orderService.save(order);
                /* private Seller seller;*/
                for(int i=0;i<cartitemList.size();i++){
                    Cartitem cartitem = cartitemList.get(i);
                    Orderitem orderitem = new Orderitem();
                    if(order.getSeller()==null){
                        order.setSeller(cartitem.getSeller());
                    }
                    orderitem.setOrder(order);
                    orderitem.setProduct(cartitem.getProduct());
                    orderitem.setNum(cartitem.getNum());
                    order.setTotalFee(order.getTotalFee()+cartitem.getNum()*cartitem.getProduct().getPrice());
                    orderService.save(orderitem);
                    cartService.delCartitem(cartitem);
                    orderService.update(order);
                }
                cartService.delCart(cart);
                writer.write("success");
            }
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }
    //进入cart页面
    @Action(
            value = "cartPage",
            results = {
                    @Result(name = SUCCESS,location = "/userPages/cart.jsp")
            }
    )
    public String cartPage(){

        return SUCCESS;
    }
    //商品加入cart
    @Action(
            value = "addCart",
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String addCart(){
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        Product findProduct = productService.getProduct(product.getId());
        Cart cart = cartService.getCartByUser(user.getId());
        if(cart==null){
            cart = new Cart();
            cart.setUser(user);
            cartService.save(cart);
            Cartitem cartitem = new Cartitem();
            cartitem.setProduct(findProduct);
            cartitem.setCart(cart);
            cartitem.setNum(product.getNum());
            cartitem.setSeller(findProduct.getSeller());
            cartService.save(cartitem);

        }else {
            Cartitem cartitem = cartService.getCartByCartProduct(cart.getId(),product.getId());
            if(cartitem==null){
                cartitem = new Cartitem();
                cartitem.setProduct(findProduct);
                cartitem.setCart(cart);
                cartitem.setNum(product.getNum());
                cartitem.setSeller(findProduct.getSeller());
                cartService.save(cartitem);
            }else {
                cartitem.setNum(product.getNum());
                cartService.update(cartitem);
            }
        }
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //private functions


    //properties

    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setCartService(CartService cartService) {
        this.cartService = cartService;
    }
}
