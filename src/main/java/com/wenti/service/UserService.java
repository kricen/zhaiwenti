package com.wenti.service;

import com.wenti.dao.UserDao;
import com.wenti.domain.User;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
public class UserService {
    private UserDao userDao;

    //根据tel得到用户
    public User getUser(String tel){
        return userDao.getUser(tel);
    }

    //保存用户
    public void save(User user){
        userDao.save(user);
    }
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
}
