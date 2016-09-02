package com.wenti.service;

import com.wenti.dao.OrderDao;
import com.wenti.domain.Order;
import com.wenti.domain.Orderitem;
import com.wenti.domain.Product;
import com.wenti.dto.OrderBaseBean;
import com.wenti.utils.PageBean;
import org.htmlparser.lexer.Page;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
@Transactional
public class OrderService {
    private OrderDao orderDao;

     //改变订单的状态
    public boolean changeOrderState(Order order,int sellerId){
        return orderDao.changeOrderState(order,sellerId);
    }
    //根据状态获得pageBean
    public PageBean<Order> getOrderByTel(int page,String tel,int state,String url){
        PageBean<Order> pageBean = new PageBean<Order>();
        pageBean.setUrl(url);
        int limit = 10;
        pageBean.setLimit(limit);
        int totalCount = 0;
        if(page<=1){
            page = 1;
        }
        if(tel==null){
            totalCount = orderDao.stateOrdersCount(state);
            pageBean.setList(orderDao.stateOrders(limit, (page - 1) * limit,state));
        }else {
            if(tel.length()==11){
                totalCount = orderDao.getOrdersByTelStateCount(tel,state);
                pageBean.setList(orderDao.getOrdersByTelState(limit, (page - 1) * limit,tel,state));
            }else{
                int id = Integer.parseInt(tel);
                List<Order> orders = orderDao.getOrderById(id,state);
                totalCount = orders.size();
                pageBean.setList(orders);
            }
        }
        pageBean.setTotalCount(totalCount);
        int totalPage = 0;
        if(totalCount%limit==0){
            totalPage = totalCount/limit;
        }else{
            totalPage = totalCount/limit +1;
        }
        if(page>=totalPage){
            page=totalPage;
        }
        pageBean.setPage(page);
        int size= 10;
        pageBean.setSize(size);
        int endIndex = page;
        int startIndex = page;
        //对初始页和结束页做操作
        while(true){
            if(endIndex<totalPage){
                endIndex++;
            }
            if(endIndex-startIndex==size-1){
                break;
            }
            if (startIndex>1){
                startIndex--;
            }
            if(endIndex>=totalPage&&startIndex<=1){
                break;
            }
        }
        pageBean.setStartIndex(startIndex);
        pageBean.setEndIndex(endIndex);
        pageBean.setTotalPage(totalPage);

        return pageBean;
    }

    public List<Order> getOrderByState(int page, int state, int userId){
        int limit = 8;
        int startIndex = (page-1)*limit;
        List<Order> orders = orderDao.getOrderByState(state,userId,limit,startIndex);
        return orders;
    }

    //根据用户得到要提交的订单
    public Order getFukuanOrder(int userId){
        return orderDao.getFukuanOrder(userId);
    }

    //根据order获得订单清单集合
    public List<Orderitem> getOrderitemByOrder(int orderId){
        return orderDao.getOrderitemByOrder(orderId);
    }

    //根据订单以及商品获得这个订单项
    public Orderitem getOrderitemByOrderProduct(int orderId,int productId){
        return orderDao.getOrderitemByOrderProduct(orderId,productId);
    }

    //根据用户得到order
    public Order getOrderByUser(int userId){
        return orderDao.getOrderByUser(userId);
    }

    //根据订单编号获得订单
    public Order getOrder(int orderId){
        return orderDao.getOrder(orderId);
    }

    //根据用户获得订单
    public List<Order> getOrdersByStateUser(int state,int userId,int page){
        if(page<=1){
            page = 1;
        }
        int limit = 10;


        return orderDao.getOrdersByStateUser(state,userId,limit, (page - 1) * limit);
    }
    //删除订单项
    public void delOrderitem(List<Orderitem> orderitems){
        orderDao.delOrderitem(orderitems);
    }

    //删除订单
    public void delOrder(Order order){
        List<Orderitem> orderitems = getOrderitemByOrder(order.getId());
        orderDao.delOrderitem(orderitems);
        orderDao.delOrder(order);
    }

    //获得这个用户的所有有效订单
    public List<Order> getOrders(int userId){
        return orderDao.getOrders(userId);
    }
    //保存order
    public void save(Order order){
        orderDao.save(order);
    }


    //保存orderitem
    public void save(Orderitem orderitem){
        orderDao.save(orderitem);
    }

    //更新
    public void update(Order order){
        orderDao.update(order);
    }

    //更新
    public void update(Orderitem orderitem){
        orderDao.update(orderitem);
    }
    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }
}
