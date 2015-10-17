package com.lj.tps.data

import org.springframework.dao.DataIntegrityViolationException

import com.lj.utils.I18nError
import com.lj.utils.Number
import com.lj.utils.TypeConversion

class TpsUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def tpsUserInstance = new TpsUser(params)
        def conditions = {


            if (params.username) {
                like("username", "%" + params.username + "%");
            }




            if (params.password) {
                like("password", "%" + params.password + "%");
            }




            if (params.realName) {
                like("realName", "%" + params.realName + "%");
            }




            if (params.IDNumber) {
                like("IDNumber", "%" + params.IDNumber + "%");
            }




            if (params.mobileNumber) {
                like("mobileNumber", "%" + params.mobileNumber + "%");
            }




            if (params.unitName) {
                like("unitName", "%" + params.unitName + "%");
            }




            if (params.accountExpired) {
                boolean accountExpired = true;
                boolean isNotNull = true;
                try {
                    accountExpired = TypeConversion.toBoolean(params.accountExpired);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("accountExpired", accountExpired);
                }
            }




            if (params.accountLocked) {
                boolean accountLocked = true;
                boolean isNotNull = true;
                try {
                    accountLocked = TypeConversion.toBoolean(params.accountLocked);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("accountLocked", accountLocked);
                }
            }




            if (params.enabled) {
                boolean enabled = true;
                boolean isNotNull = true;
                try {
                    enabled = TypeConversion.toBoolean(params.enabled);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("enabled", enabled);
                }
            }




            if (params.passwordExpired) {
                boolean passwordExpired = true;
                boolean isNotNull = true;
                try {
                    passwordExpired = TypeConversion.toBoolean(params.passwordExpired);
                } catch (Exception ex) {
                    isNotNull = false;
                }
                if (isNotNull) {
                    eq("passwordExpired", passwordExpired);
                }
            }


        }

        def tpsUserInstanceList = TpsUser.createCriteria().list(params, conditions);
        def totalCount = TpsUser.createCriteria().count(conditions);

        [tpsUserInstanceList: tpsUserInstanceList, tpsUserInstanceTotal: totalCount, tpsUserInstance: tpsUserInstance]

    }

    def create() {
        [tpsUserInstance: new TpsUser(params)]
    }

    def save() {

        def tpsUserInstance = new TpsUser(params)
        if (!tpsUserInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, tpsUserInstance.errors.allErrors);
            render(view: "create", model: [tpsUserInstance: tpsUserInstance, errors: errors])
            return
        }

        def success = message(code: 'default.created.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), tpsUserInstance.id])
        render(view: "create", model: [success: success, isSaveOk: true, tpsUserInstance: tpsUserInstance])
    }

    def show(Long id) {
        def tpsUserInstance = TpsUser.get(id)
        if (!tpsUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), id])
            redirect(action: "list")
            return
        }

        [tpsUserInstance: tpsUserInstance]
    }

    def edit(Long id) {
        def tpsUserInstance = TpsUser.get(id)
        if (!tpsUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), id])
            redirect(action: "list")
            return
        }

        [tpsUserInstance: tpsUserInstance]
    }

    def update(Long id, Long version) {
        def tpsUserInstance = TpsUser.get(id)
        if (!tpsUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tpsUserInstance.version > version) {
                tpsUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'tpsUser.label', default: 'TpsUser')] as Object[],
                        "Another user has updated this TpsUser while you were editing")
                render(view: "edit", model: [tpsUserInstance: tpsUserInstance])
                return
            }
        }



        tpsUserInstance.properties = params

        if (!tpsUserInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, tpsUserInstance.errors.allErrors);
            render(view: "edit", model: [tpsUserInstance: tpsUserInstance, errors: errors])
            return
        }

        def success = message(code: 'default.updated.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), tpsUserInstance.id])
        render(view: "edit", model: [success: success, isSaveOk: true, tpsUserInstance: tpsUserInstance])
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
        def tpsUserInstanceList = TpsUser.findAllByIdInList(idList);
        if (tpsUserInstanceList) {
            tpsUserInstanceList.each {
                try {
                    it.delete(flush: true);
                    log.info("删除" + it + "成功");
                    flash.success += message(code: 'tpsUser.label', default: 'TpsUser') + "[" + it.id + "]删除成功<br/>";
                }
                catch (Exception ex) {
                    log.info("删除" + it + "失败:" + ex.message);
                    flash.errors += message(code: 'tpsUser.label', default: 'TpsUser') + "[" + it.id + "]删除失败<br/>";
                }
            }
        } else {
            flash.errors = message(code: 'default.not.found.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), id])
        }
        params.remove("ids");
        redirect(action: "list", params: params);
    }

    def editTpsUser() {
        def success = null;
        def errors = null;
        def tpsUserInstance = null;
        if (params.id) {
            long id = Number.toLong(params.id);
            tpsUserInstance = TpsUser.get(id)
            if (!tpsUserInstance) {
                errors = "编号为${id}的${message(code: 'tpsUser.label', default: 'TpsUser')}不存在";
                render(view: "edit", model: [errors: errors]);
                return;
            }
        } else {
            tpsUserInstance = new TpsUser();
        }
        boolean isSaveOk = false;
        if (request.method == "POST") {

            tpsUserInstance.properties = params;
            if (!tpsUserInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, tpsUserInstance.errors.allErrors);
                render(view: "edit", model: [tpsUserInstance: tpsUserInstance, errors: errors])
                return
            }
            success = message(code: 'default.updated.message', args: [message(code: 'tpsUser.label', default: 'TpsUser'), tpsUserInstance.id])
            isSaveOk = true;
        }
        render(view: "edit", model: [isSaveOk: isSaveOk, tpsUserInstance: tpsUserInstance, success: success, errors: errors]);
    }

}
