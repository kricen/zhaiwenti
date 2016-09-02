package com.wenti.web.dwr;

import com.wenti.domain.Seller;
import com.wenti.service.SellerService;

/**
 * Created by lixiao on 16/8/30.
 */
public class KeepLive {
    private SellerService sellerService;

    public void findSeller(){
        Seller seller = sellerService.getSellerByTelPwd("13122210065","nihaoa");
    }


    public void setSellerService(SellerService sellerService) {
        this.sellerService = sellerService;
    }
}
