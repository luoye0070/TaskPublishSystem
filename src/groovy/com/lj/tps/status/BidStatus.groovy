package com.lj.tps.status

/**
 * 竞标状态
 * 20151014 fala created
 */
public enum BidStatus {
    BID_INIT(-1, "初始状态"),
    BID_BIDING(1, "竞标中"),
    BID_WIN(2, "竞标成功"),
    BID_LOSE(3, "竞标失败"),
    BID_CANCEL(4, "标的取消")

    public Integer code
    public String label

    public BidStatus(Integer code, String label) {
        this.code = code
        this.label = label
    }

    public static String getLabel(Integer code) {
        switch (code) {
            case  BID_INIT:
                return BID_INIT.label
            case BID_BIDING:
                return BID_BIDING.label
            case BID_WIN:
                return BID_WIN.label
            case BID_LOSE:
                return BID_LOSE.label
            case BID_CANCEL:
                return BID_CANCEL.label
            default:
                return "未知状态"
        }
    }
}