package com.lj.tps.status

/**
 * 联系方式
 * 20151014 fala created
 */
public enum ContactWay {

    PHONE(1,"手机"),
    QQ(2,"QQ"),
    EMAIL(3,"Email")

    public Integer code
    public String label

    public ContactWay(Integer code, String label) {
        this.code = code
        this.label = label
    }

    public static def getOptions(){
        [
                [code:PHONE.code,label:PHONE.label],
                [code:QQ.code,label:QQ.label],
                [code:EMAIL.code,label:EMAIL.label]
        ]
    }
}
