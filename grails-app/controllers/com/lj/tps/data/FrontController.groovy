package com.lj.tps.data

import com.lj.tps.status.TaskStatus
import com.lj.utils.TypeConversion
import grails.converters.JSON

/**
 * 普通用户访问入口
 */
class FrontController {
    def taskService
    def bidService

    /**
     * 首页入口
     */
    def index(){
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
     * 显示我的任务详情
     * @param id
     */
    def showMyTask(){
        def res=taskService.get(params.id as Long)
        params <<["task.id":params.id]
        res << bidService.list(params)
        res << [params:params]
    }

    /**
     * 创建任务
     * @return
     */
    def createTask(){
        [taskInstance: new Task(params)]
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
        def isSelfTask=taskService.isSelfTask(res.taskInstance)
        if(!isSelfTask){
            def myBid=bidService.getMyBid4Task(taskId)
            if(!myBid){
                def newBid=bidService.newBid()
                newBid.price=res.taskInstance?.price
                newBid.gcd=res.taskInstance?.crcd
                res << [newBid:newBid]
            }else{
                res << [myBid:myBid]
            }
        }
        res << [params:params]
        res << bidList
        println res
        res
    }

    /**
     * 新增保存任务
     */
    def saveTask(){
        def res=taskService.save(params)
        if(!res.success)
        render(view:"createTask",model:taskService.save(params))
        else
            redirect(action:"myTask")
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
            redirect(action:"myTask")
            return
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
}
