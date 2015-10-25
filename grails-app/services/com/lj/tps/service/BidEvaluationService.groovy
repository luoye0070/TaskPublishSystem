package com.lj.tps.service

import com.lj.tps.data.Bid
import com.lj.tps.data.BidEvaluation
import com.lj.tps.data.EvaluationStat
import com.lj.tps.data.Task
import com.lj.tps.status.BidStatus
import com.lj.tps.status.TaskStatus

class BidEvaluationService {
    def springSecurityService
    /**
     * 将当前用户参与的任务数记录下来
     * @param num
     */
   void recordTaskCount(int num,String evaluatedPerson){
       //查找是否已经有记录
       def stat=EvaluationStat.findByEvaluatedPerson(evaluatedPerson)
       if(stat){
           stat.evaluationCount=stat.evaluationCount+(num?:1)
       }else{
           stat=new EvaluationStat();
           stat.evaluatedPerson=member.username
           stat.evaluationCount=1
       }

       stat.save(flush: true)
   }

    /**
     * 获取指定用户的评价信息
     */
    def getEvaluations(def params){

        def res=[:]

        if(!params.evaluatedPerson){
            def member=springSecurityService.currentUser
            if(member)
                params.evaluatedPerson=member.username
        }

        res << [evaluatedPerson:params.evaluatedPerson]
        if(params.evaluatedPerson){
            //查找评价统计信息
//            def stat=EvaluationStat.findByEvaluatedPerson(params.evaluatedPerson)
//            if(stat){
//               res << [taskCount:stat.taskCount,evaluationCount:stat.evaluationCount]
//               if(stat.evaluationCount==0){
//                   res << [workSpeedAvg:0,workQuaityAvg:0,workAttitudeAvg:0]
//               }else{
//                   res << [workSpeedAvg:(stat.workSpeedSum/stat.evaluationCount as Integer),
//                           workQuaityAvg:(stat.workQuaitySum/stat.evaluationCount as Integer),
//                           workAttitudeAvg:(stat.workAttitudeSum/stat.evaluationCount as Integer)]
//               }
//            }

            //查找评价明细信息
            res << getEvalutionList(params)

            //获取好评数量
            res << [good:BidEvaluation.createCriteria().count{
                eq('evaluatedPerson',params.evaluatedPerson)
                eq('evaluationLevel',1)
            }]

            //获取差评数量
            res << [bad:BidEvaluation.createCriteria().count{
                eq('evaluatedPerson',params.evaluatedPerson)
                eq('evaluationLevel',-1)
            }]
            //获取中评数量
            res << [mid:BidEvaluation.createCriteria().count{
                eq('evaluatedPerson',params.evaluatedPerson)
                eq('evaluationLevel',0)
            }]
        }

        return res
    }


    def getEvalutionList(def params){
        params.max = Math.min(params.max ?Integer.valueOf(params.max): 10, 100)
        if(!params.order || !params.sort){
            params.sort='id'
            params.order='desc'
        }
        def condition={
            eq('evaluatedPerson',params.evaluatedPerson)

            if(params.evaluationLevel)
             eq('evaluationLevel',params.evaluationLevel as int)
        }
        def evaluationList=BidEvaluation.createCriteria().list(params,condition).collect{
            [
                    taskId:it.id,
                    taskName:it.simpleDesc,
                    valuer:it.valuer,
                    evaluationTime:it.evaluationTime,
                    workSpeed:it.workSpeed,
                    workQuaity:it.workQuaity,
                    workAttitude:it.workAttitude,
                    evaluationContent:it.evaluationContent,
                    evaluationLevel:it.evaluationLevel,
                    simpleDesc:it.simpleDesc
            ]
        }

        def evaluationCount=BidEvaluation.createCriteria().count(condition)

        return [evaluationList:evaluationList,evaluationCount:evaluationCount]
    }

    /**
     * 创建评价
     * @param params
     */
    def createEvaluation(def params){
        def res=[success:false,msg:'']

        def member=springSecurityService.currentUser
        if(!member){
            return res
        }

        def task=Task.get(params.taskId)
        if(!task){
            res.msg="任务不存在"
            return res
        }

        def bid=Bid.get(params.bidId)
        if(!bid){
            res.msg="中标不存在"
            return res
        }


        if(!(task.status in [TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE.code]  && bid.evaluated==false)){
            res.msg="不能评价"
            return res
        }


        bid.evaluated=true
        params.valuer=member.username

        def bidEvalution=new BidEvaluation(params)
        bidEvalution.evaluationTime=new Date()
        bidEvalution.save(flush:true)
        bid.save(flush: true)

        println bidEvalution.errors
        println bid.errors
//
//        if(bidEvalution.save(flush:true)){
            //记录评价信息
//            def stat=EvaluationStat.findByEvaluatedPerson(params.evaluatedPerson)
//            if(!stat){
//                stat=new EvaluationStat();
//                stat.evaluatedPerson=params.evaluatedPerson
//                stat.evaluationCount=1
//            }
//
//            stat.workSpeedSum+=params.workSpeed as Long
//            stat.workQuaitySum+=params.workQuaity as Long
//            stat.workAttitudeSum+=params.workAttitude as Long
//            stat.evaluationCount+=1
//
//            if(stat.save(flush: true)){
//                res.success=true
//                res.msg="评价成功"
//            }

//            res.success=true
//        }
        res.success=true

        return res
    }

}
