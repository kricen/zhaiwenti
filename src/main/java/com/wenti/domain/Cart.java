package com.wenti.domain;

import java.util.Set;

/**
 * Created by Administrator on 2016/3/15 0015.
 */
public class Cart {
    private Integer id;
    private User user;
    private Set<Cartitem> cartitems;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }




    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Cart cart = (Cart) o;

        if (id != null ? !id.equals(cart.id) : cart.id != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        return result;
    }

    public Set<Cartitem> getCartitems() {
        return cartitems;
    }

    public void setCartitems(Set<Cartitem> cartitems) {
        this.cartitems = cartitems;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
