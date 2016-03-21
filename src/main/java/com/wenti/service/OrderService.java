package com.wenti.service;

import com.wenti.dao.OrderDao;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class OrderService {
    private OrderDao orderDao;

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }
}
