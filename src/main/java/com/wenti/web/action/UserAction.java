package com.wenti.web.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.wenti.dao.ProductHotBean;
import com.wenti.domain.*;
import com.wenti.service.CategoryService;
import com.wenti.service.ProductService;
import com.wenti.service.UserService;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import java.util.List;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
@Scope("prototype")
@ParentPackage("user-default")
@Namespace(value="/user")
@Results({
        @Result(name="userJsonLogin",type="json"),
        @Result(name="userActionLogin",location="huanchong",type="redirectAction"),
        @Result(name = "notFound",location="huanchong",type="redirectAction" )

})
@ExceptionMappings({
//        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
})
public class UserAction extends ActionSupport implements ModelDriven<User>{
    private User user = new User();
    private int page;
    public User getModel() {
        return user;
    }
    private UserService userService;
    private ProductService productService;
    private CategoryService categoryService;


    //待处理订单
    @Action(
            value = "login",
            results = {
                    @Result(name = SUCCESS,location = "index",type = "redirectAction")
            }
    )
    public String login(){
        User user = userService.getUser(1);
        ServletActionContext.getRequest().getSession().setAttribute("user",user);
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "selectSchool",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/selectSchool.jsp")
            }
    )
    public String selectSchool(){
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        List<School> schools = userService.getAllSchool();
        ActionContext.getContext().getValueStack().set("schools",schools);
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "confirmSchool",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "index",type = "redirectAction")
            }
    )
    public String confirmSchool(){
        User findUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        int schoolId = user.getId();
        user =userService.getUser(findUser.getId());
        user.setSchool(schoolId);
        userService.update(user);
        return SUCCESS;
    }




    //待处理订单
    @Action(
            value = "index",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/index.jsp")
            }
    )
    public String index(){
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        user = userService.getUser(user.getId());
        School school = userService.getSchoolById(user.getSchool());
        List<Product> hotProducts = productService.getHotProduct();
        ActionContext.getContext().getValueStack().set("school",school);
        ActionContext.getContext().getValueStack().set("products",hotProducts);
        return SUCCESS;
    }


    //待处理订单
    @Action(
            value = "categoryList",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/list.jsp")
            }
    )
    public String categoryList(){
        User findUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        List<Product> products = productService.getCategoryProduct(user.getId(),page);
        ActionContext.getContext().getValueStack().set("products",products);
        return SUCCESS;
    }

    //待处理订单
    @Action(
            value = "productDetail",
            interceptorRefs = {
                    @InterceptorRef(value = "weixinLogin")
            },
            results = {
                    @Result(name = SUCCESS,location = "/newUserPages/productDetail.jsp")
            }
    )
    public String productDetail(){
        User findUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        Product product = productService.getProduct(user.getId());
        List<Image> lunboImages = productService.getImages(product.getLunboImage());
        List<Image> detailImages = productService.getImages(product.getDetailImage());
        ActionContext.getContext().getValueStack().set("product",product);
        ActionContext.getContext().getValueStack().set("lunboImages",lunboImages);
        ActionContext.getContext().getValueStack().set("detailImages",detailImages);
        return SUCCESS;
    }







    public void setPage(int page) {
        this.page = page;
    }


    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }
}
