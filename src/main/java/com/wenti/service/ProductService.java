package com.wenti.service;

import com.wenti.dao.ProductDao;
import com.wenti.domain.Product;
import com.wenti.utils.PageBean;
import com.wenti.web.action.ProductBean;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class ProductService {
    private ProductDao productDao;

    //构建productBean用于首页的显示
    public List<ProductBean> getProductBeanList(){
        List<Product> products = productDao.getProducts();
        List<ProductBean> productBeanList = new ArrayList<ProductBean>();
        for(int i=0;i<products.size();i++){
            ProductBean findProductBean = isExistProductBean(products.get(i).getCategory().getId(),productBeanList);
            if(findProductBean==null){
                findProductBean = new ProductBean();
                findProductBean.setCategoryId(products.get(i).getCategory().getId());
                findProductBean.setCategoryName(products.get(i).getCategory().getName());
                findProductBean.setId(products.get(i).getId());
                findProductBean.setName(products.get(i).getName());
                findProductBean.setPrice(products.get(i).getPrice());
                //明天接着写，出现的问题，现在的写法还不能按类别分组
            }
        }
        return productBeanList;
    }
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

    //private functions
    public ProductBean isExistProductBean(int id,List<ProductBean> productBeanList){
        ProductBean productBean = null;
        for(int i=0;i<productBeanList.size();i++){
            if(productBeanList.get(i).getCategoryId()==id){
                productBean = productBeanList.get(i);
                break;
            }
        }
        return productBean;
    }
}
