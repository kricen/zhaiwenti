package com.wenti.service;

import com.wenti.dao.SellerDao;
import com.wenti.domain.Seller;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
@Transactional
public class SellerService {
    private SellerDao sellerDao;

    //通过账号名密码获得商家
    public Seller getSellerByTelPwd(String tel,String password){
        return sellerDao.getSellerByTelPwd(tel,password);
    }
    public Seller getSeller(int id){
        return sellerDao.getSeller(id);
    }

    public void setSellerDao(SellerDao sellerDao) {
        this.sellerDao = sellerDao;
    }
}
