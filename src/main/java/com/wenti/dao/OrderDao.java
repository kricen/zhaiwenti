package com.wenti.dao;

import com.wenti.domain.Order;
import com.wenti.domain.Orderitem;
import com.wenti.utils.PageHibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class OrderDao extends HibernateDaoSupport {

    /**
     * 改变order的状态
     */
    public boolean changeOrderState(Order order,int sellerId){
        Order find = this.getHibernateTemplate().get(Order.class, order.getId());
        if(find==null||find.getSeller().getId()!=sellerId){
            return false;
        }
        if(order.getSuccessDate()!=null){
            find.setSuccessDate(order.getSuccessDate());
        }
        if(order.getOrdertime()!=null){
            find.setOrdertime(order.getOrdertime());
        }
        find.setState(order.getState());
        this.getHibernateTemplate().update(find);
        return true;
    }

    //根据订单状态获得订单列表
    public List<Order> getOrderByState(int state,int userId,int limit,int startIndex){
        List<Order> find;
        if(state==10){
            String hql = "from Order o where o.user.id=? order by id desc";
            find= this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{userId}, startIndex, limit));
        }
        else if(state==8){
            String hql = "from Order o where o.user.id=? and state in(0,1) order by id desc";
            find= this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{userId}, startIndex, limit));
        }
        else if(state==9){
            String hql = "from Order o where o.user.id=? and state in(2,3) order by id desc";
            find= this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{userId}, startIndex, limit));
        }
        else {
            String hql = "from Order o where o.user.id=? and state=? order by id desc";
            find= this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{userId,state}, startIndex, limit));
        }
        return find;
    }

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

    //根据订单编号获得订单
    public Order getOrder(int orderId){
        Order order = this.getHibernateTemplate().get(Order.class,orderId);
        return order;
    }

    /**
     * 根据订单状态和用户获得订单列表
     * 如果state为0 则取订单状态为零的订单
     * 如果state为1 则取状态为一的订单
     * 如果state为2 择取状态为二的订单
     * 若果state为3 则取状态为三的订单
     * 如果state为5 则取012的订单
     * 如果state为7 取23的订单
     * 其他，取所有的订单
     */
    public List<Order> getOrdersByStateUser(int state,int userId,int limit,int startIndex){
        String hql = null;
        List<Order> find = new ArrayList<Order>();
        System.out.println(state+"sdjfsdfsidfjsdifjsi");
        if(state>=-1&&state<=3){
            hql = "from Order o where o.state = ? and o.user.id=? order by o.id desc ";
            find = this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{state,userId},startIndex,limit));
        }else if(state==5){
            hql = "from Order o where o.user.id=? and o.state in(0,1) order by o.id desc";
            find = this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{userId},startIndex,limit));
        }else if(state==6){
            hql = "from Order o where o.user.id=? and o.state in(2,3) order by o.id desc";
            find = this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{userId},startIndex,limit));
        }else {
            hql = "from Order o where o.user.id=? and o.state in(-1,0,1,2,3) order by o.id desc";
            find = this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{userId},startIndex,limit));
        }
        return find;
    }

    //根据订单编号以及状态获得订单
    public List<Order> getOrderById(int orderId,int state){
        String hql = "";
        if(state>=0&&state<=3){
            hql = "from Order where id=? and state="+state;
        }else {
            hql = "from Order where id=? and state in(2,3)";
        }

        List<Order> find = this.getHibernateTemplate().find(hql,orderId);
        return find;
    }

    //根据手机号以及订单状态获得订单列表
    public int getOrdersByTelStateCount(String tel,int state){
        String hql = "";
        if(state>=0&&state<=3){
            hql = "select count(*) from Order where tel=? and state="+state;
        }else {
            hql = "select count(*) from Order where tel=? and state in(2,3)";
        }
        List<Long> find = this.getHibernateTemplate().find(hql,tel);

        return find.get(0).intValue();
    }
    public List<Order> getOrdersByTelState(int limit, int startIndex,String tel,int state){
        String hql = "";
        if(state>=0&&state<=3){
            hql = "from Order where tel=? and state="+state+" order by id desc";
        }else {
            hql = "from Order where tel=? and state in(2,3) order by id desc";
        }
        List<Order> find = this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,new Object[]{tel},startIndex, limit));
        return find;
    }

    //根据订单状态获得订单列表
    public int stateOrdersCount(int state){
        String hql = "";
        if(state>=0&&state<=3){
            hql = "select count(*) from Order where state="+state;
        }else {
            hql = "select count(*) from Order where state in(2,3)";
        }
        List<Long> find =this.getHibernateTemplate().find(hql);
        return find.get(0).intValue();
    }
    public List<Order> stateOrders(int limit,int startIndex,int state){
        String hql = "";
        if(state>=0&&state<=3){
            hql = "from Order where state="+state+" order by id desc";
        }else {
            hql = "from Order where state in(2,3) order by id desc";
        }
        List<Order> find = this.getHibernateTemplate().execute(new PageHibernateCallback<Order>(hql,null,startIndex, limit));
        return find;
    }

    //删除订单项
    public void delOrderitem(List<Orderitem> orderitems){
        this.getHibernateTemplate().deleteAll(orderitems);
    }

    //删除订单
    public void delOrder(Order order){
        this.getHibernateTemplate().delete(order);
    }

    //获得这个用户的所有有效订单
    public List<Order> getOrders(int userId){
        String hql = "from Order o where o.user.id=? and state >=-1 and state<=3 and o.visible=0 order by id";
        List<Order> orders = this.getHibernateTemplate().find(hql,userId);
        return orders;
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
