package com.wenti.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2016/3/15 0015.
 */
public class Product implements Serializable {
    private Integer id;
    private String name;
    private float price;
    private String comments;
    private Image headImage;
    private String detailImage;
    private String lunboImage;
    private int state;
    private Set<Cartitem> cartitems = new HashSet<Cartitem>(0);
    private Set<Orderitem> orderitems = new HashSet<Orderitem>(0);
    private Seller seller;
    private Category category;
    private int sellNum;
    //用户统计购物车中当前商品的数量，不牵扯数据库表
    private int num;
    private int hot;
    private List<Image> detailImages;
    private List<Image> lunboImages;
    public Integer getId() {
        return id;
    }


    public void setId(Integer id) {
        this.id = id;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }


    public int getSellNum() {
        return sellNum;
    }

    public void setSellNum(int sellNum) {
        this.sellNum = sellNum;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public List<Image> getDetailImages() {
        return detailImages;
    }

    public void setDetailImages(List<Image> detailImages) {
        this.detailImages = detailImages;
    }

    public List<Image> getLunboImages() {
        return lunboImages;
    }

    public void setLunboImages(List<Image> lunboImages) {
        this.lunboImages = lunboImages;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Product product = (Product) o;
        if (id != null ? !id.equals(product.id) : product.id != null) return false;
        if (name != null ? !name.equals(product.name) : product.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }

    public Image getHeadImage() {
        return headImage;
    }

    public void setHeadImage(Image headImage) {
        this.headImage = headImage;
    }

    public String getDetailImage() {
        return detailImage;
    }

    public void setDetailImage(String detailImage) {
        this.detailImage = detailImage;
    }

    public String getLunboImage() {
        return lunboImage;
    }

    public void setLunboImage(String lunboImage) {
        this.lunboImage = lunboImage;
    }

    public Set<Cartitem> getCartitems() {
        return cartitems;
    }

    public void setCartitems(Set<Cartitem> cartitems) {
        this.cartitems = cartitems;
    }

    public Set<Orderitem> getOrderitems() {
        return orderitems;
    }

    public void setOrderitems(Set<Orderitem> orderitems) {
        this.orderitems = orderitems;
    }

    public Seller getSeller() {
        return seller;
    }

    public void setSeller(Seller seller) {
        this.seller = seller;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
