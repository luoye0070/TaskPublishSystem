<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
<head>
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <link href="\${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="\${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="\${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="\${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
    <script type="text/javascript" src="\${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript" src="\${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
    <script type="text/javascript">
        BUI.use('common/page');
    </script>
    <script type="text/javascript">
        \$(function(){
            \$("#allCheck").on("change",function(event){
                if(\$(this).attr("checked")){
                    //alert("checked");
                    \$("input[name='ids']").attr("checked",true);
                }else{
                    //alert("unchecked");
                    \$("input[name='ids']").attr("checked",false);
                }
            });
            \$("#deleteBt").click(function(event){
                //alert("delete");
                for(i=0;i<\$("input[name='ids']").length;i++){
                    if(\$(\$("input[name='ids']")[i]).attr("checked")){
                        if(confirm("确定要删除吗？")){
                            \$("#form1").submit();
                        }
                        return;
                    }
                }
                alert("请选择要删除的内容！");
            });
        });
        \$(function(){
            var timeOut=setTimeout(function(){
                \$("#msg").hide(1000);
            },10000);
        });
    </script>
</head>

<body>
<div id="list-${domainClass.propertyName}" class="content scaffold-list" role="main">

    <!--消息-->
    <div style="margin: 10px;">
    <div id="msg">
        %{--<g:render template="/layouts/msgs_and_errors"/>--}%
    <g:if test="\${errors || flash.errors}">
        <div class="tips tips-small tips-warning">
            <span class="x-icon x-icon-small x-icon-error"><i class="icon icon-white icon-warning"></i></span>

            <div class="tips-content">\${errors}\${flash.errors}</div>
        </div>
    </g:if>
    <g:if test="\${msgs || flash.msgs}">
        <div class="tips tips-small tips-info">
            <span class="x-icon x-icon-small x-icon-info"><i class="icon icon-white icon-info"></i></span>

            <div class="tips-content">\${msgs}\${flash.msgs}</div>
        </div>
    </g:if>
    <g:if test="\${warnings || flash.warnings}">
        <div class="tips tips-small tips-warning">
            <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-bell"></i></span>
            <div class="tips-content">\${flash.warnings}\${warnings}</div>
        </div>
    </g:if>
    <g:if test="\${success || flash.success}">
        <div class="tips tips-small  tips-success">
            <span class="x-icon x-icon-small x-icon-success"><i class="icon icon-white icon-ok"></i></span>
            <div class="tips-content">\${flash.success}\${success}</div>
        </div>
    </g:if>
    <g:if test="\${question || flash.question}">
        <div class="tips tips-small">
            <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-question"></i></span>
            <div class="tips-content">\${flash.question}\${question}</div>
        </div>
    </g:if>
        </div>
    </div>
    <!--搜索条件-->
    <div>
        <g:form name="searchForm" action="list" class="form-horizontal">
            <% excludedProps = Event.allEvents.toList() << 'id' << 'version'
            allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            props.eachWithIndex { p, i ->
                //if (i < 6) {
                    if (i%2==0) { %>
            <div class="row">
         <% }%>
                <div class="control-group span12">
                    <label class="control-label">\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}：</label>
                    <div class="controls control-row-auto">
                        <%if(p.type==Date){%>
                        <g:textField name="${p.name}Begin" value="\${params?.${p.name}Begin}"/>
                        <!-- script start -->
                        <script type="text/javascript">
                            BUI.use('bui/calendar',function(Calendar){
                                var datepicker = new Calendar.DatePicker({
                                    trigger:'#${p.name}Begin',
                                    showTime:true,
                                    autoRender : true
                                });
                            });
                        </script>
                        <!-- script end -->
                        -
                        <g:textField name="${p.name}End" value="\${params?.${p.name}End}"/>
                        <!-- script start -->
                        <script type="text/javascript">
                            BUI.use('bui/calendar',function(Calendar){
                                var datepicker = new Calendar.DatePicker({
                                    trigger:'#${p.name}End',
                                    showTime:true,
                                    autoRender : true
                                });
                            });
                        </script>
                        <!-- script end -->
                        <%}else{%>
                        ${renderEditor(p)}
                        <%}%>
                    </div>
                </div>
            <%if (i%2!=0||(i==props.size()-1)) { %>
            </div>
            <% }
            }%>
            <div class="row form-actions actions-bar">
                <div class="span13 offset3 ">
                    <button type="submit" class="button button-primary">
                        \${message(code: 'default.button.search.label', default: 'Search')}
                    </button>
                </div>
            </div>
        </g:form>
    </div>
    <!--列表-->
    <div style="margin: 10px;">
        <g:if test="\${${propertyName}List}">
            <div>
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <g:sortableColumn property="id" title="\${message(code: '${domainClass.propertyName}.id.label', default: 'id')}"
                                          params="\${params}"/>
                        <% excludedProps = Event.allEvents.toList() << 'id' << 'version'
                        allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.eachWithIndex { p, i ->
                            if (i < 16) {
                                if (p.isAssociation()) { %>
                        <th><g:message code="${domainClass.propertyName}.${p.name}.label"
                                       default="${p.naturalName}"/></th>
                        <% } else { %>
                        <g:sortableColumn property="${p.name}"
                                          title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" params="\${params}"/>
                        <% }
                        }
                        } %>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <g:form name="form1" action="delete" params="\${params}">
                    <tbody>
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                        <tr>
                            <td>
                                <input type="checkbox" name="ids" value="\${${propertyName}.id}"/>&nbsp;\${${propertyName}.id}
                            </td>
                            <% props.eachWithIndex { p, i ->
                                if (i == 0) { %>
                            <td>
                                <a class="page-action" href="#" data-href="\${createLink(action: "show",params: [id:${propertyName}.id])}"
                            title="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}详情-[\${${propertyName}.id}]" data-id="${domainClass.propertyName}_show_menu\${${propertyName}.id}">
                            \${fieldValue(bean: ${propertyName}, field: "${p.name}")}</a>
                            </td>
                            <% } else if (i < 16) {
                                if (p.type == Boolean || p.type == boolean) { %>
                            <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}"/></td>
                            <% } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                            <td><g:formatDate date="\${${propertyName}.${p.name}}"/></td>
                            <% } else { %>
                            <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                            <% }
                            }
                            } %>
                            <td>
                            <a class="page-action" href="#" data-href="\${createLink(action: "edit${className}",params: [id:${propertyName}.id])}"
                               title="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}编辑-[\${${propertyName}.id}]" data-id="${domainClass.propertyName}_edit_menu\${${propertyName}.id}">编辑</a>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                    </g:form>
                </table>

                <div>
                    <ul class="toolbar pull-left">
                        <li><label class="checkbox"><input type="checkbox" id="allCheck"><a href="#">全选</a></label></li>
                        <li><button class="button button-danger" id="deleteBt"><i class="icon-white icon-trash"></i>批量删除</button></li>
                    </ul>

                    <div class="pagination pull-right">
                        <!--分页-->
                        <lj:paginateInBui action="list" total="\${${propertyName}Total}" prev="&larr;"
                                          next="&rarr;"
                                          params="\${params}"/>
                    </div>
                </div>
            </div>
        </g:if>
        <g:else>
            <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
                <div class="tips-content">
                    <h2>没有找到【\${message(code: '${domainClass.propertyName}.label', default: '${className}')}】哦</h2>

                    %{--<p class="auxiliary-text">--}%
                    %{--你可以：--}%
                    %{--<a class="page-action" href="#" data-href="\${createLink(controller: "contentsManage",action: "editContentClass")}" title="添加内容类别" data-id="contentClass_add_menu">添加内容类别</a>--}%
                    %{--<a class="direct-lnk" title="添加内容类别" href="\${createLink(controller: "contentsManage",action: "editContentClass")}">添加内容类别</a>--}%
                    %{--</p>--}%
                </div>
            </div>
        </g:else>
    </div>
</div>
</body>
</html>
