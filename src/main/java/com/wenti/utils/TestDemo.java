package com.wenti.utils;

import com.wenti.domain.Cart;
import com.wenti.domain.User;
import com.wenti.service.CartService;
import com.wenti.service.UserService;
import com.wenti.web.action.UserCartAction;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by lixiao on 16/4/5.
 */
public class TestDemo {

    @Test
    public void testLazy(){
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        CartService cartService = (CartService)context.getBean("cartService");
        Cart cart = cartService.getCartByUser(1);
        System.out.println(cart.getUser().getName());

    }

    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserCartAction userCartAction = (UserCartAction)context.getBean("userCartAction");

    }

    @Test
    public void testSynoc1(){
        for(int i=0;i<2;i++){
            Thread thread = new Thread(new Runnable() {
                public void run() {
                    System.out.println("sjdfsf");
                    ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
                    UserService userService = (UserService)context.getBean("userService");
                    try {
                        Thread.sleep(1000);
                        User user = userService.getUser(1);
                        user.setName("123"+user.getName());
                        user.setAddr("123"+user.getName());
                        userService.update(user);
                        System.out.println(user.getName());
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            });
            thread.start();
        }

    }
}
