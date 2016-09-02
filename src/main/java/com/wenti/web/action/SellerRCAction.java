package com.wenti.web.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.wenti.domain.*;
import com.wenti.service.CategoryService;
import com.wenti.service.ProductService;
import com.wenti.utils.*;
import com.wenti.wenxin.CommonUtil;
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
//        @ExceptionMapping(result = "notFound",exception = "java.lang.Exception")
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
    private int index;
    private int score;
    private String comments;
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


    //商品状态的改变,商品下架操作
    @Action(
            value = "delImage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String delImage(){
        Product product = productService.getProduct(id);
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        if(product ==null){
            writer.write("error");
            writer.flush();
            writer.close();
            return SUCCESS;
        }
        //如果index==0,那么删除的是轮播图 如果index==1,删除的是商品详情图
        if(index==0){
            String lunboStr = product.getLunboImage();
            String[] lunbos = lunboStr.split(",");
            String lunboImage = "";
            for(int i=0;i<lunbos.length;i++){
                if(!(Integer.parseInt(lunbos[i])==page)){
                    if(lunboImage==""){
                        lunboImage = Integer.parseInt(lunbos[i])+"";
                    }else {
                        lunboImage += ","+Integer.parseInt(lunbos[i]);
                    }
                }
            }
            if(lunboImage!=""){
                product.setLunboImage(lunboImage);
                productService.update(product);
            }else {
                writer.write("error");
                writer.flush();
                writer.close();
                return SUCCESS;
            }
        }else {
            String lunboStr = product.getDetailImage();
            String[] lunbos = lunboStr.split(",");
            String lunboImage = "";
            for(int i=0;i<lunbos.length;i++){
                System.out.println(lunbos[i]);
                if(!(Integer.parseInt(lunbos[i])==page)){
                    if(lunboImage==""){
                        lunboImage = Integer.parseInt(lunbos[i])+"";
                    }else {
                        lunboImage += ","+Integer.parseInt(lunbos[i]);
                    }
                }
            }
            if(lunboImage!=""){
                product.setDetailImage(lunboImage);
                productService.update(product);
            }else {
                writer.write("error");
                writer.flush();
                writer.close();
                return SUCCESS;
            }
        }

        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }


    //商品状态的改变,商品下架操作
    @Action(
            value = "saveProduct",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String saveProduct(){
        Seller seller = (Seller)ServletActionContext.getRequest().getSession().getAttribute("seller");
        Product product = productService.getProduct(id);
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        if(product ==null){
            writer.write("error");
            writer.flush();
            writer.close();
            return SUCCESS;
        }
        product.setName(name);
        product.setPrice(price);
        product.setComments(comments);
        product.setCategory(categoryService.getCategory(categoryId));
        product.setSeller(seller);
        product.setState(0);
        productService.update(product);
        writer.write("success");
        writer.flush();
        writer.close();
        return SUCCESS;
    }


    //商品状态的改变,商品下架操作
    @Action(
            value = "productDetail",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerActionStack")
            },
            results = {
                    @Result(name = SUCCESS,location = "/sellerPages/productDetail.jsp")
            }
    )
    public String productDetail(){
        Seller seller = (Seller)ServletActionContext.getRequest().getSession().getAttribute("seller");
        Product product = null;
        if(id!=0){
            product = productService.getProduct(id);
            //待完成图片
            product.setLunboImages(productService.getImages(product.getLunboImage()));
            product.setDetailImages(productService.getImages(product.getDetailImage()));
        }else{
            product = new Product();
            product.setHot(0);
            product.setSellNum(0);
            product.setSeller(seller);
            product.setState(-1);
            product.setLunboImage("");
            product.setDetailImage("");
            product.setComments("");
            product.setName("");
            product.setNum(0);
            product.setPrice(0.0f);
            productService.save(product);
        }
        List<Category> categories = categoryService.getCategories();
        ActionContext.getContext().getValueStack().set("id",product.getId());
        ActionContext.getContext().getValueStack().set("categories",categories);
        ActionContext.getContext().getValueStack().set("product",product);
        return SUCCESS;
    }

    //上传图片头像
    @Action(
            value = "uploadHeadImage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String uploadHeadImage(){
        Seller seller = (Seller)ServletActionContext.getRequest().getSession().getAttribute("seller");
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        Product product = productService.getProduct(id);
        if(product ==null){
            writer.write("error");
            writer.flush();
            writer.close();
            return SUCCESS;
        }
        Image headImage = FileUploadUtil.ossUpload(image,imageFileName);
        if(headImage==null) {
            headImage = uploadHandle1();
        }
        if(headImage !=null){
            productService.save(headImage);
            product.setHeadImage(headImage);
            product.setSeller(seller);
            productService.update(product);
            writer.write(headImage.getId()+"");
        }else {

            writer.write("error");
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //上传详情图片
    @Action(
            value = "uploadDetailImage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String uploadDetailImage(){
        Seller seller = (Seller)ServletActionContext.getRequest().getSession().getAttribute("seller");
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        Product product = productService.getProduct(id);
        if(product ==null){
            writer.write("error");
            writer.flush();
            writer.close();
            return SUCCESS;
        }
        String detailImages = product.getDetailImage();
        Image detailImage = FileUploadUtil.ossUpload(image,imageFileName);
        if(detailImage==null) {
            detailImage = uploadHandle1();
        }
        if(detailImage !=null){
            productService.save(detailImage);
            String imageStr = product.getDetailImage();
            if(imageStr.equals("")){
                imageStr = detailImage.getId()+"";
            }else {
                imageStr += ","+detailImage.getId();
            }
            product.setDetailImage(imageStr);
            product.setSeller(seller);
            productService.update(product);
            writer.write(detailImage.getId()+"");
        }else {
            writer.write("error");
        }
        writer.flush();
        writer.close();
        return SUCCESS;
    }

    //上传详情图片
    @Action(
            value = "uploadLunboImage",
            interceptorRefs = {
                    @InterceptorRef(value = "sellerJsonStack")
            },
            results = {
                    @Result(name = SUCCESS,type = "json")
            }
    )
    public String uploadLunboImage(){
        Seller seller = (Seller)ServletActionContext.getRequest().getSession().getAttribute("seller");
        PrintWriter writer = CommonUtils.getHtmlPrintWriter(ServletActionContext.getResponse());
        Product product = productService.getProduct(id);
        if(product ==null){
            writer.write("error");
            writer.flush();
            writer.close();
            return SUCCESS;
        }
        Image detailImage = FileUploadUtil.ossUpload(image,imageFileName);
        if(detailImage==null) {
            detailImage = uploadHandle1();
        }
        if(detailImage !=null){
            productService.save(detailImage);
            String imageStr = product.getLunboImage();
            if(imageStr.equals("")){
                imageStr = detailImage.getId()+"";
            }else {
                imageStr += ","+detailImage.getId();
            }
            product.setLunboImage(imageStr);
            product.setSeller(seller);
            productService.update(product);
            writer.write(detailImage.getId()+"");
        }else {
            writer.write("error");
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
                category.setOrderSales(0);
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
            filename = uploadBookImage(image,imageFileName, 100,100);
            //表示上传图片出错
            if(filename.equals(ERROR)){
                return ERROR;
            }

           /* findBook.setImage(smallImageName);*/
        }

        return filename;
    }

    public Image uploadHandle1(){
        String filename = "";
        if(image!=null){
            String[] str = { "jpg", "jpeg", "bmp", "png" };
            boolean imageFormat = false;
            for (String s : str) {
                if (imageFileName.endsWith(s)){
                    imageFormat = true;
                    break;
                }
            }
            if(!imageFormat){
                return null;
            }
            filename = uploadBookImage(image,imageFileName, 100,100);
            //表示上传图片出错
            if(filename.equals(null)){
                return null;
            }

            Image image = new Image();
            image.setImage(filename);
            productService.save(image);
            return image;

        }

        return null;
    }

    //需要封装一个接收图片的方法
    private String uploadBookImage(File uploadFile,String uploadFileName,int width,int hight){
        String filename=null;
        String[] split = uploadFileName.split("\\.");
        String reg = split[1];
        filename= CommonUtils.UUID16()+"."+reg;
        String path = ServletActionContext.getServletContext().getRealPath("/testImage");
        String temFilename = filename;
        filename= "/testImage/"+filename;
        File file = new File(path);
        if(!file.exists()){
            file.mkdirs();
        }
        File destFile = new File(path, temFilename);
        System.out.println(destFile.getAbsolutePath());
        try {
            FileUtils.copyFile(uploadFile, destFile);
            NarrowImage narrowImage = new NarrowImage();
//            CompressImg mypic = new CompressImg();
            if(uploadFile.length()<100000){

            }else if(uploadFile.length()<200000&&uploadFile.length()>=100000){
                narrowImage.writeHighQuality(narrowImage.zoomImage(destFile.getPath()), path+"/"+temFilename,0.2f);
            }else if (uploadFile.length()<400000&&uploadFile.length()>=200000){
                narrowImage.writeHighQuality(narrowImage.zoomImage(destFile.getPath()), path+"/"+temFilename,0.3f);
            }else {
                narrowImage.writeHighQuality(narrowImage.zoomImage(destFile.getPath()), path+"/"+temFilename,0.5f);
            }

//            mypic.compressPic(destFile, path+"/", temFilename, width, hight, true);

        } catch (IOException e) {
            e.printStackTrace();
            return ERROR;
        }
        return filename;
    }

    //properties


    public void setComments(String comments) {
        this.comments = comments;
    }

    public void setIndex(int index) {
        this.index = index;
    }

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
