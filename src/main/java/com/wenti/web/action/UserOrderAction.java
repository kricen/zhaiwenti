package com.wenti.web.action;

/**
 * Created by Administrator on 2016/3/21 0021.
 */

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.Order;
import com.wenti.domain.Orderitem;
import com.wenti.domain.Product;
import com.wenti.domain.User;
import com.wenti.service.OrderService;
import com.wenti.service.UserService;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import java.util.List;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
@Scope("prototype")
@ParentPackage("user-default")
@Namespace(value="/user")
@Results({
})
public class UserOrderAction extends ActionSupport implements ModelDriven<Order>{
    private Order order = new Order();
    public Order getModel() {
        return order;
    }

    private OrderService orderService;
    private UserService userService;

    //进入订单页面
    @Action(
            value = "orderPage",
            results = {
                    @Result(name = SUCCESS,location = "/userPages/orders.jsp")
            }
    )
    public String orderPage(){

        return SUCCESS;
    }


    //进入订单详情页面
    @Action(
            value = "orderInfoPage",
            results = {
                    @Result(name = SUCCESS,location = "/userPages/orderInfo.jsp")
            }
    )
    public String orderInfoPage(){
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        user = userService.getUser(user.getId());
        order = orderService.getFukuanOrder(user.getId());
        if(order==null){
            return ERROR;
        }else {
            List<Orderitem> orderitems = orderService.getOrderitemByOrder(order.getId());
            if(orderitems.size()<=0){
                return ERROR;
            }
            int totalNum = 0;
            for(int i=0;i<orderitems.size();i++){
                totalNum+=orderitems.get(i).getNum();
            }
            ActionContext.getContext().getValueStack().set("num",totalNum);
            ActionContext.getContext().getValueStack().set("orderitems",orderitems);
            ActionContext.getContext().getValueStack().set("user",user);
            ActionContext.getContext().getValueStack().set("order",order);
        }
        return SUCCESS;
    }


    //properties
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
