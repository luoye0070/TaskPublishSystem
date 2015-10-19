package com.lj.tps.status

/**
 * 任务包状态
 * 20151014 fala created
 */
public enum TaskStatus {
    TASK_INIT(-1, "未开始竞标"),
    TASK_EXPIRE(1,"竞标结束"),
    TASK_CANCEL(2,"任务取消"),
    TASK_BIDING(3,"竞标中"),
    TASK_BIDED(4,"任务中标"),
    TASK_COMPLETE(5,"任务成功"),
    TASK_FAILURE(6,"任务失败")

    public Integer code
    public String label

    public TaskStatus(Integer code,String label){
        this.code=code
        this.label=label
    }

    public static def getOptions(){
        [
                [code:TASK_INIT.code,label:TASK_INIT.label],
                [code:TASK_EXPIRE.code,label:TASK_EXPIRE.label],
                [code:TASK_CANCEL.code,label:TASK_CANCEL.label],
                [code:TASK_BIDING.code,label:TASK_BIDING.label],
                [code:TASK_BIDED.code,label:TASK_BIDED.label],
                [code:TASK_COMPLETE.code,label:TASK_COMPLETE.label],
                [code:TASK_FAILURE.code,label:TASK_FAILURE.label]
        ]
    }

    public static def getMyTaskStatus(){
        [   TASK_INIT.code,TASK_EXPIRE.code,TASK_CANCEL.code,TASK_BIDING.code

        ]
    }

    public static def getMySelectorStatus(){
        [     TASK_BIDED.code,TASK_COMPLETE.code,TASK_FAILURE.code

        ]
    }


    public static String getLabel(Integer code){
        switch (code){
            case TASK_INIT.code:
                return TASK_INIT.label
            case TASK_EXPIRE.code:
                return TASK_EXPIRE.label
            case TASK_CANCEL.code:
                return TASK_CANCEL.label
            case TASK_BIDING.code:
                return  TASK_BIDING.label
            case TASK_BIDED.code:
                return TASK_BIDED.label
            case TASK_COMPLETE.code:
                return TASK_COMPLETE.label
            case  TASK_FAILURE.code:
                return TASK_FAILURE.label
            default:
                return "未知状态";
        }
    }
}
