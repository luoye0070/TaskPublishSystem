package com.lj.tps.controller.front

import com.lj.csp.data.MemberAuthority
import com.lj.csp.data.Roles
import com.lj.csp.data.RolesAuthority
import com.lj.tps.data.TpsUser
import com.lj.utils.I18nError
import com.lj.utils.Number;

class UserController {
    def springSecurityService;
    //用户注册
    def register(){
        def success = null;
        def errors = null;
//        boolean isSaveOk = false;
        if (request.method == "POST") {
            //检查两次输入密码是否一致
            if(params.rePassword!=params.password){
                errors ="两次输入的密码不一致";
                render(view: "/front/user/register", model: [success: success, errors: errors]);
                return;
            }
            //检查用户名是否已经注册过
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
                redirect(controller: "user",action: "show");//转到登录页面进行登录
                return;
//                isSaveOk = true;
            }
        }
        render(view: "/front/user/register", model: [success: success, errors: errors]);
    }
    //用户信息修改
    def edit(){
        def success = null;
        def errors = null;
        def tpsUserInstance = null;
        if (params.id) {
            long id = com.lj.utils.Number.toLong(params.id);
            tpsUserInstance = TpsUser.get(id)
            if (!tpsUserInstance) {
                errors = "编号为${id}的${message(code: 'tpsUser.label', default: 'TpsUser')}不存在";
                render(view: "edit", model: [errors: errors]);
                return;
            }
        } else {
            tpsUserInstance = new TpsUser();
        }
        boolean isSaveOk = false;
        if (request.method == "POST") {

            tpsUserInstance.properties = params;
            if (!tpsUserInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, tpsUserInstance.errors.allErrors);
                render(view: "edit", model: [tpsUserInstance: tpsUserInstance, errors: errors])
                return
            }
            success = message(code: 'default.updated.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), tpsUserInstance.id])
            isSaveOk = true;
        }
        render(view: "edit", model: [isSaveOk: isSaveOk, tpsUserInstance: tpsUserInstance, success: success, errors: errors]);

    }
    //用户信息展示
    def show(){
        def success = null;
        def errors = null;
        long id=Number.toLong(params.id);
        if(!id){
            def member = springSecurityService.currentUser;
            id=member.id;
        }

        def tpsUserInstance = TpsUser.get(id);
        if (!tpsUserInstance) {
            errors = message(code: 'default.not.found.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), id])
        }

       render(view:"",model:[tpsUserInstance: tpsUserInstance,errors:errors]);
    }
    //密码修改
    def changePW(){

    }
}
