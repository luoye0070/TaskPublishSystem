package com.lj.tps.service

import com.lj.constant.ReCode
import com.lj.tps.data.Bid
import com.lj.tps.data.BidComment
import com.lj.tps.data.Task
import com.lj.tps.data.TaskComment
import com.lj.tps.data.TpsUser
import com.lj.tps.status.BidStatus
import com.lj.tps.status.TaskStatus
import com.lj.utils.I18nError
import com.lj.utils.Number;

class CommentService {

    def springSecurityService;
    def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib();

    def createTaskComment(def params) {
        String commentContent=params.commentContent;
        long taskId=Number.toLong(params.taskId);
        def member=springSecurityService.currentUser;
        if(member){
            Task task= Task.get(taskId);
            if(task){
                if(task.status==TaskStatus.TASK_CANCEL.code||task.status==TaskStatus.TASK_FAILURE.code){//取消的和失败的任务不能评论
                    return [recode: ReCode.TASK_CAN_NOT_COMMENT];
                }else {
                    TpsUser tpsUser=TpsUser.get(member.id);
                    TaskComment taskComment=new TaskComment();
                    taskComment.setTask(task);
                    taskComment.setCommentContent(commentContent);
                    taskComment.setTpsUser(tpsUser);
                    if(!taskComment.save(flush: true)){
                        return [recode:ReCode.SAVE_FAILED,errors:I18nError.getMessage(g, taskComment.errors.allErrors)];
                    }else{
                        return [recode: ReCode.OK];
                    }
                }
            }else{
                return [recode: ReCode.NOT_FOUND_TASK];
            }
        }else{
            return [recode:ReCode.NOT_LOGIN];
        }
    }

    def getTaskComment(def params){
        long taskId=Number.toLong(params.taskId);
        Task task= Task.get(taskId);
        def taskComments=TaskComment.findAllByTask(task);
        return [taskComments:taskComments];
    }

    def createBidComment(def params) {
        String commentContent=params.commentContent;
        long bidId=Number.toLong(params.bidId);
        int grade=Number.toInteger(params.grade);
        def member=springSecurityService.currentUser;
        if(member){
            Bid bid= Bid.get(bidId);
            if(bid){
                if(bid.getStatus()==BidStatus.BID_WIN.code){//竞标成功的才能评论
                    TpsUser tpsUser=TpsUser.get(member.id);
                    BidComment bidComment=new BidComment();
                    bidComment.setBid(bid);
                    bidComment.setCommentContent(commentContent);
                    bidComment.setTpsUser(tpsUser);
                    bidComment.setGrade(grade);
                    if(!bidComment.save(flush: true)){
                        return [recode:ReCode.SAVE_FAILED,errors:I18nError.getMessage(g, bidComment.errors.allErrors)];
                    }else{
                        return [recode: ReCode.OK];
                    }
                }else{
                    return [recode: ReCode.BID_CAN_NOT_COMMENT];
                }
            }else{
                return [recode: ReCode.NOT_FOUND_BID];
            }

        }else{
            return [recode:ReCode.NOT_LOGIN];
        }
    }

    def getBidComment(params){
        long bidId=Number.toLong(params.bidId);
        Task bid= Bid.get(bidId);
        def bidComments=BidComment.findAllByBid(bid);
        return [bidComments:bidComments];
    }
}
