package com.wenti.dto;

import com.wenti.domain.Orderitem;
import com.wenti.domain.Seller;
import com.wenti.domain.User;

import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Created by lixiao on 16/5/5.
 */
public class OrderBaseBean {
    private Integer id;
    private String ordertime;
    private Date successDate;
    private float totalFee;
    private Integer state;
    private User user;
    private String remark;
    private String tel;
    private String name;
    private String addr;
    private String deliveryTime;
    private int num;
    private int visible;
    private Set<Orderitem> items;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(String ordertime) {
        this.ordertime = ordertime;
    }

    public Date getSuccessDate() {
        return successDate;
    }

    public void setSuccessDate(Date successDate) {
        this.successDate = successDate;
    }

    public float getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(float totalFee) {
        this.totalFee = totalFee;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getVisible() {
        return visible;
    }

    public void setVisible(int visible) {
        this.visible = visible;
    }

    public Set<Orderitem> getItems() {
        return items;
    }

    public void setItems(Set<Orderitem> items) {
        this.items = items;
    }
}
