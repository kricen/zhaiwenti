package com.wenti.service;

import com.wenti.dao.CartDao;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class CartService {
    private CartDao cartDao;

    public void setCartDao(CartDao cartDao) {
        this.cartDao = cartDao;
    }
}
