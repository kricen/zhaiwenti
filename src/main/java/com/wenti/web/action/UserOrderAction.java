package com.wenti.web.action;

/**
 * Created by Administrator on 2016/3/21 0021.
 */

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.*;
import com.wenti.service.OrderService;
import com.wenti.service.UserService;
import com.wenti.utils.CommonUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import java.io.PrintWriter;
import java.util.ArrayList;
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
            interceptorRefs = {
                    @InterceptorRef(value = "userActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/userPages/orders.jsp")
            }
    )
    public String orderPage(){
        User user = (User)ServletActionContext.getRequest().getSession().getAttribute("user");
        List<Order> orderList = orderService.getOrders(user.getId());
        List<Order> pendingOrders = new ArrayList<Order>();
        List<Order> ongoingOrders = new ArrayList<Order>();
        List<Order> completeOrders = new ArrayList<Order>();
        for(int i=0;i<orderList.size();i++){
            order = orderList.get(i);
            Iterator<Orderitem> iterator = order.getOrderitems().iterator();
            int num = 0;
            while (iterator.hasNext()){
                num += iterator.next().getNum();
            }
            order.setNum(num);
            if(order.getState()==-1||order.getState()==0) pendingOrders.add(order);
            if(order.getState()==1) ongoingOrders.add(order);
            if(order.getState()==2||order.getState()==3) completeOrders.add(order);
        }
        ActionContext.getContext().getValueStack().set("pendingOrders",pendingOrders);
        ActionContext.getContext().getValueStack().set("ongoingOrders",ongoingOrders);
        ActionContext.getContext().getValueStack().set("completeOrders",completeOrders);
        return SUCCESS;
    }

    //用户删除订单。可见性变成1
    @Action(
            value = "userDelOrder",
            interceptorRefs = {
                    @InterceptorRef(value = "userJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String userDelOrder(){
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        order = orderService.getOrder(order.getId());
        if(order==null||!order.getUser().getId().equals(user.getId())){
            writer.write("error");
        }else {
            order.setVisible(1);
            orderService.update(order);
            writer.write("success");
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }
    //用户删除订单。
    @Action(
            value = "cancelOrder",
            interceptorRefs = {
                    @InterceptorRef(value = "userJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String cancelOrder(){
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        order = orderService.getOrder(order.getId());
        if(order==null||!order.getUser().getId().equals(user.getId())||order.getState()!=-1){
            writer.write("error");
        }else {
            orderService.delOrderitem(orderService.getOrderitemByOrder(order.getId()));
            orderService.delOrder(order);
            writer.write("success");
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //进入订单详情页面
    @Action(
            value = "orderInfoPage",
            interceptorRefs = {
                    @InterceptorRef(value = "userActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/userPages/orderInfo.jsp"),
                    @Result(name = ERROR,location = "/userPages/error.jsp")
            }
    )
    public String orderInfoPage(){
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        user = userService.getUser(user.getId());
        if(order.getId()==null || order.getId()==0){
            order = orderService.getFukuanOrder(user.getId());
        }else {
            order = orderService.getOrder(order.getId());
        }
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
            Seller seller = order.getSeller();
            ActionContext.getContext().getValueStack().set("num",totalNum);
            ActionContext.getContext().getValueStack().set("deliverFee",seller.getDeliveryFee());
            ActionContext.getContext().getValueStack().set("orderitems",orderitems);
            ActionContext.getContext().getValueStack().set("user",user);
            ActionContext.getContext().getValueStack().set("order",order);
        }
        return SUCCESS;
    }

    //用户提交订单
    @Action(
            value = "orderSubmit",
            interceptorRefs = {
                    @InterceptorRef(value = "userJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String orderSubmit(){
        User user = (User)ServletActionContext.getRequest().getSession().getAttribute("user");
        Order findOrder = orderService.getOrder(order.getId());
        user = userService.getUser(user.getId());
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        if (findOrder==null||user==null||findOrder.getUser().getId()!=user.getId()){
            writer.write("error");
        }else{
            if(order.getName()==null||order.getAddr()==null){
                writer.write("notNull");
            }else {
                findOrder.setName(order.getName());
                user.setName(order.getName());
                findOrder.setAddr(order.getAddr());
                user.setAddr(order.getAddr());
                findOrder.setRemark(order.getRemark());
                findOrder.setState(0);
                findOrder.setTel(order.getTel());
                orderService.update(findOrder);
                userService.update(user);
                writer.write("success");
            }
        }
        writer.flush();
        writer.close();
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
