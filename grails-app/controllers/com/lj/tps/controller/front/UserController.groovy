package com.lj.tps.controller.front

import com.lj.csp.data.Member
import com.lj.csp.data.MemberAuthority
import com.lj.csp.data.Roles
import com.lj.csp.data.RolesAuthority
import com.lj.csp.enumCustom.ReCode
import com.lj.tps.data.TpsUser
import com.lj.utils.I18nError
import com.lj.utils.Number;

class UserController {
    def springSecurityService;

    def index(){redirect(action: "show")}

    //用户信息修改
    def edit(){
        def success = null;
        def errors = null;
        def tpsUserInstance = null;
        long id=Number.toLong(params.id);
        if(!id){
            def member = springSecurityService.currentUser;
            if(member){
                id=member.id;
            }
        }
        tpsUserInstance = TpsUser.get(id)
        if (!tpsUserInstance) {
            errors = "${message(code: 'tpsUser.label', default: 'TpsUser')}不存在";
            render(view: "/front/user/edit", model: [errors: errors]);
            return;
        }


        boolean isSaveOk = false;
        if (request.method == "POST") {

            tpsUserInstance.properties = params;
            if (!tpsUserInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, tpsUserInstance.errors.allErrors);
                render(view: "/front/user/edit", model: [tpsUserInstance: tpsUserInstance, errors: errors])
                return
            }
            success = "保存用户信息成功";
            isSaveOk = true;
        }
        render(view: "/front/user/edit", model: [isSaveOk: isSaveOk, tpsUserInstance: tpsUserInstance, success: success, errors: errors]);

    }
    //用户信息展示
    def show(){
        def success = null;
        def errors = null;
        long id=Number.toLong(params.id);
        if(!id){
            def member = springSecurityService.currentUser;
            if(member){
                id=member.id;
            }
        }

        def tpsUserInstance = TpsUser.get(id);
        if (!tpsUserInstance) {
            errors = "用户信息不存在";
        }

       render(view:"/front/user/show",model:[tpsUserInstance: tpsUserInstance,errors:errors]);
    }
    //密码修改
    def changePW(){
        def success = null;
        def errors = null;
        long id=Number.toLong(params.id);
        if(!id){
            def member = springSecurityService.currentUser;
            if(member){
                id=member.id;
            }
        }
        boolean isSaveOk = false;
        if(request.method=="POST"){
            def member = Member.get(id);
            if (!member) {
                errors = "${message(code: 'tpsUser.label', default: 'TpsUser')}不存在";
                render(view: "/front/user/updPass", model: [errors: errors]);
                return;
            }
            //检查老密码输入是否正确
            String oldPass=springSecurityService.encodePassword(params.oldPass);
            if(oldPass!=member.password){
                errors = "旧密码不正确，请重新输入";
                render(view: "/front/user/updPass", model: [errors: errors]);
                return;
            }

            if (params.version) {
                def version = params.version.toLong()
                if (member.version > version) {
                    errors = "其他人正在修改该条记录";
                    render(view: "/front/user/updPass", model: [errors: errors]);
                    return;
                }
            }
            //检查两次输入的密码是否一致
            if(params.newPass!=params.newPass1){
                errors = "两次输入的密码不一致";
                render(view: "/front/user/updPass", model: [errors: errors]);
                return;
            }

            member.password = params.newPass;

            if (!member.save(flush: true)) {
                errors = I18nError.getMessage(g, member.errors.allErrors);
                render(view: "/front/user/updPass", model: [errors: errors])
                return;
            }else{
                success="密码修改成功";
            }
        }
        render(view: "/front/user/updPass", model: [isSaveOk: isSaveOk, success: success, errors: errors]);
    }
}
