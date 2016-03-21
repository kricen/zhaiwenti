package com.wenti.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.Order;
import com.wenti.service.OrderService;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

/**
 * Created by Administrator on 2016/3/19 0019.
 */
@Scope("prototype")
@ParentPackage("seller-default")
@Namespace(value="/seller")
@Results({
})
@ExceptionMappings({
})
public class SellerOrderAction extends ActionSupport implements ModelDriven<Order>{
    private Order order = new Order();
    public Order getModel() {
        return order;
    }
    private OrderService orderService;


    //待处理订单
    @Action(
            value = "pendingOrderPage",
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/pendingOrders.jsp")
            }
    )
    public String pendindOrderPage(){

        return SUCCESS;
    }

    @Action(
            value = "waitingOrderPage",
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/acceptOrder.jsp")
            }
    )
    public String waitingOrderPage(){

        return SUCCESS;
    }

    @Action(
            value = "completeOrderPage",
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/completeOrder.jsp")
            }
    )
    public String completeOrderPage(){

        return SUCCESS;
    }


    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }
}
