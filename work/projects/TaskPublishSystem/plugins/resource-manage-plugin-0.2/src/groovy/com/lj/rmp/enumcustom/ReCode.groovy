package com.lj.rmp.enumcustom

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-8-3
 * Time: 上午11:25
 * To change this template use File | Settings | File Templates.
 */
public class ReCode {
    public final static def NO_RESULT=[code:1,label:"没有记录"];
    public final static def NO_ENOUGH_PARAMS=[code:2,label:"没有足够的参数"];
    public final static def HAVE_ERRORS=[code:3,label:"有错误存在"];
    public final static def OK=[code:0,label:"成功"];
    public final static def NOT_LOGIN=[code:-1,label:"您没有登录"];
    public final static def SAVE_FAILED=[code:-2,label:"保存数据失败"];
    public final static def OTHER_ERROR=[code:-3,label:"未知错误"];
    public final static def USERNAME_NOT_EXIST=[code:-4,label:"用户名不存在"];
    public final static def PASSWORD_INCORRECT=[code:-5,label:"密码错误"];
    public final static def DENIED_USER=[code:-6,label:"非法用户"];
    public final static def SAVE_FILE_FAILED=[code:-7,label:"保存文件失败"];
    public final static def SUBMIT_FORMAT_ERROR=[code:-8,label:"提交数据格式错误"];
    public final static def NOT_A_IMAGE=[code:-9,label:"上传的不是图片"];
    public final static def SYSTEM_ERROR=[code:-10,label:"系统错误"];
    public final static def SYSTEM_EXCEPTION = [code:-11, label:"系统异常"];
    public final static def PASSWORD_DIFFERENCE=[code:-12,label:"两次输入的密码不一致！"];
    public final static def FILE_IS_TOO_BIG=[code:-13,label:"上传文件大小超过限制"];
    public final static def FILE_EXT_NOT_ALLOW=[code:-14,label:"上传文件扩展名是不允许的扩展名"];
    public final static def UPLOAD_FILE_FAILED=[code:-15,label:"上传文件失败"];
}