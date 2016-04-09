package com.wenti.service;

import com.wenti.dao.CategoryDao;
import com.wenti.domain.Category;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
@Transactional
public class CategoryService {
    private CategoryDao categoryDao;


    //获得category列表
    public List<Category> getCategories(){
        return categoryDao.getCategories();
    }
    //根据类别id获得category
    public Category getCategory(int id){
        return categoryDao.getCategory(id);
    }

    public String categoryOperation(int categoryId){
        Category category = categoryDao.getCategory(categoryId);
        if(category==null) return "notFound";
        if(category.getState()==0) category.setState(1);
        else category.setState(0);
        return "success";
    }

    //根据名称获得category
    public Category getCategory(String name){
        return categoryDao.getCategory(name);
    }

    //新增category
    public void save(Category category){
        categoryDao.save(category);
    }

    //更新category
    public void update(Category category){
        categoryDao.update(category);
    }

    public void setCategoryDao(CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }
}
