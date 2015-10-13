package com.lj.tps.data

import org.springframework.dao.DataIntegrityViolationException

import com.lj.utils.I18nError
import com.lj.utils.Number
import com.lj.utils.TypeConversion

class TestDController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def testDInstance = new TestD(params)
        def conditions={
            
                
                    
                        if (params.name) {
                            like("name","%"+params.name+"%");
                        }
                        
                
                
                    
                        if(params.num){
                            int num=0;
                            try{
                                num=Integer.parseInt(params.num);
                            }catch (Exception ex){}
                            if(num){
                                eq("num",num);
                            }
                        }
                        
                
        }

        def testDInstanceList = TestD.createCriteria().list(params, conditions);
        def totalCount = TestD.createCriteria().count(conditions);

        [testDInstanceList: testDInstanceList, testDInstanceTotal: totalCount,testDInstance: testDInstance]

    }

    def create() {
        [testDInstance: new TestD(params)]
    }

    def save() {
        
        def testDInstance = new TestD(params)
        if (!testDInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, testDInstance.errors.allErrors);
            render(view: "create", model: [testDInstance: testDInstance,errors:errors])
            return
        }

        def success = message(code: 'default.created.message', args: [message(code: 'testD.label', default: 'TestD'), testDInstance.id])
        render(view: "create", model: [success:success,isSaveOk:true,testDInstance: testDInstance])
    }

    def show(Long id) {
        def testDInstance = TestD.get(id)
        if (!testDInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testD.label', default: 'TestD'), id])
            redirect(action: "list")
            return
        }

        [testDInstance: testDInstance]
    }

    def edit(Long id) {
        def testDInstance = TestD.get(id)
        if (!testDInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testD.label', default: 'TestD'), id])
            redirect(action: "list")
            return
        }

        [testDInstance: testDInstance]
    }

    def update(Long id, Long version) {
        def testDInstance = TestD.get(id)
        if (!testDInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testD.label', default: 'TestD'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (testDInstance.version > version) {
                testDInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'testD.label', default: 'TestD')] as Object[],
                          "Another user has updated this TestD while you were editing")
                render(view: "edit", model: [testDInstance: testDInstance])
                return
            }
        }

        

        testDInstance.properties = params

        if (!testDInstance.save(flush: true)) {
            def errors = I18nError.getMessage(g, testDInstance.errors.allErrors);
            render(view: "edit", model: [testDInstance: testDInstance,errors:errors])
            return
        }

        def success = message(code: 'default.updated.message', args: [message(code: 'testD.label', default: 'TestD'), testDInstance.id])
        render(view: "edit", model: [success:success,isSaveOk:true,testDInstance: testDInstance])
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
        flash.success="";
        flash.errors="";
        //查询出内容
        def testDInstanceList = TestD.findAllByIdInList(idList);
        if (testDInstanceList) {
            testDInstanceList.each {
                try{
                    it.delete(flush: true);
                    log.info("删除" + it + "成功");
                    flash.success += message(code: 'testD.label', default: 'TestD')+"[" + it.id + "]删除成功<br/>";
                }
                catch(Exception ex) {
                    log.info("删除" + it + "失败:"+ex.message);
                    flash.errors += message(code: 'testD.label', default: 'TestD')+"[" + it.id + "]删除失败<br/>";
                }
            }
        } else {
            flash.errors =  message(code: 'default.not.found.message', args: [message(code: 'testD.label', default: 'TestD'), id])
        }
        params.remove("ids");
        redirect(action: "list", params: params);
    }

    def editTestD() {
        def success = null;
        def errors = null;
        def testDInstance = null;
        if (params.id) {
            long id = Number.toLong(params.id);
            testDInstance = TestD.get(id)
            if (!testDInstance){
                errors ="编号为${id}的${message(code: 'testD.label', default: 'TestD')}不存在";
                render(view: "edit", model: [errors: errors]);
                return;
            }
        } else {
            testDInstance = new TestD();
        }
        boolean isSaveOk=false;
        if (request.method == "POST") {
            
            testDInstance.properties = params;
            if (!testDInstance.save(flush: true)) {
                errors = I18nError.getMessage(g, testDInstance.errors.allErrors);
                render(view: "edit", model: [testDInstance: testDInstance,errors:errors])
                return
            }
            success = message(code: 'default.updated.message', args: [message(code: 'testD.label', default: 'TestD'), testDInstance.id])
            isSaveOk=true;
        }
        render(view: "edit", model: [isSaveOk:isSaveOk, testDInstance: testDInstance, success: success, errors: errors]);
    }

}
