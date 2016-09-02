package com.wenti.dao;

import java.io.Serializable;

/**
 * Created by lixiao on 16/4/30.
 */
public class ProductHotBean implements Serializable{
    private Integer id;
    private String name;
    private float price;
    private String image;
    private int hot;
    public ProductHotBean() {
    }

    public ProductHotBean(String name, float price, String image,int id) {
        this.name = name;
        this.price = price;
        this.image = image;
        this.id = id;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
