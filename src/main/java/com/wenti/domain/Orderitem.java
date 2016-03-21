package com.wenti.domain;

/**
 * Created by Administrator on 2016/3/15 0015.
 */
public class Orderitem {
    private Integer id;
    private Integer pid;
    private Integer oid;
    private Integer num;
    private Order order;
    private Product product;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
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

        Orderitem orderitem = (Orderitem) o;

        if (id != null ? !id.equals(orderitem.id) : orderitem.id != null) return false;
        if (pid != null ? !pid.equals(orderitem.pid) : orderitem.pid != null) return false;
        if (oid != null ? !oid.equals(orderitem.oid) : orderitem.oid != null) return false;
        if (num != null ? !num.equals(orderitem.num) : orderitem.num != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (pid != null ? pid.hashCode() : 0);
        result = 31 * result + (oid != null ? oid.hashCode() : 0);
        result = 31 * result + (num != null ? num.hashCode() : 0);
        return result;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
