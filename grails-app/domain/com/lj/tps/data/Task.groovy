package com.lj.tps.data

import com.lj.tps.status.ContactWay
import com.lj.tps.status.TaskStatus

/**
 *任务
 * 20151014 fala created
 */
class Task {

    //简单描述
    String simpleDesc
    //详细描述
    String detailDesc
    //价格
    BigDecimal price
    //要求完成日期
    Date crcd
    //联系方式 ，电话、qq、邮箱
    Integer contactWay=ContactWay.PHONE.code
    //联系信息
    String contactInfo

    //任务包所属账号
    String username
    //竞标状态
    Integer status=TaskStatus.TASK_INIT.code
    static constraints = {
        simpleDesc blank: false,maxSize: 150
        detailDesc blank: false,maxSize: 1024*10
        price nullable: false,min: new BigDecimal(0)
        crcd nullable: false
        contactWay nullable:false,inList:ContactWay.values()*.code
        contactInfo blank: false

        username blank: false
        status nullable: false, inList:TaskStatus.values()*.code

    }
}