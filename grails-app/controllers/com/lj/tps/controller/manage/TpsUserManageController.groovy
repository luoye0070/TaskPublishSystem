package com.lj.tps.controller.manage

import com.lj.csp.bui.BuiUtil
import com.lj.csp.data.Member
import com.lj.csp.data.MemberAuthority
import com.lj.csp.data.Roles
import com.lj.csp.data.RolesAuthority
import com.lj.csp.enumCustom.ReCode
import com.lj.tps.data.TpsUser
import com.lj.utils.I18nError
import com.lj.utils.TypeConversion
import grails.converters.JSON

class TpsUserManageController {
    def member(){
        def rs=[:]
        Roles.findAllByNameNotEqual("开发人员").each{
            rs << ["${it.id}":"${it.name}"]
        }
        println("rss->"+rs)
//        def dps=[:]
//        Department.list().each {
//            dps << ["${it.id}":"${it.name}"]
//        }
//
//        def odps=[:]
//        Department.list().each {
//            odps << ["${it.id}":"${it.name}"]
//        }

        render(view:'/manage/tpsUser',model:[roles:(rs as JSON)])
    }
    def saveMember(){
        println params
        if(TpsUser.findByUsername(params.username)){
            render(ReCode.MEMEBER_EXSITS as JSON);
            return
        }

        TpsUser.withTransaction {status->
            try{
                if(!params.password)
                    params.password='111111'

                def roles=params.remove('roles')

                def member = new TpsUser(params)
                if(roles){
                    def r=roles.split(',')
                    def role
                    r.each{
                        role= Roles.get(com.lj.utils.Number.toLong(it));
                        if(role){
                            member.addToRoles(role)
                        }
                    }
                }

                if (!member.save(flush: true)) {
                    println member.errors
                    def reInfo=[success:false,msg:I18nError.getMessage(g, member.errors.allErrors)];
                    render(reInfo as JSON);
                    return
                }else{


                    def raes
                    member.roles.each{role->

                        raes=RolesAuthority.findAllByRoles(role)
                        if(raes){

                            raes.each{ra->

                                MemberAuthority.create(member,ra.authority,true)
                            }


                        }

                    }
                    render(([member:member] << ReCode.NEW_SUCCESS) as JSON)
                }
            }catch(Exception e){
                println e
                status.setRollbackOnly()
                def reInfo=[success:false,msg:e.getMessage()];
                render(reInfo as JSON);
            }
        }

    }
    def updMember(){
        System.out.println("params->"+params);
        //参数处理
        if(!params.enabled){
            params.enabled=false;
        }
        if(!params.accountExpired){
            params.accountExpired=false;
        }
        if(!params.accountLocked){
            params.accountLocked=false;
        }
        if(!params.passwordExpired){
            params.passwordExpired=false;
        }
        System.out.println("params1->"+params);
        TpsUser member = TpsUser.get(params.id);
        if (!member) {
            render(ReCode.NO_RECORD as JSON);
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (member.version > version) {
                render(ReCode.MANY_UPDATEING as JSON);
                return
            }
        }

        if(params.username!=member.username){
            if(Member.findByUsername(params.username)){
                render(ReCode.MEMEBER_EXSITS as JSON);
                return
            }
        }

        TpsUser.withTransaction {status->
            try{
                if(!params.password)
                    params.remove('password')
                MemberAuthority.removeAll(member)

                def roles=params.remove('roles')

                member.properties = params

                member.roles.clear()
                if(roles){
                    def r=roles.split(',')
                    def role
                    r.each{
                        role= Roles.get(com.lj.utils.Number.toLong(it))
                        if(role){
                            member.addToRoles(role)
                        }
                    }
                }

                if (!member.save(flush: true)) {
                    println(member.errors.allErrors);
                    def reInfo=[success:false,msg:I18nError.getMessage(g, member.errors.allErrors)];
                    render(reInfo as JSON);
                    return
                }

                def raes
                member.roles.each{role->
                    raes=RolesAuthority.findAllByRoles(role)
                    if(raes){
                        raes.each{ra->
                            MemberAuthority.create(member,ra.authority,true)
                        }
                    }

                }
                render(ReCode.UPDATE_SUCCESS as JSON)
            }catch(Exception e){
                status.setRollbackOnly()
                println e
                def reInfo=[success:false,msg:e.getMessage()];
                render(reInfo as JSON);
            }
        }
    }
    def findMember(){
        log.info("params->"+params);
        int max=com.lj.utils.Number.toInteger(params.limit);
        int offset=com.lj.utils.Number.toInteger(params.start);
        def conditions = {


            if (params.username) {
                like("username", "%" + params.username + "%");
            }




            if (params.password) {
                like("password", "%" + params.password + "%");
            }




            if (params.realName) {
                like("realName", "%" + params.realName + "%");
            }




            if (params.IDNumber) {
                like("IDNumber", "%" + params.IDNumber + "%");
            }




            if (params.mobileNumber) {
                like("mobileNumber", "%" + params.mobileNumber + "%");
            }




            if (params.unitName) {
                like("unitName", "%" + params.unitName + "%");
            }




            if (params.accountExpired) {
                boolean accountExpired = true;
                boolean isNotNull = true;
                try {
                    accountExpired = TypeConversion.toBoolean(params.accountExpired);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("accountExpired", accountExpired);
                }
            }




            if (params.accountLocked) {
                boolean accountLocked = true;
                boolean isNotNull = true;
                try {
                    accountLocked = TypeConversion.toBoolean(params.accountLocked);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("accountLocked", accountLocked);
                }
            }




            if (params.enabled) {
                boolean enabled = true;
                boolean isNotNull = true;
                try {
                    enabled = TypeConversion.toBoolean(params.enabled);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("enabled", enabled);
                }
            }




            if (params.passwordExpired) {
                boolean passwordExpired = true;
                boolean isNotNull = true;
                try {
                    passwordExpired = TypeConversion.toBoolean(params.passwordExpired);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("passwordExpired", passwordExpired);
                }
            }


        }

        def tpsUserInstanceListTemp = TpsUser.createCriteria().list([max:max,offset:offset], conditions);
        def totalCount = TpsUser.createCriteria().count(conditions);

        log.info("tpsUserInstanceListTemp->"+tpsUserInstanceListTemp+",totalCount->"+totalCount);

        def tpsUserInstanceList=[];
        if(tpsUserInstanceListTemp){
            tpsUserInstanceList=tpsUserInstanceListTemp.collect {member->
                [
                        id:member.id,
                        username:member.username,
                        realName:member.realName,
                        enabled:member.enabled?'on':'off',
                        accountExpired:member.accountExpired?'on':'off',
                        accountLocked:member.accountLocked?'on':'off',
                        passwordExpired:member.passwordExpired?'on':'off',
                        roles:member.roles.collect{it.id}.join(','),
                        IDNumber:member.IDNumber,
                        mobileNumber:member.mobileNumber,
                        unitName:member.unitName
                ]
            }
        }
        def result=[rows:tpsUserInstanceList,results:totalCount]
        log.info("result->"+result);
        render(result as JSON)
    }
}
