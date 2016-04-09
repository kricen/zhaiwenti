package com.wenti.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.wenti.domain.Category;
import com.wenti.domain.Product;
import com.wenti.domain.Seller;
import com.wenti.service.CategoryService;
import com.wenti.service.ProductService;
import com.wenti.utils.CommonUtils;
import com.wenti.utils.CompressImg;
import com.wenti.utils.PageBean;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.*;
import org.springframework.context.annotation.Scope;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by Administrator on 2016/3/19 0019.
 */
@Scope("prototype")
@ParentPackage("seller-default")
@Namespace(value="/seller")
@Results({
        @Result(name="sellerJsonLogin",type="json"),
        @Result(name="sellerActionLogin",location="login",type="redirectAction"),
        @Result(name = "notFound",location="pendingOrderPage",type="redirectAction" ),
        @Result(name = "loginPage",location="login",type="redirectAction" )
})
@ExceptionMappings({
        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
})
public class SellerRCAction extends ActionSupport{
    private File image;
    private String imageFileName;
    private String imageContentType;
    private int id;
    private int page;
    private String name;
    private float price;
    private int categoryId;
    private int score;
    private ProductService productService;
    private CategoryService categoryService;


    //商品状态的改变,商品下架操作
    @Action(
            value = "productOperation",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String productOperation(){
        String  result = productService.productOperation(id);
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        writer.write(result);
        CommonUtils.closePrintWriter(writer);
        return SUCCESS;
    }
    //库存管理 包含新增商品和更改商品
    @Action(
            value = "addUpdateProduct",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String addUpdateProduct(){
        Seller seller = (Seller)ServletActionContext.getRequest().getSession().getAttribute("seller");
        String handleResult = uploadHandle();

        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        if(handleResult != ERROR){
            //如果id为0 ，那么此操作为增加操作
            //否则获取商品编号为id的商品，对此商品进行信息更改操作
            if(id == 0){
                Product saveProduct = productService.getProduct(name);
                if(saveProduct==null) {
                    saveProduct = new Product();
                    saveProduct.setName(name);
                    saveProduct.setComments(null);
                    saveProduct.setImage(handleResult);
                    saveProduct.setState(0);
                    saveProduct.setSellNum(0);
                    saveProduct.setHot(0);
                    saveProduct.setSeller(seller);
                    Category category = categoryService.getCategory(categoryId);
                    saveProduct.setCategory(category);
                    saveProduct.setPrice(price);
                    productService.save(saveProduct);
                    writer.write("success");
                }else {
                    writer.write("success");
                }
            }else {
                Product updateProduct = productService.getProduct(id);
                if (updateProduct!=null){
                    if(name!=null){
                        Product product = productService.getProduct(name);
                        if(product==null){
                            updateProduct.setName(name);
                        }
                    }
                    if(price!=0.0){
                        updateProduct.setPrice(price);
                    }
                    if (categoryId!=0){
                        Category category = categoryService.getCategory(categoryId);
                        updateProduct.setCategory(category);
                    }
                    updateProduct.setImage(handleResult);
                    productService.update(updateProduct);
                }

                writer.write("success");
            }

        }else {
            writer.write(handleResult);
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //库存管理页面
    @Action(
            value = "repertoryPage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/repertory.jsp")
            }
    )
    public String repertoryPage(){
        List<Category> categoryList = categoryService.getCategories();
        ServletActionContext.getContext().getValueStack().set("categories",categoryList);
        PageBean<Product> pageBean = productService.getPBeanProduct(page,name);
        ServletActionContext.getContext().getValueStack().set("pageBean",pageBean);
        return SUCCESS;
    }

    //类别管理页面
    @Action(
            value = "categoryPage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/categories.jsp")
            }
    )
    public String categoryPage(){
        List<Category> categoryList = categoryService.getCategories();
        ServletActionContext.getContext().getValueStack().set("categories",categoryList);
        return SUCCESS;
    }

    //类别操作页面 更改类别的状态属性
    @Action(
            value = "categoryOperation",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String categoryOperation(){
        String handleResult = categoryService.categoryOperation(id);
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        writer.write(handleResult);
        CommonUtils.closePrintWriter(writer);
        return SUCCESS;
    }

    //类别管理
    @Action(
            value = "addUpdateCategory",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String addUpdateCategory(){
        //如果id=0 那么就是增加操作，如果id！=0 就是update操作
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        System.out.println(name);
        if(id==0){
            Category category =  categoryService.getCategory(name);
            if(category==null){
                category = new Category();
                category.setName(name);
                category.setState(0);
                category.setScore(score);
                categoryService.save(category);
                writer.write("success");
            }else {
                writer.write("repeat");
            }
        }else {
            //更新操作
            Category category = categoryService.getCategory(id);
            if(category==null){
                writer.write(ERROR);
            }else {
                Category tmepCategory = categoryService.getCategory(name);
                if(tmepCategory==null){
                    if(name!=null){
                        category.setName(name);
                        categoryService.update(category);
                        writer.write(SUCCESS);
                    }
                }else {
                    writer.write("repeat");
                }
            }
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //private function
    public String uploadHandle(){
        String filename = "";
        if(image!=null){
            String[] str = { "jpg", "jpeg", "bmp", "png" };
            if (image == null || image.length() > 4194304) {
                //文件过大
                return ERROR;
            }
            boolean imageFormat = false;
            for (String s : str) {
                if (imageFileName.endsWith(s)){
                    imageFormat = true;
                    break;
                }
            }
            if(!imageFormat){
                return ERROR;
            }
            filename = uploadBookImage(image,imageFileName, 50,50);
            //表示上传图片出错
            if(filename.equals(ERROR)){
                return ERROR;
            }

           /* findBook.setImage(smallImageName);*/
        }

        return filename;
    }

    //需要封装一个接收图片的方法
    private String uploadBookImage(File uploadFile,String uploadFileName,int width,int hight){
        String filename=null;
        String[] split = uploadFileName.split("\\.");
        String reg = split[1];
        filename= CommonUtils.UUID16()+"."+reg;
        String path = ServletActionContext.getServletContext().getRealPath("/productImage");
        String temFilename = filename;
        filename= "/productImage/"+filename;
        File file = new File(path);
        if(!file.exists()){
            file.mkdirs();
        }
        File destFile = new File(path, temFilename);
        try {
            FileUtils.copyFile(uploadFile, destFile);
            CompressImg mypic = new CompressImg();
            mypic.compressPic(destFile, path, temFilename, width, hight, true);
        } catch (IOException e) {
            e.printStackTrace();
            return ERROR;
        }
        return filename;
    }

    //properties


    public void setPage(int page) {
        this.page = page;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setImage(File image) {
        this.image = image;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    public void setImageContentType(String imageContentType) {
        this.imageContentType = imageContentType;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }
}
