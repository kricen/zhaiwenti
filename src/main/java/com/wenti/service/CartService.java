package com.wenti.service;

import com.wenti.dao.CartDao;
import com.wenti.domain.Cart;
import com.wenti.domain.Cartitem;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
@Transactional
public class CartService {
    private CartDao cartDao;

    //删除购物清单
    public void delCartitem(Cartitem cartitem){
        cartDao.delCartitem(cartitem);
    }
    //删除购物车
    public void delCart(Cart cart){
        cartDao.delCart(cart);
    }
    //根据购物车id获得购物车清单列表
    public List<Cartitem> getCartitemListByCart(int cartId){
        return cartDao.getCartitemListByCart(cartId);
    }
    //根据购物车id和商品id获得购物车清单
    public Cartitem getCartByCartProduct(int cartId,int productId){
        return cartDao.getCartByCartProduct(cartId,productId);
    }

    //根据用户得到购物车
    public Cart getCartByUser(int userId){
        return cartDao.getCartByUser(userId);
    }

    public void testLazy(){
        Cart cart = cartDao.getCartByUser(1);
        System.out.println(cart.getUser().getName());
    }

    //保存购物车
    public void save(Cart cart){
        cartDao.save(cart);
    }

    //更新购物车
    public void update(Cart cart){
        cartDao.update(cart);
    }

    //保存购物车清单
    public void save(Cartitem cartitem){
        cartDao.save(cartitem);
    }

    //更改购物车清单
    public void update(Cartitem cartitem){
        cartDao.update(cartitem);
    }

    public void setCartDao(CartDao cartDao) {
        this.cartDao = cartDao;
    }
}
