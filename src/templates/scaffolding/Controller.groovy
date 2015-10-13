<%=packageName ? "package ${packageName}\n\n" : ''%>import org.springframework.dao.DataIntegrityViolationException
<% import grails.persistence.Event %>
import com.lj.utils.I18nError
import com.lj.utils.Number
import com.lj.utils.TypeConversion

class ${className}Controller {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def ${propertyName} = new ${className}(params)
        def conditions={
            <%
            excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
            persistentPropNames = domainClass.persistentProperties*.name
            boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate')
            if (hasHibernate && org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder.getMapping(domainClass)?.identity?.generator == 'assigned') {
                persistentPropNames << domainClass.identifier.name
            }
            props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
            props = domainClass.properties.findAll { persistentPropNames.contains(it.name)}
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            props.eachWithIndex { p, i ->
            %>
                <%if (p.embedded) {%>
                    String ${p.name}=params.get("${p.name}.id");
                    if (${p.name}) {
                        long ${p.name}_l=TypeConversion.toLong(${p.name});
                        if(${p.name}_l)
                        eq("${p.name}.id",${p.name}_l);
                    }
                <%} else { %>
                    <%if(p.type==String){ %>
                        if (params.${p.name}) {
                            like("${p.name}","%"+params.${p.name}+"%");
                        }
                        <%}else if(p.type==int||p.type==Integer){%>
                        if(params.${p.name}){
                            int ${p.name}=0;
                            try{
                                ${p.name}=Integer.parseInt(params.${p.name});
                            }catch (Exception ex){}
                            if(${p.name}){
                                eq("${p.name}",${p.name});
                            }
                        }
                        <%}else if(p.type==Date){%>
                        if(params.${p.name}Begin){
                            Date date=TypeConversion.toDateTime(params.${p.name}Begin);
                            if(date){
                                ge("${p.name}",date);
                            }
                        }
                        if(params.${p.name}End){
                            Date date=TypeConversion.toDateTime(params.${p.name}End);
                            if(date){
                                le("${p.name}",date);
                            }
                        }
                        <%}else if(p.type==double||p.type==Double){%>
                        if(params.${p.name}){
                            double ${p.name}=0d;
                            try{
                                ${p.name}=Double.parseDouble(params.${p.name});
                            }catch (Exception ex){}
                            if(${p.name}){
                                eq("${p.name}",${p.name});
                            }
                        }
                        <%}else if(p.type==float||p.type==Float){%>
                        if(params.${p.name}){
                            float ${p.name}=0f;
                            try{
                                ${p.name}=Float.parseFloat(params.${p.name});
                            }catch (Exception ex){}
                            if(${p.name}){
                                eq("${p.name}",${p.name});
                            }
                        }
                        <%}else if(p.type==short||p.type==Short){%>
                        if(params.${p.name}){
                            short ${p.name}=0;
                            try{
                                ${p.name}=Short.parseShort(params.${p.name});
                            }catch (Exception ex){}
                            if(${p.name}){
                                eq("${p.name}",${p.name});
                            }
                        }
                        <%}else if(p.type==byte||p.type==Byte){%>
                        if(params.${p.name}){
                            byte ${p.name}=0;
                            try{
                                ${p.name}=Byte.parseByte(params.${p.name});
                            }catch (Exception ex){}
                            if(${p.name}){
                                eq("${p.name}",${p.name});
                            }
                        }
                        <%}else if(p.type==long||p.type==Long){%>
                        if(params.${p.name}){
                            long ${p.name}=0l;
                            try{
                                ${p.name}=Long.parseLong(params.${p.name});
                            }catch (Exception ex){}
                            if(${p.name}){
                                eq("${p.name}",${p.name});
                            }
                        }
                        <%}else if(p.type==char||p.type==Character){%>
                        if(params.${p.name}){
                            char ${p.name}=0;
                            try{
                                ${p.name}=params.${p.name}.toCharacter()[0];
                            }catch (Exception ex){}
                            if(${p.name}){
                                eq("${p.name}",${p.name});
                            }
                        }
                        <%}else if (p.type == Boolean || p.type == boolean) {%>
                            if(params.${p.name}){
                                boolean ${p.name}=true;
                                boolean isNotNull=true;
                                try{
                                    ${p.name}=TypeConversion.toBoolean(params.${p.name});
                                }catch (Exception ex){
                                    isNotNull=false;
                                }
                                if(isNotNull){
                                    eq("${p.name}",${p.name});
                                }
                            }
                        <%}else if (p.manyToOne || p.oneToOne){
                        if(p.referencedDomainClass){%>
                            String ${p.name}=params.get("${p.name}.id");
                            if (${p.name}) {
                                long ${p.name}_l=TypeConversion.toLong(${p.name});
                                if(${p.name}_l)
                                eq("${p.name}.id",${p.name}_l);
                            }
                        <%}}%>
                <%}
            }%>
        }

