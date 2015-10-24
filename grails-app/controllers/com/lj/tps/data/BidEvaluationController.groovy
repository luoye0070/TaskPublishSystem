package com.lj.tps.data

import org.springframework.dao.DataIntegrityViolationException

import com.lj.utils.I18nError
import com.lj.utils.Number
import com.lj.utils.TypeConversion

class BidEvaluationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def bidEvaluationInstance = new BidEvaluation(params)
        def conditions = {


            if (params.evaluationContent) {
                like("evaluationContent", "%" + params.evaluationContent + "%");
            }




            if (params.bidId) {
                long bidId = 0l;
                try {
                    bidId = Long.parseLong(params.bidId);
                } catch (Exception ex) {}
                if (bidId) {
                    eq("bidId", bidId);
                }
            }




            if (params.evaluationTimeBegin) {
                Date date = TypeConversion.toDateTime(params.evaluationTimeBegin);
                if (date) {
                    ge("evaluationTime", date);
                }
            }
            if (params.evaluationTimeEnd) {
                Date date = TypeConversion.toDateTime(params.evaluationTimeEnd);
                if (date) {
                    le("evaluationTime", date);
                }
            }




            if (params.taskId) {
                long taskId = 0l;
                try {
                    taskId = Long.parseLong(params.taskId);
                } catch (Exception ex) {}
                if (taskId) {
                    eq("taskId", taskId);
                }
            }




            if (params.valuer) {
                like("valuer", "%" + params.valuer + "%");
            }




            if (params.workAttitude) {
                float workAttitude = 0f;
                try {
                    workAttitude = Float.parseFloat(params.workAttitude);
                } catch (Exception ex) {}
                if (workAttitude) {
                    eq("workAttitude", workAttitude);
                }
            }




            if (params.workQuaity) {
                float workQuaity = 0f;
                try {
                    workQuaity = Float.parseFloat(params.workQuaity);
                } catch (Exception ex) {}
                if (workQuaity) {
                    eq("workQuaity", workQuaity);
                }
            }




            if (params.workSpeed) {
                float workSpeed = 0f;
                try {
                    workSpeed = Float.parseFloat(params.workSpeed);
                } catch (Exception ex) {}
                if (workSpeed) {
                    eq("workSpeed", workSpeed);
                }
            }


        }

        def bidEvaluationInstanceList = BidEvaluation.createCriteria().list(params, conditions);
        def totalCount = BidEvaluation.createCriteria().count(conditions);

        [bidEvaluationInstanceList: bidEvaluationInstanceList, bidEvaluationInstanceTotal: totalCount, bidEvaluationInstance: bidEvaluationInstance]

    }

    def create() {
        [bidEvaluationInstance: new BidEvaluation(params)]
    }

    def save() {

        String evaluationTime = params.evaluationTime;
        Date date_evaluationTime = TypeConversion.toDateTime(evaluationTime);
        params.evaluationTime = date_evaluationTime;

        def bidEvaluationInstance = new BidEvaluation(params)
        if (!bidEvaluationInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, bidEvaluationInstance.errors.allErrors);
            render(view: "create", model: [bidEvaluationInstance: bidEvaluationInstance, errors: errors])
            return
        }

        def success = message(code: 'default.created.message', args: [message(code: 'bidEvaluation.label', default: 'BidEvaluation'), bidEvaluationInstance.id])
        render(view: "create", model: [success: success, isSaveOk: true, bidEvaluationInstance: bidEvaluationInstance])
    }

    def show(Long id) {
        def bidEvaluationInstance = BidEvaluation.get(id)
        if (!bidEvaluationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bidEvaluation.label', default: 'BidEvaluation'), id])
            redirect(action: "list")
            return
        }

        [bidEvaluationInstance: bidEvaluationInstance]
    }

    def edit(Long id) {
        def bidEvaluationInstance = BidEvaluation.get(id)
        if (!bidEvaluationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bidEvaluation.label', default: 'BidEvaluation'), id])
            redirect(action: "list")
            return
        }

        [bidEvaluationInstance: bidEvaluationInstance]
    }

    def update(Long id, Long version) {
        def bidEvaluationInstance = BidEvaluation.get(id)
        if (!bidEvaluationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bidEvaluation.label', default: 'BidEvaluation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (bidEvaluationInstance.version > version) {
                bidEvaluationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'bidEvaluation.label', default: 'BidEvaluation')] as Object[],
                        "Another user has updated this BidEvaluation while you were editing")
                render(view: "edit", model: [bidEvaluationInstance: bidEvaluationInstance])
                return
            }
        }


        String evaluationTime = params.evaluationTime;
        Date date_evaluationTime = TypeConversion.toDateTime(evaluationTime);
        params.evaluationTime = date_evaluationTime;


        bidEvaluationInstance.properties = params

        if (!bidEvaluationInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, bidEvaluationInstance.errors.allErrors);
            render(view: "edit", model: [bidEvaluationInstance: bidEvaluationInstance, errors: errors])
            return
        }

        def success = message(code: 'default.updated.message', args: [message(code: 'bidEvaluation.label', default: 'BidEvaluation'), bidEvaluationInstance.id])
        render(view: "edit", model: [success: success, isSaveOk: true, bidEvaluationInstance: bidEvaluationInstance])
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
        def bidEvaluationInstanceList = BidEvaluation.findAllByIdInList(idList);
        if (bidEvaluationInstanceList) {
            bidEvaluationInstanceList.each {
                try {
                    it.delete(flush: true);
                    log.info("删除" + it + "成功");
                    flash.success += message(code: 'bidEvaluation.label', default: 'BidEvaluation') + "[" + it.id + "]删除成功<br/>";
                }
                catch (Exception ex) {
                    log.info("删除" + it + "失败:" + ex.message);
                    flash.errors += message(code: 'bidEvaluation.label', default: 'BidEvaluation') + "[" + it.id + "]删除失败<br/>";
                }
            }
        } else {
            flash.errors = message(code: 'default.not.found.message', args: [message(code: 'bidEvaluation.label', default: 'BidEvaluation'), id])
        }
        params.remove("ids");
        redirect(action: "list", params: params);
    }

    def editBidEvaluation() {
        def success = null;
        def errors = null;
        def bidEvaluationInstance = null;
        if (params.id) {
            long id = Number.toLong(params.id);
            bidEvaluationInstance = BidEvaluation.get(id)
            if (!bidEvaluationInstance) {
                errors = "编号为${id}的${message(code: 'bidEvaluation.label', default: 'BidEvaluation')}不存在";
                render(view: "edit", model: [errors: errors]);
                return;
            }
        } else {
            bidEvaluationInstance = new BidEvaluation();
        }
        boolean isSaveOk = false;
        if (request.method == "POST") {

            String evaluationTime = params.evaluationTime;
            Date date_evaluationTime = TypeConversion.toDateTime(evaluationTime);
            params.evaluationTime = date_evaluationTime;

            bidEvaluationInstance.properties = params;
            if (!bidEvaluationInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, bidEvaluationInstance.errors.allErrors);
                render(view: "edit", model: [bidEvaluationInstance: bidEvaluationInstance, errors: errors])
                return
            }
            success = message(code: 'default.updated.message', args: [message(code: 'bidEvaluation.label', default: 'BidEvaluation'), bidEvaluationInstance.id])
            isSaveOk = true;
        }
        render(view: "edit", model: [isSaveOk: isSaveOk, bidEvaluationInstance: bidEvaluationInstance, success: success, errors: errors]);
    }

}
