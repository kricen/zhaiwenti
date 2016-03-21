package com.wenti.service;

import com.wenti.dao.ProductDao;
import com.wenti.domain.Product;
import com.wenti.utils.PageBean;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class ProductService {
    private ProductDao productDao;

    //获得product集合
    public PageBean<Product> getPBeanProduct(int page,String name){
        PageBean<Product> pageBean = new PageBean<Product>();
        int limit = 10;
        pageBean.setLimit(limit);
        int totalCount = productDao.getProductCount(name);
        pageBean.setTotalCount(totalCount);
        int totalPage = 0;
        if(totalCount%limit==0){
            totalPage = totalCount/limit;
        }else{
            totalPage = totalCount/limit +1;
        }
        if(page<=1){
            page = 1;
        }
        if(page>=totalPage){
            page=totalPage;
        }
        pageBean.setPage(page);
        int size= 10;
        pageBean.setSize(size);
        int endIndex = page;
        int startIndex = page;
        //对初始页和结束页做操作
        while(true){
            if(endIndex<totalPage){
                endIndex++;
            }
            if(endIndex-startIndex==size-1){
                break;
            }
            if (startIndex>1){
                startIndex--;
            }
            if(endIndex>=totalPage&&startIndex<=1){
                break;
            }
        }
        pageBean.setStartIndex(startIndex);
        pageBean.setEndIndex(endIndex);
        pageBean.setTotalPage(totalPage);
        pageBean.setList(productDao.getAllProduct(limit, (page - 1) * limit,name));

        return pageBean;
    }

    //根据id获得商品
    public Product getProduct(int id){
        return productDao.getProduct(id);
    }

    //根据name获得商品
    public Product getProduct(String name){
        return productDao.getProduct(name);
    }

    //保存商品
    public void update(Product product){
        productDao.update(product);
    }

    //新增商品
    public void save(Product product){
        productDao.save(product);
    }

    public void setProductDao(ProductDao productDao) {
        this.productDao = productDao;
    }
}
