package com.wenti.domain;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2016/3/21 0021.
 */
public class ProductBean implements Serializable {
    private String categoryName;
    private int categoryId;
    private int num;
    private List<Product> list;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public List<Product> getList() {
        return list;
    }

    public void setList(List<Product> list) {
        this.list = list;
    }
}
