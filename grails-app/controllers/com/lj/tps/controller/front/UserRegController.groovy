package com.lj.tps.controller.front

import com.lj.csp.data.MemberAuthority
import com.lj.csp.data.Roles
import com.lj.csp.data.RolesAuthority
import com.lj.tps.data.TpsUser
import com.lj.utils.I18nError

class UserRegController {

    def index() {redirect(action: "register")}

    //用户注册
    def register(){
        def success = null;
        def errors = null;

        if(params.isEdit=="true" && params.username){
            def userTemp=TpsUser.findByUsername(params.username);
            if(userTemp){
                params.IDNumber=userTemp.getIDNumber()
                params.mobileNumber=userTemp.getMobileNumber()
                params.unitName=userTemp.getUnitName()
                params.realName=userTemp.getRealName()
                render(view: "/front/user/register",params:params)
                return;
            }
        }

        if(params.isUpdate=="true"){
            def userTemp=TpsUser.findByUsername(params.username);
            if(!userTemp){
                render(view: "/front/user/register");
                return;
            }
            if(userTemp && userTemp.getEnabled()){
                errors ="用户名已经被注册了，请修改用户名后重试";
                render(view: "/front/user/register", model: [success: success, errors: errors],params:params);
                return;
            }

            userTemp.properties=params
            userTemp.remark=""
            def roles=Roles.findByName('普通用户');
            userTemp.addToRoles(roles);
            if (!userTemp.save(flush: true)) {
                errors = I18nError.getMessage(g, userTemp.errors.allErrors).replaceAll("\n","<br/>");
                render(view: "/front/user/register", model: [success: success, errors: errors]);
            }else{
                flash.success = message(code: 'default.updated.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), userTemp.id])
                redirect(controller: "login",action: "auth");//转到登录页面进行登录
            }
        }

        if (request.method == "POST") {
            if(params.rePassword!=params.password){
                errors ="两次输入的密码不一致";
                render(view: "/front/user/register", model: [success: success, errors: errors]);
                return;
            }
            def userTemp=TpsUser.findByUsername(params.username);
            if(userTemp){
                errors ="用户名已经被注册了，请修改用户名后重试";
                render(view: "/front/user/register", model: [success: success, errors: errors]);
                return;
            }


            def tpsUserInstance = new TpsUser(params);
            //设置权限
            def roles=Roles.findByName('普通用户');
            tpsUserInstance.addToRoles(roles);
            //设置为无效
            tpsUserInstance.enabled=false;
            if (!tpsUserInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, tpsUserInstance.errors.allErrors).replaceAll("\n","<br/>");
            }else{
                //设置权限
                tpsUserInstance.roles.each{role->
                    def raes=RolesAuthority.findAllByRoles(role)
                    if(raes){
                        raes.each{ra->
                            MemberAuthority.create(tpsUserInstance,ra.authority,true);
                        }
                    }
                }
                flash.success = message(code: 'default.updated.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), tpsUserInstance.id])
                redirect(controller: "login",action: "auth");//转到登录页面进行登录
                return;
            }
        }
        render(view: "/front/user/register", model: [success: success, errors: errors]);
    }
    def userExist(){
        def userTemp=TpsUser.findByUsername(params.username);
        if((userTemp&& params.isEdit=="true" && userTemp.enabled) || (!params.isEdit &&userTemp)){
            render(text: "true",contentType: "text/html");
        }else{
            render(text: "",contentType: "text/html");
        }
    }
}
