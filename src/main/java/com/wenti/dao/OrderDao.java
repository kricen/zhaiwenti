package com.wenti.dao;

import com.wenti.domain.Order;
import com.wenti.domain.Orderitem;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class OrderDao extends HibernateDaoSupport {

    //根据用户得到要提交的订单
    public Order getFukuanOrder(int userId){
        String hql = "from Order o where o.state=-1 and o.user.id=?";
        List<Order> find = this.getHibernateTemplate().find(hql,userId);
        return find.isEmpty()? null:find.get(0);
    }

    //根据用户得到order
    public Order getOrderByUser(int userId){
        String hql = "from Order o where o.user.id=?";
        List<Order> find = this.getHibernateTemplate().find(hql,userId);
        return find.isEmpty()? null:find.get(0);
    }

    //根据order获得订单清单集合
    public List<Orderitem> getOrderitemByOrder(int orderId){
        String hql = "from Orderitem o where o.order.id=?";
        List<Orderitem> find = this.getHibernateTemplate().find(hql,orderId);
        return find;
    }
    //根据订单以及商品获得这个订单项
    public Orderitem getOrderitemByOrderProduct(int orderId,int productId){
        String hql = "from Orderitem o where o.order.id=? and o.product.id=?";
        List<Orderitem> find = this.getHibernateTemplate().find(hql,orderId,productId);
        return find.isEmpty()? null:find.get(0);
    }
    //保存order
    public void save(Order order){
        this.getHibernateTemplate().save(order);
    }

    //保存orderitem
    public void save(Orderitem orderitem){
        this.getHibernateTemplate().save(orderitem);
    }

    //更新
    public void update(Order order){
        this.getHibernateTemplate().update(order);
    }
    //更新
    public void update(Orderitem orderitem){
        this.getHibernateTemplate().update(orderitem);
    }
}
