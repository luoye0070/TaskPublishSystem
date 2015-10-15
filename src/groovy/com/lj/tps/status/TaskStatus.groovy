package com.lj.tps.status

/**
 * 任务包状态
 * 20151014 fala created
 */
public enum TaskStatus {
    TASK_EXPIRE(1,"任务包过期"),
    TASK_CANCEL(2,"任务包取消"),
    TASK_BIDING(3,"任务包竞标中"),
    TASK_WIN_BID(4,"任务包中标")

    public Integer code
    public String label

    public TaskStatus(Integer code,String label){
        this.code=code
        this.label=label
    }

    public static String getLabel(Integer code){
        switch (code){
            case TASK_EXPIRE:
                return TASK_EXPIRE.label
            case TASK_CANCEL:
                return TASK_CANCEL.label
            case TASK_BIDING:
                return  TASK_BIDING.label
            case TASK_WIN_BID:
                return TASK_WIN_BID.label
            default:
                return "未知状态";
        }
    }
}
