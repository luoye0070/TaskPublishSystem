package com.lj.tps.service

import com.lj.tps.data.Bid
import com.lj.tps.data.Task
import com.lj.tps.data.TpsUser
import com.lj.tps.status.BidStatus
import com.lj.utils.I18nError
import com.lj.utils.TypeConversion

class BidService {

    def springSecurityService

    /**
     * 获取所有竞标
     * @param task
     */
    def list(def params){
        params.max = Math.min(params.max ?Integer.valueOf(params.max): 10, 100)
        def bidInstance = new Bid(params)
        def conditions = {
            if (params.contactWay) {
                int contactWay = 0;
                try {
                    contactWay = Integer.parseInt(params.contactWay);
                } catch (Exception ex) {}
                if (contactWay) {
                    eq("contactWay", contactWay);
                }
            }

            if (params.contactInfo) {
                like("contactInfo", "%" + params.contactInfo + "%");
            }

            if (params.skillDesc) {
                like("skillDesc", "%" + params.skillDesc + "%");
            }

            if (params.gcdBegin) {
                Date date = TypeConversion.toDateTime(params.gcdBegin);
                if (date) {
                    ge("gcd", date);
                }
            }
            if (params.gcdEnd) {
                Date date = TypeConversion.toDateTime(params.gcdEnd);
                if (date) {
                    le("gcd", date);
                }
            }

            if (params.showMyBid) {
                eq("username",springSecurityService?.currentUser?.username?:'fala');
            }

            String task = params.get("task.id");
            if (task) {
                long task_l = TypeConversion.toLong(task);
                if (task_l)
                    eq("task.id", task_l);
            }

            if (params.status) {
                int status = 0;
                try {
                    status = Integer.parseInt(params.status);
                } catch (Exception ex) {}
                if (status) {
                    eq("status", status);
                }
            }
        }

        def bidInstanceList = Bid.createCriteria().list(params, conditions);
        def totalCount = Bid.createCriteria().count(conditions);

        [bidInstanceList: bidInstanceList, bidInstanceTotal: totalCount, bidInstance: bidInstance]
    }

    /**
     * 查看是否存在该用户的标的
     * @param taskId
     */
    def getMyBid4Task(Long taskId){

        if(!springSecurityService?.currentUser?.username)
            return null

        def list=Bid.createCriteria().list{
            eq("username",springSecurityService?.currentUser?.username)
            eq("task.id",taskId)
        }

        if(list.size()>0)
            return list.get(0)
        return null
    }

    //查找该任务的中标人
    def getWinBid4Task(Long taskId){
        def list=Bid.createCriteria().list{
            eq("task.id",taskId)
            eq('status', BidStatus.BID_WIN.code)
        }

        if(list.size()>0)
            return list.get(0)
        return null
    }

    //查找该任务的竞标信息
    def getBid4Task(Long taskId){
        def res=[winBid:null,otherBids:null]
        def list=Bid.createCriteria().list{
            eq("task.id",taskId)
            eq('status', BidStatus.BID_WIN.code)
        }

        if(list.size()>0)
            res.winBid= list.get(0)

        res.otherBids=Bid.createCriteria().list{
            eq("task.id",taskId)
            ne('status', BidStatus.BID_WIN.code)
        }
        return res
    }

    /**
     * 新建Bid
     */
    def newBid(){
        def newBid=new Bid()
        newBid.contactInfo=getUserInfo()?.mobileNumber
        return newBid
    }

    /**
     * 保存
     * @return
     */
    def save(def params) {

        def res=[success:false,msg:'']
        String gcd = params.gcd;
        Date date_gcd = TypeConversion.toDate(gcd);
        params.gcd = date_gcd;

        def bidInstance = new Bid(params)

        if(!bidInstance.username){
            bidInstance.username=springSecurityService?.currentUser?.username
        }
        println bidInstance
        if (!bidInstance.save(flush: true)) {
            res.msg="提交失败!请重新提交!"
            println bidInstance.errors
            return res
        }

        res.success=true
        return res
    }

    /**
     * 获取登陆用户其他信息（手机号，邮箱）
     */
    def getUserInfo(){
        def member = springSecurityService.currentUser
        if(member){
            return TpsUser.get(member.id)
        }

        return null
    }
}
