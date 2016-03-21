package com.wenti.domain;

import java.sql.Date;
import java.util.Set;

/**
 * Created by Administrator on 2016/3/15 0015.
 */
public class Order {
    private Integer id;
    private Date ordertime;
    private Date successDate;
    private Double totalFee;
    private Integer state;
    private Seller seller;
    private User user;
    private String remark;
    private String tel;
    private String name;
    private String addr;
    private Set<Orderitem> orderitems;

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(Date ordertime) {
        this.ordertime = ordertime;
    }

    public Date getSuccessDate() {
        return successDate;
    }

    public void setSuccessDate(Date successDate) {
        this.successDate = successDate;
    }

    public Double getTotalFee() {
        return totalFee;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTotalFee(Double totalFee) {
        this.totalFee = totalFee;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Order order = (Order) o;

        if (id != null ? !id.equals(order.id) : order.id != null) return false;
        if (ordertime != null ? !ordertime.equals(order.ordertime) : order.ordertime != null) return false;
        if (successDate != null ? !successDate.equals(order.successDate) : order.successDate != null) return false;
        if (totalFee != null ? !totalFee.equals(order.totalFee) : order.totalFee != null) return false;
        if (state != null ? !state.equals(order.state) : order.state != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (ordertime != null ? ordertime.hashCode() : 0);
        result = 31 * result + (successDate != null ? successDate.hashCode() : 0);
        result = 31 * result + (totalFee != null ? totalFee.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        return result;
    }

    public Seller getSeller() {
        return seller;
    }

    public void setSeller(Seller seller) {
        this.seller = seller;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Set<Orderitem> getOrderitems() {
        return orderitems;
    }

    public void setOrderitems(Set<Orderitem> orderitems) {
        this.orderitems = orderitems;
    }
}
