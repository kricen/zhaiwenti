package com.wenti.dao;

import com.wenti.domain.Cartitem;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by lixiao on 16/9/1.
 */
public class CartDao extends HibernateDaoSupport{


    //根据用户获得购物项集合
    public List<Cartitem> getCartitems(int userId){
        String hql = "from Cartitem c where c.user=? order by c.id";
        List<Cartitem> find = this.getHibernateTemplate().find(hql,userId);
        return find;
    }
    public List<Cartitem> getEffectiveCartitems(int userId){
        String hql = "from Cartitem c where c.user=? and c.num>0 order by c.id";
        List<Cartitem> find = this.getHibernateTemplate().find(hql,userId);
        return find;
    }

    //根据商品和用户获得购物项
    public Cartitem getCartitem(int productId,int userId){
        String hql = "from Cartitem c where c.product.id=? and c.user=?";
        List<Cartitem> find = this.getHibernateTemplate().find(hql,productId,userId);
        return find.isEmpty()? null:find.get(0);
    }

    // cartitem基本操作
    public void save(Cartitem cartitem){
        this.getHibernateTemplate().save(cartitem);
    }
    public void update(Cartitem cartitem){
        this.getHibernateTemplate().update(cartitem);
    }
    public Cartitem getCartitem(int id){
        return this.getHibernateTemplate().get(Cartitem.class,id);
    }
    public void del(Cartitem cartitem){
        this.getHibernateTemplate().delete(cartitem);
    }

}
