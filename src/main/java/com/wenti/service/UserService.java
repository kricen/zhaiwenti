package com.wenti.service;

import com.wenti.dao.UserDao;
import com.wenti.domain.School;
import com.wenti.domain.User;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2016/3/16 0016.
 */
@Transactional
public class UserService {
    private UserDao userDao;


    //获得学校
    public School getSchoolById(int id){
        return userDao.getSchoolById(id);
    }

    //获得学校
    public List<School> getAllSchool(){
        return userDao.getAllSchool();
    }

    //根据tel得到用户
    public User getUser(String tel){
        return userDao.getUser(tel);
    }

    //根据id得到用户
    public User getUser(int userId){
        return userDao.getUser(userId);
    }

    //根据openid获得用户
    public User getUserByOpenId(String openid){
        return userDao.getUserByOpenId(openid);
    }

    //保存用户
    public void save(User user){
        userDao.save(user);
    }

    //更新用户
    public void update(User user){userDao.update(user);}
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
}
