package com.wenti.dao;

import com.wenti.domain.Category;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class CategoryDao extends HibernateDaoSupport {

    //获得category列表
    public List<Category> getCategories(){
        String hql = "from Category where state=0 order by id ";
        List<Category> find = this.getHibernateTemplate().find(hql);
        return find;
    }
    //根据类别id获得category
    public Category getCategory(int id){
        return this.getHibernateTemplate().get(Category.class,id);
    }
    //根据名称获得category
    public Category getCategory(String name){
        String hql = "from Category where name=?";
        List<Category> find = this.getHibernateTemplate().find(hql,name);
        return find.isEmpty()? null:find.get(0);
    }

    //新增category
    public void save(Category category){
        this.getHibernateTemplate().save(category);
    }

    //更新category
    public void update(Category category){
        this.getHibernateTemplate().update(category);
    }
}
