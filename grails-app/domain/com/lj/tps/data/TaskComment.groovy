package com.lj.tps.data
 //任务评论
class TaskComment {
    Task task;//任务
    String commentContent;//评论内容
    TpsUser tpsUser;//评论人
    Date dateCreated=new Date();
    static constraints = {
        task(nullable: false);
        commentContent(nullable: false,blank: false,maxSize: 1024*10);
        tpsUser(nullable: false);
    }
}
