package com.lj.tps.status

/**
 * 竞标状态
 * 20151014 fala created
 */
public enum BidStatus {
    BID_INIT(-1, "初始状态"),
    BID_WIN(1, "竞标成功"),
    BID_LOSE(2, "竞标失败"),
    BID_CANCEL(3, "取消竞标")

    public Integer code
    public String label

    public BidStatus(Integer code, String label) {
        this.code = code
        this.label = label
    }

    public static def getOptions(){
        [
                [code:BID_INIT.code,label:BID_INIT.label],
                [code:BID_WIN.code,label:BID_WIN.label],
                [code:BID_LOSE.code,label:BID_LOSE.label],
                [code:BID_CANCEL.code,label:BID_CANCEL.label]
        ]
    }
    public static String getLabel(Integer code) {
        switch (code) {
            case  BID_INIT.code:
                return BID_INIT.label
            case BID_WIN.code:
                return BID_WIN.label
            case BID_LOSE.code:
                return BID_LOSE.label
            case BID_CANCEL.code:
                return BID_CANCEL.label
            default:
                return "未知状态"
        }
    }
}