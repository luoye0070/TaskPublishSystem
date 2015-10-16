package com.lj.tps.data

import com.lj.tps.status.BidStatus
import com.lj.tps.status.ContactWay

/**
 *竞标
 * 20151014 fala created
 */
class Bid {
    //联系方式 ，电话、qq、邮箱
    Integer contactWay=ContactWay.PHONE.code
    //联系信息
    String contactInfo
    //技术或优势描述
    String skillDesc
    BigDecimal price
    Date gcd

    //竞标人账号 ,竞标人不能对同一个任务包多次竞标
    String username
    //竞标任务包
    Task task
    //任务包状态
    Integer status=BidStatus.BID_INIT.code

    static constraints = {
        contactWay nullable:false,inList:ContactWay.values()*.code
        contactInfo blank: false
        skillDesc blank: false ,maxSize: 1024*10
        price nullable: false ,min:new BigDecimal(0)
        gcd nullable: false

        username blank: false
        task nullable: true
        status nullable: false,inList: BidStatus.values()*.code

    }
}
