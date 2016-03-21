package com.wenti.domain;

/**
 * Created by Administrator on 2016/3/15 0015.
 */
public class Cartitem {
    private Integer id;
    private Integer num;
    private Cart cart;
    private Product product;
    private Seller seller;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Cartitem cartitem = (Cartitem) o;

        if (id != null ? !id.equals(cartitem.id) : cartitem.id != null) return false;
        if (num != null ? !num.equals(cartitem.num) : cartitem.num != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (num != null ? num.hashCode() : 0);
        return result;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Seller getSeller() {
        return seller;
    }

    public void setSeller(Seller seller) {
        this.seller = seller;
    }
}
