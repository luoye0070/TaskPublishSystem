package com.lj.tps.data
 //任务评论
class TaskComment {
    Task task;//任务
    String commentContent;//评论内容
    TpsUser tpsUser;//评论人
    static constraints = {
        task(nullable: false);
        commentContent(nullable: false,blank: false);
        tpsUser(nullable: false);
    }
}
