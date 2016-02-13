package com.lj.tps.service

import com.lj.csp.enumCustom.ReCode
import com.lj.tps.data.Bid
import com.lj.tps.data.Task
import com.lj.tps.data.TpsUser
import com.lj.tps.status.BidStatus
import com.lj.tps.status.TaskStatus
import com.lj.utils.I18nError
import com.lj.utils.TypeConversion
import grails.converters.JSON

import java.text.SimpleDateFormat

class TaskService {
    def springSecurityService
    def bidEvaluationService

    /**
     * 获取任务列表
      * @param params
     */
    def  list(def params){

        params.max = Math.min(params.max ?Integer.valueOf(params.max): 10, 100)
        if(!params.order || !params.sort){
            params.sort='id'
            params.order='desc'
        }
        def taskInstance=new Task(params)
        /**
         * 处理查询条件
         */
        def conditions={
            if (params.simpleDesc) {
                like("simpleDesc", "%" + params.simpleDesc + "%");
            }

            if (params.detailDesc) {
                like("detailDesc", "%" + params.detailDesc + "%");
            }

            if (params.crcdBegin) {
                Date date = TypeConversion.toDateTime(params.crcdBegin);
                if (date) {
                    ge("crcd", date);
                }
            }
            if (params.crcdEnd) {
                Date date = TypeConversion.toDateTime(params.crcdEnd);
                if (date) {
                    le("crcd", date);
                }
            }

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

            if (params.attachment) {
                like("attachment", "%" + params.attachment + "%");
            }

            if (params.showMyTask) {
                eq("username", springSecurityService?.currentUser?.username?:"fala");
            }

            if(params.statusList){
                'in'('status',params.statusList)
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

        def taskInstanceList = Task.createCriteria().list(params, conditions)
        //状态转换
        for(Task task in taskInstanceList){
            convertStatus(task)
        }
        def totalCount = Task.createCriteria().count(conditions)

        [taskInstanceList: taskInstanceList, taskInstanceTotal: totalCount,taskInstance:taskInstance]
    }

    /**
     * 获取登陆用户任务
     * @param params
     * @return
     */
    def myTasks(def params){
        params.showMyTask=true
        params.statusList=TaskStatus.getMyTaskStatus()
        def tasks=list(params)
        tasks.taskInstanceList=tasks.taskInstanceList.collect{task->
             [
                     id:task.id,
                     simpleDesc:task.simpleDesc,
                     detailDesc:task.detailDesc,
                     price:task.price,
                     crcd:task.crcd,
                     contactWay:task.contactWay,
                     contactInfo:task.contactInfo,
                     username:task.username,
                     status:task.status,
                     bidderCount:Bid.countByTask(task)
             ]
        }

        return tasks
    }

    /**
     * 获取登陆用户中标
     * @param params
     */
    def mySelectors(def params){
        params.showMyTask=true
        params.statusList=TaskStatus.getMySelectorStatus()
        return list(params)
    }
    /**
     * 转换状态
     * 主要处理，判断竞标日期是否已经过了，如果过了，更新任务状态为竞标结束
     * @param task
     */
    def convertStatus(Task task){
        if(task.status in [TaskStatus.TASK_EXPIRE.code,TaskStatus.TASK_CANCEL.code,
                TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE.code,TaskStatus.TASK_INIT.code,TaskStatus.TASK_BIDED])
            return task.status
        //根据当前日期判断竞标是否结束
        Calendar stopCal=Calendar.getInstance()
        stopCal.setTime(task.crcd)
        if(new Date().after(stopCal.getTime())){
            //当前时间超过了要求完成日期,则竞标结束
            //将任务状态改为竞标结束状态
            task.status=TaskStatus.TASK_EXPIRE.code
            task.save()
            return task.status
        }

        return task.status
    }

    /**
     * 任务保存
     * @param params
     * @return
     */
    def save(def params){

        String crcd = params.crcd;
        Date date_crcd = TypeConversion.toDate(crcd);
        params.crcd = date_crcd;

        def taskInstance = new Task(params)

        if(!taskInstance.username){
            taskInstance.username=springSecurityService.currentUser?.username?:"fala"
        }

        if (!taskInstance.save(flush: true)) {
            return [success: false, taskInstance: taskInstance, msg:"任务创建失败!"]
        }
        [success: true, isSaveOk: true, taskInstance: taskInstance,msg:"任务创建成功!"]
    }

    def get(Long id){
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            return []
        }
        convertStatus(taskInstance)
        [taskInstance: taskInstance]
    }

    def del(def params){
        def res=[success: false,msg:'']
        def idList = [];
        if (params.ids instanceof String) { //传入id
            //获取参数
            long id = com.lj.utils.Number.toLong(params.ids);//信息ID
            idList.add(id);
        } else if (params.ids instanceof String[]) {//传入id数组
            for (int i = 0; i < params.ids.length; i++) {
                Long id = com.lj.utils.Number.toLong(params.ids[i]);
                idList.add(id);
            }
        }

        //查询出内容
        def taskInstanceList = Task.findAllByIdInList(idList);
        if (taskInstanceList) {
            taskInstanceList.each {
                try {
                    it.delete(flush: true)
                }
                catch (Exception ex) {

                }
            }
            res.msg="删除成功"
            res.success=true
        } else {
           res.msg="任务不存在"
        }
        params.remove("ids")

        res << [params:params]

        return res
    }

    /**
     * 更新任务
     * @param params
     * @return
     */
    def update(def params){
        def res=[success:false,errors:'']
        long id = com.lj.utils.Number.toLong(params.id);
        def taskInstance =  Task.get(id)
        if (!taskInstance) {
            res.errors="任务不存在"
            res << [taskInstance:new Task()]
            return res
        }

        res << [taskInstance:taskInstance]

        String crcd = params.crcd;
        Date date_crcd = TypeConversion.toDate(crcd);
        params.crcd = date_crcd;

        taskInstance.properties = params;
        if (!taskInstance.save(flush: true)) {
            res.errors="任务更新失败"
            return  res
        }

        res.success=true
        res.msg="任务更新成功"
        return res
    }

    /**
     * 更新任务状态
     * @param id
     * @param status
     * @return
     */
    def updTaskStatus(Long id,Integer status){
        def res=[success:false,msg:'']

        def taskInstance = Task.get(id)
        if (!taskInstance) {
            res.msg ="任务不存在"
            return res
        }

        Integer taskStatus=convertStatus(taskInstance)

        if(status){
            //设置为 竞标中 状态
            if(status==TaskStatus.TASK_BIDING.code){
                //只有初始状态才可以设置 竞标中 状态
                if(taskStatus==TaskStatus.TASK_INIT.code){
                    taskInstance.status=status
                    if(taskInstance.save(flush: true)){
                        res.success=true
                        res.msg="操作成功"
                        return res
                    }
                }else if(taskStatus==TaskStatus.TASK_BIDING.code){
                    res.success=true
                    res.msg="操作成功"
                    return res
                }

            }else if(status==TaskStatus.TASK_CANCEL.code){
                if(taskStatus==TaskStatus.TASK_CANCEL.code){
                    res.success=true
                    res.msg="操作成功"
                    return res
                }else if(taskStatus in [TaskStatus.TASK_INIT.code,TaskStatus.TASK_BIDING.code ]){
                    taskInstance.status=status
                    if(taskInstance.save(flush: true)){
                        res.success=true
                        res.msg="操作成功"
                        return res
                    }
                }
            }else if(status==TaskStatus.TASK_COMPLETE.code){
                if(taskStatus==TaskStatus.TASK_COMPLETE.code){
                    res.success=true
                    res.msg="操作成功"
                }else if(taskStatus ==TaskStatus.TASK_BIDED.code){
                    taskInstance.status=status
                    if(taskInstance.save(flush: true)){
                        res.success=true
                        res.msg="操作成功"
                        return res
                    }
                }
            }else if(status==TaskStatus.TASK_FAILURE.code){
                if(taskStatus==TaskStatus.TASK_FAILURE.code){
                    res.success=true
                    res.msg="操作成功"
                }else if(taskStatus ==TaskStatus.TASK_BIDED.code){
                    taskInstance.status=status
                    if(taskInstance.save(flush: true)){
                        res.success=true
                        res.msg="操作成功"
                        return res
                    }
                }
            }
        }

        res.msg="操作失败"
        return res
    }

    /**
     * 设置中标者，目前是只能设计一个
     * @param id
     */
    def setupWinner(Long bidId,Long taskId){

        def res=[success:false,errors:'',id:taskId]

        def taskInstance = Task.get(taskId)
        if (!taskInstance) {
            res.errors = "任务不存在"
            return res
        }


        //查找所有的竞标
        def bidList=Bid.createCriteria().list{
            eq("task.id",taskInstance.id)
            ne("status",BidStatus.BID_CANCEL.code)
        }

        if(bidList.size()==0){
            res.errors="没有人竞标"
            return res
        }

        //判断是否已经中标，若有人中标，操作失败
        boolean f=false
        boolean isExists=false
        for(Bid bid in bidList){
            if(bid.status== BidStatus.BID_WIN.code){
                f=true
                break
            }

            if(bid.id==bidId){
                isExists=true
                break
            }
        }

        if(f){
            res.errors="已经有人中标"
            return res
        }
        if(!isExists){
            res.errors="该竞标不存在"
            return res
        }

        Bid bider
        for(Bid bid in bidList){
            if(bid.id==bidId){
                bid.status=BidStatus.BID_WIN.code
                bider=bid
            }else{
                bid.status=BidStatus.BID_LOSE.code
            }

            bid.save(flush: true)
        }

        //设置任务竞标结束
        taskInstance.status=TaskStatus.TASK_BIDED.code
        if(taskInstance.save(flush: true)){
            //统计用户中标数
            //bidEvaluationService.recordTaskCount(1,bider.username)
            res.msg="操作成功"
            res.success=true
        }

        return res
    }

    /**
     * 判断是不是自己的任务
     * @param task
     */
    def isSelfTask(Task task){
        if(!task)
            return false

        //判断任务是否是自己，如果是自己，不能竞标
        if(task.username && springSecurityService?.currentUser?.username && task.username.equals(springSecurityService?.currentUser?.username)){
            return true
        }

        return false
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

    def getTasks4Bui(def params){

        int max=com.lj.utils.Number.toInteger(params.limit);
        int offset=com.lj.utils.Number.toInteger(params.start);
        def conditions = {
            if (params.username) {
                like("username", "%" + params.username + "%");
            }

            if (params.simpleDesc) {
                like("simpleDesc", "%" + params.simpleDesc + "%");
            }

            if (params.status) {
                eq("status",  params.status);
            }
        }

        params.max=max
        params.offset=offset
        def taskInstanceList = Task.createCriteria().list(params, conditions)
        //状态转换
        for(Task task in taskInstanceList){
            convertStatus(task)
        }
        def totalCount = Task.createCriteria().count(conditions)

        def result=[rows:taskInstanceList?.collect{it->
             [
                     id:it.id,
                     simpleDesc:it.simpleDesc,
                     price:it.price,
                     crcd:new SimpleDateFormat("yyyy-MM-dd").format(it.crcd),
                     status:TaskStatus.getLabel(it.status),
                     contactInfo:it.contactInfo,
                     username:it.username
             ]
        },results:totalCount]
        return result
    }

    def delTask(def params){
        def task = Task.get(params.ids)
        if (!task) {
            return ReCode.NO_RECORD
        }


        Task.withTransaction{status->
            try{
                Bid.findByTask(task).collect{
                    it.delete(flush:true)
                }
                task.delete(flush: true)

                return ReCode.DEL_SUCCESS
            }catch(Exception ex){
                status.setRollbackOnly()
                println ex
                return ReCode.DEL_FAIL
            }
        }
    }
}
