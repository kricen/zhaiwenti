package com.wenti.service;

import com.wenti.dao.SellerDao;
import com.wenti.domain.Seller;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class SellerService {
    private SellerDao sellerDao;

    //通过账号名密码获得商家
    public Seller getSellerByTelPwd(String tel,String password){
        return sellerDao.getSellerByTelPwd(tel,password);
    }

    public void setSellerDao(SellerDao sellerDao) {
        this.sellerDao = sellerDao;
    }
}
