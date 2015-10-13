package com.lj.rmp.utils

import java.text.SimpleDateFormat

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-7
 * Time: 下午11:03
 * To change this template use File | Settings | File Templates.
 */
class TypeConversion {
    // 任意类型转整形
    public static Integer toInteger(def n) {
        if (n) {
            String x = "${n}".trim()
            return x.isInteger() ? x.toInteger() : 0
        } else
            return 0
    }

    // 任意类型转长整形
    public static Long toLong(def n) {
        if (n) {
            String x = "${n}".trim()
            return x.isLong() ? x.toLong() : 0
        } else
            return 0
    }
    //任意类型转换为double
    public static Double toDouble(def n) {
        if (n) {
            String x = "${n}".trim()
            return x.isDouble() ? x.toDouble() : 0
        } else
            return 0
    }
    //转换为布尔型
    public static boolean toBoolean(def bool){
        if(bool==false){
            return false;
        }else if(bool==true){
            return true;
        }
        else if(bool=="true"){
            return true;
        }
        else if(bool=="false"){
            return false;
        }
        else if(bool==0){
            return false;
        }
        else if(bool==1){
            return true;
        }
        else {
            throw new Exception("格式不正确");
        }
    }
    //转为时间
    public static Date toDate(String timeStr,String formatStr){
        SimpleDateFormat sdf=new SimpleDateFormat(formatStr);
        Date date=null;
        try {
            date=sdf.parse(timeStr);
        }catch (Exception ex){

        }
        return date;
    }
    public static Date toDate(String dateStr){
        Date date=toDate(dateStr,"yyyy-MM-dd");
        return date;
    }
    public static Date toTime(String timeStr){
        Date date=toDate(timeStr,"HH:mm:ss");
        return date;
    }
    public static Date toDateTime(String dateStr){
        Date date=toDate(dateStr,"yyyy-MM-dd HH:mm:ss");
        return date;
    }
}
