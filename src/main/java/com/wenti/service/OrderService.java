package com.wenti.service;

import com.wenti.dao.OrderDao;
import com.wenti.domain.Order;
import com.wenti.domain.Orderitem;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
@Transactional
public class OrderService {
    private OrderDao orderDao;

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
