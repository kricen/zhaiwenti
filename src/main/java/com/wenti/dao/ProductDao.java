package com.wenti.dao;

import com.wenti.domain.Product;
import com.wenti.utils.CommonUtils;
import com.wenti.utils.PageHibernateCallback;
import org.springframework.instrument.classloading.ShadowingClassLoader;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class ProductDao extends HibernateDaoSupport {

    //获取product集合
    public List<Product> getProducts(){
        String hql = "from Product p where p.state=0  and p.seller<>null and p.category.state=0 order by p.category.id ,p.id desc";
        List<Product> find = this.getHibernateTemplate().find(hql);
        return find;
    }
    //获得product集合个数
    public int getProductCount(String name){
        if(name==null){
            String hql = "select count(*) from Product p where p.state=0  and p.seller<>null and p.category.state=0 order by p.hot desc ,p.id desc";
            List<Long> find = this.getHibernateTemplate().find(hql);
            return find.get(0).intValue();
        }else {
            name = CommonUtils.getSortString(name);
            String hql = "select count(*) from Product p where p.state=0 and p.name like ? and p.seller<>null and p.category.state=0 order by p.hot desc ,p.id desc";
            List<Long> find = this.getHibernateTemplate().find(hql,name);
            return find.get(0).intValue();
        }
    }

    //获得product集合
    public List<Product> getAllProduct(int limit, int startIndex,String name){
        if(name==null){
            String hql = "from Product p where p.state=0  and p.seller<>null and p.category.state=0 order by p.hot desc ,p.id desc";
            List<Product> find = this.getHibernateTemplate().execute(new PageHibernateCallback<Product>(hql,null, startIndex, limit));
            return find;
        }else {
            name = CommonUtils.getSortString(name);
            String hql = "from Product p where p.state=0 and p.name like ? and p.seller<>null and p.category.state=0 order by p.hot desc ,p.id desc";
            List<Product> find = this.getHibernateTemplate().execute(new PageHibernateCallback<Product>(hql,new Object[]{name}, startIndex, limit));
            return find;
        }

    }

    //根据id获得商品
    public Product getProduct(int id){
        Product product = this.getHibernateTemplate().get(Product.class,id);
        return product;
    }

    //根据name获得商品
    public Product getProduct(String name){
        String hql = "from Product where name=?";
        List<Product> find = this.getHibernateTemplate().find(hql,name);
        return find.isEmpty()? null:find.get(0);
    }
    //保存商品
    public void update(Product product){
        this.getHibernateTemplate().update(product);
    }

    //新增商品
    public void save(Product product) {
        this.getHibernateTemplate().save(product);
    }
}
