package com.wenti.utils;

import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * Created by Administrator on 2016/3/17 0017.
 */
public class CommonUtils {

    public static String getOrderNo(int orderId) {
        String str = new SimpleDateFormat("yyMMddHHmmss").format(new Date());
        long orderNo = Long.parseLong((str)) * 10000;
        orderNo += orderId;
        return orderNo+"";
    }
    /**
     * uuid 获得唯一id
     */
    public static String UUID16(){

        return UUID.randomUUID().toString().replaceAll("-","");
    }

    /**
     * 模糊查询算法
     */
    public static String getSortString(String s) {
        String replaceAll = s.replaceAll("%", "/%").replaceAll("\\+","\\\\+");
        String bf = new String("");
        for (int i = 0; i < replaceAll.length(); i++) {
            if (replaceAll.charAt(i) == '/') {
                if (i == 0) {
                    bf = "%" + replaceAll.charAt(i);
                } else {
                    bf += replaceAll.charAt(i);
                }
            } else {
                if (i == 0) {
                    bf = "%" + replaceAll.charAt(i) + "%";
                } else {
                    bf += replaceAll.charAt(i) + "%";
                }
            }
        }
        return bf;
    }

    /**
     * 获得json PrintWriter
     */
    public static PrintWriter getJsonPrintWriter(HttpServletResponse response){
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/json; charset=utf-8");
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return writer;
    }
    /**
     * 获得html PrintWriter
     */
    public static PrintWriter getHtmlPrintWriter(HttpServletResponse response){
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter writer= null;
        try {
            writer = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return writer;
    }

    public static void closePrintWriter(PrintWriter printWriter){
        if(printWriter!=null){
            printWriter.flush();
            printWriter.close();
        }
    }
    public static synchronized String getOrderNo() {
        String str = new SimpleDateFormat("yyMMddHHmmss").format(new Date());
        return str;
    }
    /**
     * 获得当前时间
     * @return
     */
    public static String getDate(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = simpleDateFormat.format(date);
        return time;
    }
    /**
     * 获得当前时间
     * @return
     */
    public static String getDate(Date date){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String time = simpleDateFormat.format(date);
        return time;
    }

    /**
     * 获得当前时间
     * @return
     */
    public static String getDate1(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String time = simpleDateFormat.format(date);
        return time;
    }
    /**
     * 获得当前时间
     * @return
     */
    public static String getDateYMDHM(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM-dd HH：mm");
        String time = simpleDateFormat.format(date);
        return time;
    }
    /**
     * 获得当前时间
     * @return
     */
    public static String getDateYM(){
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年M月");
        String time = simpleDateFormat.format(date);
        return time;
    }
    /**
     * 获得当前时间
     * @return
     */
    public static Date getNowTime(){
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String dd =format.format(date);
        try {
            date = format.parse(dd);
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return date;
    }

}
