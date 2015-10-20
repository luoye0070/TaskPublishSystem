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
        if(!Requestmap.findByUrl("/manage/**")){
            new Requestmap(url:'/manage/**',configAttribute:"hasAnyRole('R_DEV','R_ADMIN')").save(flush: true);
            log.info("初始化之管理后台权限配置：/");
        }
        if(!Requestmap.findByUrl("/tpsUserManage/**")){
            new Requestmap(url:'/tpsUserManage/**',configAttribute:"hasAnyRole('R_DEV','R_ADMIN')").save(flush: true);
            log.info("初始化之用户管理权限配置：/tpsUserManage/**");
        }
        if(!Requestmap.findByUrl("/resourceFile/**")){
            new Requestmap(url:'/resourceFile/**',configAttribute:"hasAnyRole('R_DEV','R_ADMIN')").save(flush: true);
            log.info("初始化之资源管理权限配置：/resourceFile/**");
        }
        if(!Requestmap.findByUrl("/user/**")){
            new Requestmap(url:'/user/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之用户管理权限配置：/user/**");
        }
        if(!Requestmap.findByUrl("/tpsResourceFile/**")){
            new Requestmap(url:'/tpsResourceFile/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之用户资源管理权限配置：/tpsResourceFile/**");
        }

        //任务配置
        if(!Requestmap.findByUrl("/front/myTask/**")){
            new Requestmap(url:'/front/myTask/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/myTask/**");
        }

        if(!Requestmap.findByUrl("/front/mySelector/**")){
            new Requestmap(url:'/front/mySelector/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/mySelector/**");
        }

        if(!Requestmap.findByUrl("/front/showMyTask/**")){
            new Requestmap(url:'/front/showMyTask/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/showMyTask/**");
        }

        if(!Requestmap.findByUrl("/front/createTask/**")){
            new Requestmap(url:'/front/createTask/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/createTask/**");
        }


        if(!Requestmap.findByUrl("/front/showMySelector/**")){
            new Requestmap(url:'/front/showMySelector/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/showMySelector/**");
        }


        if(!Requestmap.findByUrl("/front/saveTask/**")){
            new Requestmap(url:'/front/saveTask/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/saveTask/**");
        }

        if(!Requestmap.findByUrl("/front/editTask/**")){
            new Requestmap(url:'/front/editTask/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/editTask/**");
        }

        if(!Requestmap.findByUrl("/front/updateTask/**")){
            new Requestmap(url:'/front/updateTask/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/updateTask/**");
        }

        if(!Requestmap.findByUrl("/front/updTaskStatus/**")){
            new Requestmap(url:'/front/updTaskStatus/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/updTaskStatus/**");
        }

        if(!Requestmap.findByUrl("/front/setupWinner/**")){
            new Requestmap(url:'/front/setupWinner/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/setupWinner/**");
        }

        if(!Requestmap.findByUrl("/front/saveBid/**")){
            new Requestmap(url:'/front/saveBid/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/saveBid/**");
        }


        if(!Requestmap.findByUrl("/front/myBid/**")){
            new Requestmap(url:'/front/myBid/**',configAttribute:"authenticated").save(flush: true);
            log.info("初始化之任务管理权限配置：/front/myBid/**");
        }

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
