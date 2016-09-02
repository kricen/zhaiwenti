package com.wenti.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by lixiao on 16/8/28.
 */
public class Image implements Serializable {
    private Integer id;
    private String image;
    private Set<Product> products = new HashSet<Product>(0);
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Set<Product> getProducts() {
        return products;
    }

    public void setProducts(Set<Product> products) {
        this.products = products;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
