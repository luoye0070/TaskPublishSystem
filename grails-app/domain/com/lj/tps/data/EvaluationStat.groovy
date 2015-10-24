package com.lj.tps.data

/**
 * 评价统计
 */
class EvaluationStat {

    Long taskCount //参与任务数
    Long evaluationCount=0 //评价数
    Long workSpeedSum=0
    Long workQuaitySum=0
    Long workAttitudeSum=0
    String evaluatedPerson //被评价人

    static constraints = {
    }
}
