package com.lj.tps.data

import com.lj.csp.data.Member
import com.lj.utils.StrCheckUtil

class TpsUser extends Member {
    String IDNumber;//身份证号码
    String mobileNumber;//手机号码
    String unitName;//单位名称,选择性填写
    String remark;//备注，用于当设置为不可用时，记录一个原因
    static constraints = {
        IDNumber(nullable: false,blank: false,maxSize: 24,validator: {
            if (it) {
                if (!StrCheckUtil.chkStrFormat(it, "passport")) {
                    return ["idFormatError"]
                }
            }
        });
        mobileNumber(nullable: false,blank: false,maxSize: 16,validator: {
            if (it) {
                if (!StrCheckUtil.chkStrFormat(it, "mobile")) {
                    return ["formatError"]
                }
            }
        });
        unitName(nullable: true,blank: true,maxSize: 128);
        remark(nullable: true,blank: true,maxSize: 128);
    }
}
