package com.lj.tps.data

import org.springframework.dao.DataIntegrityViolationException

import com.lj.utils.I18nError
import com.lj.utils.Number
import com.lj.utils.TypeConversion

class TaskController {
    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def taskInstance = new Task(params)
        def conditions = {


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




            if (params.username) {
                like("username", "%" + params.username + "%");
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

        def taskInstanceList = Task.createCriteria().list(params, conditions);
        def totalCount = Task.createCriteria().count(conditions);

        [taskInstanceList: taskInstanceList, taskInstanceTotal: totalCount, taskInstance: taskInstance]

    }

    def create() {
        [taskInstance: new Task(params)]
    }

    def save() {

        String crcd = params.crcd;
        Date date_crcd = TypeConversion.toDate(crcd);
        params.crcd = date_crcd;

        def taskInstance = new Task(params)

        if(!taskInstance.username){
            taskInstance.username=springSecurityService.currentUser?.username?:'test'
        }

        if (!taskInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, taskInstance.errors.allErrors);
            render(view: "create", model: [taskInstance: taskInstance, errors: errors])
            return
        }

        def success = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
        render(view: "create", model: [success: success, isSaveOk: true, taskInstance: taskInstance])
    }

    def show(Long id) {
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
            return
        }

        [taskInstance: taskInstance]
    }

    def edit(Long id) {
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
            return
        }

        [taskInstance: taskInstance]
    }

    def update(Long id, Long version) {
        def taskInstance = Task.get(id)
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (taskInstance.version > version) {
                taskInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'task.label', default: 'Task')] as Object[],
                        "Another user has updated this Task while you were editing")
                render(view: "edit", model: [taskInstance: taskInstance])
                return
            }
        }


        String crcd = params.crcd;
        Date date_crcd = TypeConversion.toDate(crcd);
        params.crcd = date_crcd;


        taskInstance.properties = params

        if (!taskInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, taskInstance.errors.allErrors);
            render(view: "edit", model: [taskInstance: taskInstance, errors: errors])
            return
        }

        def success = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
        render(view: "edit", model: [success: success, isSaveOk: true, taskInstance: taskInstance])
    }

    def delete() {
        def idList = [];
        if (params.ids instanceof String) { //传入id
            //获取参数
            long id = Number.toLong(params.ids);//图片信息ID
            idList.add(id);
        } else if (params.ids instanceof String[]) {//传入id数组
            for (int i = 0; i < params.ids.length; i++) {
                Long id = Number.toLong(params.ids[i]);
                idList.add(id);
            }
        }
        flash.success = "";
        flash.errors = "";
        //查询出内容
        def taskInstanceList = Task.findAllByIdInList(idList);
        if (taskInstanceList) {
            taskInstanceList.each {
                try {
                    it.delete(flush: true);
                    log.info("删除" + it + "成功");
                    flash.success += message(code: 'task.label', default: 'Task') + "[" + it.id + "]删除成功<br/>";
                }
                catch (Exception ex) {
                    log.info("删除" + it + "失败:" + ex.message);
                    flash.errors += message(code: 'task.label', default: 'Task') + "[" + it.id + "]删除失败<br/>";
                }
            }
        } else {
            flash.errors = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
        }
        params.remove("ids");
        redirect(action: "list", params: params);
    }

    def editTask() {
        def success = null;
        def errors = null;
        def taskInstance = null;
        if (params.id) {
            long id = Number.toLong(params.id);
            taskInstance = Task.get(id)
            if (!taskInstance) {
                errors = "编号为${id}的${message(code: 'task.label', default: 'Task')}不存在";
                render(view: "edit", model: [errors: errors]);
                return;
            }
        } else {
            taskInstance = new Task();
        }
        boolean isSaveOk = false;
        if (request.method == "POST") {

            String crcd = params.crcd;
            Date date_crcd = TypeConversion.toDate(crcd);
            params.crcd = date_crcd;

            taskInstance.properties = params;
            if (!taskInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, taskInstance.errors.allErrors);
                render(view: "edit", model: [taskInstance: taskInstance, errors: errors])
                return
            }
            success = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
            isSaveOk = true;
        }
        render(view: "edit", model: [isSaveOk: isSaveOk, taskInstance: taskInstance, success: success, errors: errors]);
    }

}