        def ${propertyName}List = ${className}.createCriteria().list(params, conditions);
        def totalCount = ${className}.createCriteria().count(conditions);

        [${propertyName}List: ${propertyName}List, ${propertyName}Total: totalCount,${propertyName}: ${propertyName}]

    }

    def create() {
        [${propertyName}: new ${className}(params)]
    }

    def save() {
        <%props.eachWithIndex { p, i ->
            if(p.type==Date){%>
                String ${p.name}=params.${p.name};
                Date date_${p.name}=TypeConversion.toDateTime(${p.name});
                params.${p.name}=date_${p.name};
        <%}}%>
        def ${propertyName} = new ${className}(params)
        if (!${propertyName}.save(flush: true)) {
            def errors = I18nError.getMessage(g, ${propertyName}.errors.allErrors);
            render(view: "create", model: [${propertyName}: ${propertyName},errors:errors])
            return
        }

        def success = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        render(view: "create", model: [success:success,isSaveOk:true,${propertyName}: ${propertyName}])
    }

    def show(Long id) {
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
            return
        }

        [${propertyName}: ${propertyName}]
    }

    def edit(Long id) {
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
            return
        }

        [${propertyName}: ${propertyName}]
    }

    def update(Long id, Long version) {
        def ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (${propertyName}.version > version) {<% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
                ${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[],
                          "Another user has updated this ${className} while you were editing")
                render(view: "edit", model: [${propertyName}: ${propertyName}])
                return
            }
        }

        <%props.eachWithIndex { p, i ->
            if(p.type==Date){%>
                String ${p.name}=params.${p.name};
                Date date_${p.name}=TypeConversion.toDateTime(${p.name});
                params.${p.name}=date_${p.name};
        <%}}%>

        ${propertyName}.properties = params

        if (!${propertyName}.save(flush: true)) {
            def errors = I18nError.getMessage(g, ${propertyName}.errors.allErrors);
            render(view: "edit", model: [${propertyName}: ${propertyName},errors:errors])
            return
        }

        def success = message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        render(view: "edit", model: [success:success,isSaveOk:true,${propertyName}: ${propertyName}])
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
        def ${propertyName}List = ${className}.findAllByIdInList(idList);
        if (${propertyName}List) {
            ${propertyName}List.each {
                try{
                    it.delete(flush: true);
                    log.info("删除" + it + "成功");
                    flash.success += message(code: '${domainClass.propertyName}.label', default: '${className}')+"[" + it.id + "]删除成功<br/>";
                }
                catch(Exception ex) {
                    log.info("删除" + it + "失败:"+ex.message);
                    flash.errors += message(code: '${domainClass.propertyName}.label', default: '${className}')+"[" + it.id + "]删除失败<br/>";
                }
            }
        } else {
            flash.errors =  message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
        }
        params.remove("ids");
        redirect(action: "list", params: params);
    }

    def edit${className}() {
        def success = null;
        def errors = null;
        def ${propertyName} = null;
        if (params.id) {
            long id = Number.toLong(params.id);
            ${propertyName} = ${className}.get(id)
            if (!${propertyName}){
                errors ="编号为\${id}的\${message(code: '${domainClass.propertyName}.label', default: '${className}')}不存在";
                render(view: "edit", model: [errors: errors]);
                return;
            }
        } else {
            ${propertyName} = new ${className}();
        }
        boolean isSaveOk=false;
        if (request.method == "POST") {
            <%props.eachWithIndex { p, i ->
                if(p.type==Date){%>
                    String ${p.name}=params.${p.name};
                    Date date_${p.name}=TypeConversion.toDateTime(${p.name});
                    params.${p.name}=date_${p.name};
            <%}}%>
            ${propertyName}.properties = params;
            if (!${propertyName}.save(flush: true)) {
                errors = I18nError.getMessage(g, ${propertyName}.errors.allErrors);
                render(view: "edit", model: [${propertyName}: ${propertyName},errors:errors])
                return
            }
            success = message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
            isSaveOk=true;
        }
        render(view: "edit", model: [isSaveOk:isSaveOk, ${propertyName}: ${propertyName}, success: success, errors: errors]);
    }

}
