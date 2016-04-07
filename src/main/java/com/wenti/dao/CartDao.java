package com.wenti.dao;

import com.wenti.domain.Cart;
import com.wenti.domain.Cartitem;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class CartDao extends HibernateDaoSupport{

    //删除购物清单
    public void delCartitem(Cartitem cartitem){
       this.getHibernateTemplate().delete(cartitem);
    }
    //删除购物车
    public void delCart(Cart cart){
        this.getHibernateTemplate().delete(cart);
    }

    //根据购物车id获得购物车清单列表
    public List<Cartitem> getCartitemListByCart(int cartId){
        String hql = "from Cartitem c where c.cart.id=?";
        List<Cartitem> find = this.getHibernateTemplate().find(hql,cartId);
        return find;
    }

    //根据购物车id和商品id获得购物车清单
    public Cartitem getCartByCartProduct(int cartId,int productId){
        String hql = "from Cartitem c where c.cart.id=? and c.product.id=?";
        List<Cartitem> find = this.getHibernateTemplate().find(hql,cartId,productId);
        return find.isEmpty()? null:find.get(0);
    }

    //根据用户得到购物车
    public Cart getCartByUser(int userId){
        String hql = "from Cart c where c.user.id=?";
        List<Cart> find = this.getHibernateTemplate().find(hql,userId);
        return find.isEmpty()? null:find.get(0);
    }

    //保存购物车
    public void save(Cart cart){
        this.getHibernateTemplate().save(cart);
    }

    //更新购物车
    public void update(Cart cart){
        this.getHibernateTemplate().update(cart);
    }

    //保存购物车清单
    public void save(Cartitem cartitem){
        this.getHibernateTemplate().save(cartitem);
    }

    //更改购物车清单
    public void update(Cartitem cartitem){
        this.getHibernateTemplate().update(cartitem);
    }

}
