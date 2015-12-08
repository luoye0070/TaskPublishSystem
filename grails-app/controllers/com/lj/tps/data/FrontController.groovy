package com.lj.tps.data

import com.lj.tps.status.BidStatus
import com.lj.tps.status.TaskStatus
import com.lj.utils.TypeConversion
import grails.converters.JSON

/**
 * 普通用户访问入口
 */
class FrontController {
    def taskService
    def bidService
    def commentService;
    def springSecurityService;
    def bidEvaluationService
    /**
     * 首页入口
     */
    def index(){
       params.statusList=TaskStatus.getStatusNoCancel()
        taskService.list(params)
    }

    /**
     * 用户任务
     * @return
     */
    def myTask(){
        render(view:"myTask",model:taskService.myTasks(params))
    }

    /**
     *用户中标
     */
    def mySelector(){
        render(view:"mySelector",model:taskService.mySelectors(params))
    }

    /**
     * 显示我的任务详情
     * @param id
     */
    def showMyTask(){
        def res=taskService.get(params.id as Long)
        if(!params.getProperty("task.id"))
        params.setProperty("task.id",params.id)
        res << bidService.list(params)
        res << [params:params]

//        //获取评论
//        def taskId=params.id as Long
//        def taskComments=commentService.getTaskComment([taskId:taskId])
//        res << [taskComments:taskComments.taskComments]
//        if(res.taskInstance?.username!=springSecurityService.currentUser?.username){
//            res<<[canComment:true];
//        }else{
//            res<<[canComment:false];
//        }
//        //获取提交评论地址
//        def doTaskCommentUrl=createLink(controller: "comment",action: "doTaskComment",params: [backUrl:createLink(absolute: true,controller: "front",action: "showTask",params: [id:taskId])+"#pl"]);
//        res << [doTaskCommentUrl:doTaskCommentUrl]
    }

    /**
     * 创建任务
     * @return
     */
    def createTask(){
        def taskInstance=new Task(params)
        taskInstance.contactInfo=taskService.getUserInfo()?.mobileNumber
        [taskInstance: taskInstance]
    }

    /**
     * 显示任务详情
     * @param id
     */
    def showTask(){

        def taskId=params.id as Long
        def res=taskService.get(taskId)
        params <<["task.id":taskId]
        def bidList=bidService.list(params)
        res << bidList
        def isSelfTask=taskService.isSelfTask(res.taskInstance)

        res<<[isWin:false]
        if(!isSelfTask){
            def myBid=bidService.getMyBid4Task(taskId)
            if(myBid){
                res << [myBid:myBid]
                res << [canJoin:false]
                //判断是否中标
                if(myBid.status== BidStatus.BID_WIN.code){
                    res << [isWin:true]
                }
            } else{
                //只有竞标中状态才可以参与竞标
                if(res.taskInstance.status==TaskStatus.TASK_BIDING.code)
                res << [canJoin:true]
            }
        }

        res << [isSelfTask:isSelfTask]

        res << [params:params]

        res
    }

    /**
     * 参与竞标
     * @return
     */
    def joinBid(){
        def taskId=params.id as Long
        def res=taskService.get(taskId)
        params <<["task.id":taskId]

        def isSelfTask=taskService.isSelfTask(res.taskInstance)
        if(!isSelfTask){
            def myBid=bidService.getMyBid4Task(taskId)
            if(myBid){
                redirect(action:'showTask',params:[id:taskId])
            }else if(!myBid && res.taskInstance?.status==TaskStatus.TASK_BIDING.code){
                def newBid=bidService.newBid()
                newBid.price=res.taskInstance?.price
                newBid.gcd=res.taskInstance?.crcd
                res << [newBid:newBid]
                res << [taskInstance:res.taskInstance]
            }else{
                redirect(action:'showTask',params:[id:taskId])
            }
        }else{
            redirect(action:'showTask',params:[id:taskId])
        }
    }

    /**
     * 显示中标详情
     */
    def showMySelector(){
        def taskId=params.id as Long
        def res=taskService.get(taskId)
        if(!params.getProperty("task.id"))
        params.setProperty("task.id",taskId)
        res<<bidService.getBid4Task(params)
        res
    }

    /**
     * 新增保存任务
     */
    def saveTask(){
        def res=taskService.save(params)
        if(!res.success)
        render(view:"createTask",model:res)
        else
            redirect(action:"showMyTask",params:[id:res.taskInstance.id])
    }

    /**
     * 编辑任务
     */
    def editTask(Long id){
        def model=taskService.get(id)
        if(!model?.taskInstance || model.taskInstance.status!= TaskStatus.TASK_INIT.code){
            redirect(action:"myTask")
            return
        }

        model
    }

    /**
     * 更新任务
     */
    def updateTask(){
        def res=taskService.update(params)
        if(!res.success)
            render(view:'editTask',model:res)
        else{
            redirect(action:"showMyTask",params:[id:res.taskInstance.id])
        }
    }

    /**
     * 更新任务状态
     * @param id
     * @param status
     */
    def updTaskStatus(Long id,Integer status){
        render taskService.updTaskStatus(id,status) as JSON
    }

    def setupWinner(Long bidId,Long id){

        def res=taskService.setupWinner(bidId,id)
        if(!res.success)
        flash.errors=res.errors
        params.remove(bidId)
        redirect(action:"showMyTask",params:params)
    }

    /**
     * 保存竞标
     */
    def saveBid(){
        render bidService.save(params) as JSON
    }

    /**
     * 我的竞标
     */
    def myBid(){
        params.showMyBid=true
        bidService.list(params)
    }
    /**
     * 显示评价
     * @return
     */
    def showEvaluation(){
        if(!params.evaluationLevel)
            params.evaluationLevel=1
        bidEvaluationService.getEvaluations(params)
    }

    //发表评价
    def createEvaluation(){
        def task=Task.get(params.taskId)
        def bid=Bid.get(params.bidId)
        if(task && bid){
            if((task.status in [TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE.code] && bid.evaluated==false)){
                params
            }else{
                redirect(action:"showMySelector",params: [id:params.taskId])
            }
        }else{
            redirect(action:"showMySelector",params: [id:params.taskId])
        }


    }

    //保存评价
    def saveEvaluation(){
         def res=bidEvaluationService.createEvaluation(params)
        if(res.success){
            redirect(action:'showEvaluation',params:[evaluatedPerson:params.evaluatedPerson])
        }else{
            flash.errors=res.msg
            redirect(action:"showEvaluation",params:params)
        }
    }


    def getTasks4Bui(){
        render taskService.getTasks4Bui(params) as JSON
    }

    def delTask(){
        render taskService.delTask(params) as JSON
    }

}
