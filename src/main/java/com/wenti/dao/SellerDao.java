package com.wenti.dao;

import com.wenti.domain.Seller;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class SellerDao extends HibernateDaoSupport {
    //通过账号名密码获得商家
    public Seller getSellerByTelPwd(String tel, String password){
        String hql = "from Seller where tel=? and password=?";
        List<Seller> find = this.getHibernateTemplate().find(hql,tel,password);
        return find.isEmpty()? null:find.get(0);
    }

}
