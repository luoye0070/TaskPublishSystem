package com.lj.tps.data

import org.springframework.dao.DataIntegrityViolationException

import com.lj.utils.I18nError
import com.lj.utils.Number
import com.lj.utils.TypeConversion

class BidController {
    def springSecurityService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
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




            if (params.attachment) {
                like("attachment", "%" + params.attachment + "%");
            }




            if (params.username) {
                like("username", "%" + params.username + "%");
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

    def create() {
        [bidInstance: new Bid(params)]
    }

    def save() {

        String gcd = params.gcd;
        Date date_gcd = TypeConversion.toDate(gcd);
        params.gcd = date_gcd;

        def bidInstance = new Bid(params)

        if(!bidInstance.username){
            bidInstance.username=springSecurityService.currentUser?.username?:'test'
        }

        if (!bidInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, bidInstance.errors.allErrors);
            render(view: "create", model: [bidInstance: bidInstance, errors: errors])
            return
        }

        def success = message(code: 'default.created.message', args: [message(code: 'bid.label', default: 'Bid'), bidInstance.id])
        render(view: "create", model: [success: success, isSaveOk: true, bidInstance: bidInstance])
    }

    def show(Long id) {
        def bidInstance = Bid.get(id)
        if (!bidInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bid.label', default: 'Bid'), id])
            redirect(action: "list")
            return
        }

        [bidInstance: bidInstance]
    }

    def edit(Long id) {
        def bidInstance = Bid.get(id)
        if (!bidInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bid.label', default: 'Bid'), id])
            redirect(action: "list")
            return
        }

        [bidInstance: bidInstance]
    }

    def update(Long id, Long version) {
        def bidInstance = Bid.get(id)
        if (!bidInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bid.label', default: 'Bid'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (bidInstance.version > version) {
                bidInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'bid.label', default: 'Bid')] as Object[],
                        "Another user has updated this Bid while you were editing")
                render(view: "edit", model: [bidInstance: bidInstance])
                return
            }
        }


        String gcd = params.gcd;
        Date date_gcd = TypeConversion.toDate(gcd);
        params.gcd = date_gcd;


        bidInstance.properties = params

        if (!bidInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, bidInstance.errors.allErrors);
            render(view: "edit", model: [bidInstance: bidInstance, errors: errors])
            return
        }

        def success = message(code: 'default.updated.message', args: [message(code: 'bid.label', default: 'Bid'), bidInstance.id])
        render(view: "edit", model: [success: success, isSaveOk: true, bidInstance: bidInstance])
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
        def bidInstanceList = Bid.findAllByIdInList(idList);
        if (bidInstanceList) {
            bidInstanceList.each {
                try {
                    it.delete(flush: true);
                    log.info("删除" + it + "成功");
                    flash.success += message(code: 'bid.label', default: 'Bid') + "[" + it.id + "]删除成功<br/>";
                }
                catch (Exception ex) {
                    log.info("删除" + it + "失败:" + ex.message);
                    flash.errors += message(code: 'bid.label', default: 'Bid') + "[" + it.id + "]删除失败<br/>";
                }
            }
        } else {
            flash.errors = message(code: 'default.not.found.message', args: [message(code: 'bid.label', default: 'Bid'), id])
        }
        params.remove("ids");
        redirect(action: "list", params: params);
    }

    def editBid() {
        println params
        def success = null;
        def errors = null;
        def bidInstance = null;
        if (params.id) {
            long id = Number.toLong(params.id);
            bidInstance = Bid.get(id)
            if (!bidInstance) {
                errors = "编号为${id}的${message(code: 'bid.label', default: 'Bid')}不存在";
                render(view: "edit", model: [errors: errors]);
                return;
            }
        } else {
            bidInstance = new Bid();
        }
        boolean isSaveOk = false;
        if (request.method == "POST") {

            String gcd = params.gcd;
            Date date_gcd = TypeConversion.toDate(gcd);
            params.gcd = date_gcd;

            bidInstance.properties = params;
            if (!bidInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, bidInstance.errors.allErrors);
                render(view: "edit", model: [bidInstance: bidInstance, errors: errors])
                return
            }
            success = message(code: 'default.updated.message', args: [message(code: 'bid.label', default: 'Bid'), bidInstance.id])
            isSaveOk = true;
        }
        render(view: "edit", model: [isSaveOk: isSaveOk, bidInstance: bidInstance, success: success, errors: errors]);
    }

}
