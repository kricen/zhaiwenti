import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;
import com.wenti.service.ProductService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * Created by lixiao on 16/8/28.
 */
public class FileTest {
//    @Test
//    public void testOss(File file,String imageName) throws Exception{
//        // endpoint以杭州为例，其它region请按实际情况填写
//        String endpoint = "http://oss-cn-shanghai.aliyuncs.com";
//// accessKey请登录https://ak-console.aliyun.com/#/查看
//        String accessKeyId = "yPO2Qcqyn5srDmsU";
//        String accessKeySecret = "FkGGBdFuMYlOZ9u3LYpMcEvGVQivv6";
//
//// 创建OSSClient实例
//        OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
//        String content = "Hello OSS";
//
//// 上传文件
//        ObjectMetadata meta = new ObjectMetadata();
//        meta.setContentType("image/jpeg");
//        InputStream inputStream = new FileInputStream(file);
//        PutObjectResult result =   ossClient.putObject("zhaiwenti", imageName, inputStream,meta);
//        System.out.println(result.getETag());
////// 关闭client
//        ossClient.shutdown();
//    }
    @Test
    public void test1(){
        String testStr = "sjdfosjd.sj.jpg";
        int index = testStr.lastIndexOf(".");
        System.out.println(index);
        System.out.println(testStr.substring(index,testStr.length()));
    }
    @Test
    public void test2(){
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        ProductService productService = (ProductService)context.getBean("productService");
        System.out.println(productService.getHotProduct(1));

    }
}
