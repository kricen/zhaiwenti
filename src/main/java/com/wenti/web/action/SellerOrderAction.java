package com.wenti.web.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.domain.*;
import com.wenti.service.OrderService;
import com.wenti.utils.CommonUtils;
import com.wenti.utils.PageBean;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2016/3/19 0019.
 */
@Scope("prototype")
@ParentPackage("seller-default")
@Namespace(value="/seller")
@Results({
        @Result(name="sellerJsonLogin",type="json"),
        @Result(name="sellerActionLogin",location="login",type="redirectAction"),
        @Result(name = "notFound",location="pendingOrderPage",type="redirectAction" ),
        @Result(name = "loginPage",location="login",type="redirectAction" ),
})
@ExceptionMappings({
        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
})
public class SellerOrderAction extends ActionSupport implements ModelDriven<Order>{
    private Order order = new Order();
    public Order getModel() {
        return order;
    }
    private OrderService orderService;
    private int page;


    //待处理订单
    @Action(
            value = "pendingOrderPage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/pendingOrders.jsp")
            }
    )
    public String pendingOrderPage(){
        PageBean<Order> pageBean = orderService.getOrderByTel(page,order.getTel(),0,"/seller/pendingOrderPage.action");
        ActionContext.getContext().getValueStack().set("pageBean",pageBean);
        return SUCCESS;
    }

    @Action(
            value = "waitingOrderPage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/acceptOrder.jsp")
            }
    )
    public String waitingOrderPage(){
        PageBean<Order> pageBean = orderService.getOrderByTel(page,order.getTel(),1,"/seller/waitingOrderPage.action");
        ActionContext.getContext().getValueStack().set("pageBean",pageBean);
        return SUCCESS;
    }

    @Action(
            value = "completeOrderPage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/completeOrder.jsp")
            }
    )
    public String completeOrderPage(){
        PageBean<Order> pageBean = orderService.getOrderByTel(page,order.getTel(),4,"/seller/completeOrderPage.action");
        ActionContext.getContext().getValueStack().set("pageBean",pageBean);
        return SUCCESS;
    }

    @Action(
            value = "changeOrderState",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String changeOrderState(){
        Seller seller = (Seller)ServletActionContext.getRequest().getSession().getAttribute("seller");
        if(order.getState()==1){
            //发送接单消息模板
            order.setSuccessDate(CommonUtils.getNowTime());
        }
        if(order.getState()==2){
            //交易成功
            order.setSuccessDate(CommonUtils.getNowTime());
        }
        if(order.getState()==3){
            order.setSuccessDate(CommonUtils.getNowTime());
            //交易失败
        }
        boolean result = orderService.changeOrderState(order,seller.getId());
        //发送模板消息
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        if(result){
            writer.write("success");
        }else{
            writer.write("error");
        }
        if(writer!=null){
            writer.flush();
            writer.close();
        }
        return SUCCESS;
    }

    @Action(
            value = "orderInfo",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String orderInfo(){
        Order findOrder = orderService.getOrder(order.getId());
        OrderBean orderBean = new OrderBean();
        if(findOrder.getState()==2||findOrder.getState()==3){
            orderBean.setDate(findOrder.getSuccessDate().toString());
        }else {
            orderBean.setDate(findOrder.getOrdertime().toString());
        }
        orderBean.setAddr(findOrder.getAddr());
        orderBean.setName(findOrder.getName());
        orderBean.setTel(findOrder.getTel());
        orderBean.setPrice(findOrder.getTotalFee());
        orderBean.setRemark(findOrder.getRemark());
        List<Product> products = new ArrayList<Product>();
        Iterator<Orderitem> iterator = findOrder.getOrderitems().iterator();
        int totalCount = 0;
        while (iterator.hasNext()){
            Orderitem orderitem = iterator.next();
            totalCount += orderitem.getNum();
            orderitem.getProduct().setNum(orderitem.getNum());
            products.add(orderitem.getProduct());
        }
        orderBean.setNum(totalCount);
        orderBean.setProducts(products);
        String json = JSONObject.fromObject(orderBean,getConfig()).toString();
        PrintWriter writer = CommonUtils.getJsonPrintWriter(ServletActionContext.getResponse());
        writer.write(json);
        if(writer!=null){
            writer.flush();
            writer.close();
        }
        return SUCCESS;

    }

    //private functions

    private JsonConfig getConfig(){
        JsonConfig config = new JsonConfig();
        config.setIgnoreDefaultExcludes(false);
        config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
        config.setExcludes(new String[]{
        "cartitems","orderitems","seller","category","state","sellNum","hot"
        });
        return config;
    }

    //properties
    public void setPage(int page) {
        this.page = page;
    }



    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }
}
