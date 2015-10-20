package com.lj.tps.data
 //竞标评论
class BidComment {
    Bid bid;//竞标
    String commentContent;//评论内容
    TpsUser tpsUser;//评论人
    Date dateCreated=new Date();
    static constraints = {
        bid(nullable: false);
        commentContent(nullable: false,blank: false,maxSize: 1024*10);
        tpsUser(nullable: false);
    }
}
