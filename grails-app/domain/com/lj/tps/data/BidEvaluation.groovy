package com.lj.tps.data
/**
 * 中标评价
 */
class BidEvaluation {
    Long taskId //中标任务id
    Long bidId   //中标id
    String valuer //评价人，任务发布人
    Date evaluationTime   //评价时间
    Integer workSpeed=0 //工作速度
    Integer workQuaity=0 //工作质量
    Integer workAttitude=0 //工作态度
    String  evaluationContent //评价内容
    String evaluatedPerson //被评价人
    String simpleDesc //任务标题
    Integer evaluationLevel //1好评 0中评 -1 差评

    static constraints = {
        evaluationContent(maxSize: 1024)
    }
}
