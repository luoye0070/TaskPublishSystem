package com.lj.tps.data

import com.lj.csp.data.Member

class TpsUser extends Member {
    String IDNumber;//身份证号码
    String mobileNumber;//手机号码
    String unitName;//单位名称,选择性填写
    static constraints = {
        IDNumber(nullable: false,blank: false,maxSize: 24);
        mobileNumber(nullable: false,blank: false,maxSize: 16);
        unitName(nullable: true,blank: true,maxSize: 128);
    }
}
