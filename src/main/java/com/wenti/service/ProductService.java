package com.wenti.service;

import com.wenti.dao.ProductDao;
import com.wenti.domain.Cartitem;
import com.wenti.domain.Product;
import com.wenti.utils.PageBean;
import com.wenti.domain.ProductBean;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
@Transactional
public class ProductService {
    private ProductDao productDao;

    //构建productBean用于首页的显示
    public List<ProductBean> getProductBeanList(List<Cartitem> cartitems){
        List<Product> products = productDao.getProducts();
        System.out.println(products.size());
        List<ProductBean> productBeanList = new ArrayList<ProductBean>();
        int tempNum=0;
        for(int i=0;i<products.size();i++){
            ProductBean findProductBean = isExistProductBean(products.get(i).getCategory().getId(),productBeanList);
            if(findProductBean==null){
                findProductBean = new ProductBean();
                findProductBean.setNum(0);
                findProductBean.setCategoryId(products.get(i).getCategory().getId());
                findProductBean.setCategoryName(products.get(i).getCategory().getName());
                Cartitem cartitem = null;
                products.get(i).setNum(0);
                if(cartitems!=null){
                    for(int k=0;k<cartitems.size();k++){
                        if(tempNum==cartitems.size()) break;
                        cartitem = cartitems.get(k);
                        Product findProduct = cartitem.getProduct();
                        System.out.println(findProduct.getId()+"  "+products.get(i).getId()+findProduct.getId().equals(products.get(i).getId()));
                        if(findProduct.getId().equals(products.get(i).getId())){
                            products.get(i).setNum(cartitem.getNum());
                            findProductBean.setNum(findProductBean.getNum()+1);
                            tempNum++;
                        }
                    }
                }
                List<Product> products1 = new ArrayList<Product>();
                products1.add(products.get(i));
                findProductBean.setList(products1);
                productBeanList.add(findProductBean);
            }else{
                Cartitem cartitem = null;
                products.get(i).setNum(0);
                if(cartitems!=null){
                    for(int k=0;k<cartitems.size();k++){
                        if(tempNum==cartitems.size()) break;
                        cartitem = cartitems.get(k);
                        Product findProduct = cartitem.getProduct();
                        if(findProduct.getId().equals(products.get(i).getId())){
                            products.get(i).setNum(cartitem.getNum());
                            tempNum++;
                            findProductBean.setNum(findProductBean.getNum()+1);
                        }
                    }
                }
                findProductBean.getList().add(products.get(i));
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
