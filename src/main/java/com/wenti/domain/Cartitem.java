package com.wenti.domain;

import java.io.Serializable;

/**
 * Created by Administrator on 2016/3/15 0015.
 */
public class Cartitem implements Serializable {
    private Integer id;
    private Integer num;
    private Product product;
    private Integer user;
    private float fee;
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }


    public Integer getUser() {
        return user;
    }

    public void setUser(Integer user) {
        this.user = user;
    }

    public float getFee() {
        return fee;
    }

    public void setFee(float fee) {
        this.fee = fee;
    }


    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

}
