package com.wenti.utils;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;
import com.wenti.domain.Image;
import org.junit.Test;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * Created by lixiao on 16/8/28.
 */
public class FileUploadUtil {
    public static Image ossUpload(File file,String uploadFileName) {
        try {

            // endpoint以杭州为例，其它region请按实际情况填写
            String endpoint = "http://oss-cn-shanghai.aliyuncs.com";
            // accessKey请登录https://ak-console.aliyun.com/#/查看
            String accessKeyId = "yPO2Qcqyn5srDmsU";
            String accessKeySecret = "FkGGBdFuMYlOZ9u3LYpMcEvGVQivv6";

            // 创建OSSClient实例
            OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
            String content = "Hello OSS";
            int index = uploadFileName.lastIndexOf(".");
            String reg = uploadFileName.substring(index,uploadFileName.length());
            String filename= CommonUtils.UUID16()+reg;
            Image image = new Image();
            image.setImage("http://zhaiwenti.oss-cn-shanghai.aliyuncs.com/"+filename);
            // 上传文件
               ObjectMetadata meta = new ObjectMetadata();
            meta.setContentType("image/jpeg");
            InputStream inputStream = new FileInputStream(file);
            PutObjectResult result = ossClient.putObject("zhaiwenti", filename, inputStream, meta);
            //// 关闭client
            ossClient.shutdown();
            return image;

            } catch (Exception e) {
                return null;
            }
    }
}
