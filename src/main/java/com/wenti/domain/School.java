package com.wenti.domain;

import java.io.Serializable;

/**
 * Created by lixiao on 16/8/29.
 */
public class School implements Serializable{
    private int id;
    private String name;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
