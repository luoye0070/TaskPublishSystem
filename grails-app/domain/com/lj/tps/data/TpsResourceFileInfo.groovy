package com.lj.tps.data

import com.lj.csp.data.Member
import com.lj.rmp.data.ResourceFileInfo

class TpsResourceFileInfo extends ResourceFileInfo {
    Member member;
    static constraints = {
        member(nullable: false);
    }
}
