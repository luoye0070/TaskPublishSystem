package com.lj.tps.service

import com.lj.csp.data.*
import com.lj.tps.data.TpsUser

class SystemInitService {

    def rolesService

    void init(){
        initRequest()
        initAuthority()
        initRoles()
        initMember()
    }

    //初始化Request
    void initRequest(){
        if(!Requestmap.findByUrl("/")){
            new Requestmap(url:'/',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之首页权限配置：/");
        }
//        if(!Requestmap.findByUrl("/dd/**")){
//            new Requestmap(url:'/dd/**',configAttribute:"hasAnyRole('R_DEV','R_ADMIN','R_NORMAL_USER')").save(flush: true);
//            log.info("初始化之dd管理权限配置：/certificateDetail/**");
//        }
    }

    //初始话authority
    void initAuthority(){
        def authority=Authority.findByAuthority('R_NORMAL_USER')
        if(!authority)
            new Authority(authority:'R_NORMAL_USER',remark: '普通用户').save(flush: true)
    }

    //初始化Roles
    void initRoles(){
        def params=[:]
        def authority
        def roles=Roles.findByName('普通用户')
        if(!roles){
            params << [name:'普通用户',remark:'普通用户正常功能']
            authority=Authority.findByAuthority('R_NORMAL_USER')
            if(authority)
                params << [authorities:authority.id.toString()]

            rolesService.save(params)
        }
    }


    void initMember(){
        def member=TpsUser.findByUsername('exampleUser')
        def roles
        def params=[:]
        if(!member){
            params << [username:'exampleUser',password:'111111',realName:'普通用户例子',IDNumber:"34499837838444",mobileNumber:"187877667663"]
            roles=Roles.findByName('普通用户')
            member=new TpsUser(params);
            if(roles){
                member.addToRoles(roles);
            }

            if(!member.save(flush: true)){
                println("初始化普通用户失败："+member.errors.getAllErrors())
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
            }
        }
    }
}
