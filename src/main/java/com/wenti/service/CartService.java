package com.wenti.service;

import com.wenti.dao.CartDao;
import com.wenti.domain.Cartitem;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by lixiao on 16/9/1.
 */
@Transactional
public class CartService {
    private CartDao cartDao;



    //根据用户获得购物项集合
    public List<Cartitem> getEffectiveCartitems(int userId){
        return cartDao.getEffectiveCartitems(userId);
    }
    public List<Cartitem> getCartitems(int userId){
        return cartDao.getCartitems(userId);
    }

    //根据商品和用户获得购物项
    public Cartitem getCartitem(int productId,int userId){
        return cartDao.getCartitem(productId,userId);
    }

    // cartitem基本操作
    public void save(Cartitem cartitem){
        cartDao.save(cartitem);
    }
    public void update(Cartitem cartitem){
        cartDao.update(cartitem);
    }
    public Cartitem getCartitem(int id){
        return cartDao.getCartitem(id);
    }
    public void del(Cartitem cartitem){
        cartDao.del(cartitem);
    }

    public void changeNum(int cartitemId,int num){
        Cartitem cartitem = cartDao.getCartitem(cartitemId);
        if(cartitem!=null){
            cartitem.setNum(cartitem.getNum()+num);
            cartDao.update(cartitem);
        }
    }

    public CartDao getCartDao() {
        return cartDao;
    }

    public void setCartDao(CartDao cartDao) {
        this.cartDao = cartDao;
    }
}
