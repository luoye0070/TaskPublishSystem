package com.lj.tps.data
/**
 *任务
 * 20151014 fala created
 */
class TaskStepRecord {
    //步骤描述
    String stepInfo
    //步骤时间
    Date stepDate
    //任务包
    Task task
    static constraints = {
        stepInfo blank: false
        stepDate nullable: false
        task nullable: true
    }
}
