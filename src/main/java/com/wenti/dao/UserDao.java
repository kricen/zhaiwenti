package com.wenti.dao;

import com.wenti.domain.User;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class UserDao extends HibernateDaoSupport {


    //根据tel得到用户
    public User getUser(String tel){
        String hql = "from User where tel=?";
        List<User> find = this.getHibernateTemplate().find(hql,tel);
        return find.isEmpty()? null:find.get(0);
    }

    //根据id得到用户
    public User getUser(int userId){
        User find = this.getHibernateTemplate().get(User.class,userId);
        return find;
    }

    //保存用户
    public void save(User user){
        this.getHibernateTemplate().save(user);
    }
}
