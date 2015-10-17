<%@ page import="com.lj.tps.status.TaskStatus; com.lj.tps.status.ContactWay; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
<head>
  <title>我的任务</title>
    <link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
    <script type="text/javascript">
        BUI.use('common/page');
    </script>
    <script type="text/javascript">
        $(function(){
            $("#allCheck").on("change",function(event){
                if($(this).attr("checked")){
                    //alert("checked");
                    $("input[name='ids']").attr("checked",true);
                }else{
                    //alert("unchecked");
                    $("input[name='ids']").attr("checked",false);
                }
            });
            $("#deleteBt").click(function(event){
                //alert("delete");
                for(i=0;i<$("input[name='ids']").length;i++){
                    if($($("input[name='ids']")[i]).attr("checked")){
                        if(confirm("确定要删除吗？")){
                            $("#form1").submit();
                        }
                        return;
                    }
                }
                alert("请选择要删除的内容！");
            });
        });
        $(function(){
            var timeOut=setTimeout(function(){
                $("#msg").hide(1000);
            },10000);
        });
    </script>
</head>

<body>
<div id="list-task" class="content scaffold-list" role="main">

<!--消息-->
<div style="margin: 10px;">
    <div id="msg">
    %{--<g:render template="/layouts/msgs_and_errors"/>--}%
        <g:if test="${errors || flash.errors}">
            <div class="tips tips-small tips-warning">
                <span class="x-icon x-icon-small x-icon-error"><i class="icon icon-white icon-warning"></i></span>

                <div class="tips-content">${errors}${flash.errors}</div>
            </div>
        </g:if>
        <g:if test="${msgs || flash.msgs}">
            <div class="tips tips-small tips-info">
                <span class="x-icon x-icon-small x-icon-info"><i class="icon icon-white icon-info"></i></span>

                <div class="tips-content">${msgs}${flash.msgs}</div>
            </div>
        </g:if>
        <g:if test="${warnings || flash.warnings}">
            <div class="tips tips-small tips-warning">
                <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-bell"></i></span>
                <div class="tips-content">${flash.warnings}${warnings}</div>
            </div>
        </g:if>
        <g:if test="${success || flash.success}">
            <div class="tips tips-small  tips-success">
                <span class="x-icon x-icon-small x-icon-success"><i class="icon icon-white icon-ok"></i></span>
                <div class="tips-content">${flash.success}${success}</div>
            </div>
        </g:if>
        <g:if test="${question || flash.question}">
            <div class="tips tips-small">
                <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-question"></i></span>
                <div class="tips-content">${flash.question}${question}</div>
            </div>
        </g:if>
    </div>
</div>
<!--搜索条件-->
<div>
    <g:form name="searchForm" action="myTask" class="form-horizontal">

        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'task.simpleDesc.label', default: 'Simple Desc')}：</label>
                <div class="controls control-row-auto">

                    <g:textField name="simpleDesc" maxlength="150" required="" value="${taskInstance?.simpleDesc}"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label">${message(code: 'task.detailDesc.label', default: 'Detail Desc')}：</label>
                <div class="controls control-row-auto">

                    <g:textArea name="detailDesc" cols="40" rows="5" maxlength="10240" required="" value="${taskInstance?.detailDesc}"/>

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'task.price.label', default: 'Price')}：</label>
                <div class="controls control-row-auto">

                    <g:textField name="price" value="${fieldValue(bean: taskInstance, field: 'price')}" required=""/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label">${message(code: 'task.crcd.label', default: 'Crcd')}：</label>
                <div class="controls control-row-auto">

                    <g:textField name="crcdBegin" value="${params?.crcdBegin}"/>
                    <!-- script start -->
                    <script type="text/javascript">
                        BUI.use('bui/calendar',function(Calendar){
                            var datepicker = new Calendar.DatePicker({
                                trigger:'#crcdBegin',
                                showTime:true,
                                autoRender : true
                            });
                        });
                    </script>
                    <!-- script end -->
                    -
                    <g:textField name="crcdEnd" value="${params?.crcdEnd}"/>
                    <!-- script start -->
                    <script type="text/javascript">
                        BUI.use('bui/calendar',function(Calendar){
                            var datepicker = new Calendar.DatePicker({
                                trigger:'#crcdEnd',
                                showTime:true,
                                autoRender : true
                            });
                        });
                    </script>
                    <!-- script end -->

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'task.contactWay.label', default: 'Contact Way')}：</label>
                <div class="controls control-row-auto">

                    <g:select name="contactWay" from="${ContactWay.getOptions()}" required="" optionKey="code" optionValue="label"
                              value="${fieldValue(bean: taskInstance, field: 'contactWay')}" valueMessagePrefix="task.contactWay"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label">${message(code: 'task.contactInfo.label', default: 'Contact Info')}：</label>
                <div class="controls control-row-auto">

                    <g:textField name="contactInfo" required="" value="${taskInstance?.contactInfo}"/>

                </div>
            </div>

        </div>



        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'task.status.label', default: 'Status')}：</label>
                <div class="controls control-row-auto">

                    <g:select name="status" from="${TaskStatus.getOptions()}" required="" optionKey="code" optionValue="label" value="${fieldValue(bean: taskInstance, field: 'status')}" valueMessagePrefix="task.status"/>

                </div>
            </div>

        </div>

        <div class="row form-actions actions-bar">
            <div class="span13 offset3 ">
                <button type="submit" class="button button-primary">
                    ${message(code: 'default.button.search.label', default: 'Search')}
                </button>
            </div>
        </div>
    </g:form>
</div>
<!--列表-->
<div style="margin: 10px;">
    <g:if test="${taskInstanceList}">
        <div>
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <g:sortableColumn property="id" title=" "
                                      params="${params}"/>

                    <g:sortableColumn property="simpleDesc"
                                      title="${message(code: 'task.simpleDesc.label', default: 'Simple Desc')}" params="${params}"/>



                    <g:sortableColumn property="price"
                                      title="${message(code: 'task.price.label', default: 'Price')}" params="${params}"/>

                    <g:sortableColumn property="crcd"
                                      title="${message(code: 'task.crcd.label', default: 'Crcd')}" params="${params}"/>


                    <g:sortableColumn property="contactInfo"
                                      title="${message(code: 'task.contactInfo.label', default: 'Contact Info')}" params="${params}"/>


                    <g:sortableColumn property="status"
                                      title="${message(code: 'task.status.label', default: 'Status')}" params="${params}"/>

                    <th>操作</th>
                </tr>
                </thead>
                <g:form name="form1" action="delete" params="${params}">
                    <tbody>
                    <g:each in="${taskInstanceList}" status="i" var="taskInstance">
                        <tr>
                            <td>
                                <input type="checkbox" name="ids" value="${taskInstance.id}"/>
                            </td>


                            <td>${taskInstance.detailDesc?:""}</td>

                            <td>${fieldValue(bean: taskInstance, field: "price")}</td>

                            <td><g:formatDate date="${taskInstance.crcd}"/></td>


                            <td>${fieldValue(bean: taskInstance, field: "contactInfo")}</td>

                            <td>${com.lj.tps.status.TaskStatus.getLabel(taskInstance.status)}</td>

                            <td>
                                <a class="page-action" href="${createLink(action: "showMyTask",params: [id:taskInstance.id])}" target="_blank">查看</a>
                                <g:if test="${taskInstance.status==com.lj.tps.status.TaskStatus.TASK_INIT.code}">
                                    <a class="page-action" href="${createLink(action: "editTask",params: [id:taskInstance.id])}" target="_self">编辑</a>
                                    <a class="page-action" href="${createLink(action: "showMyTask",params: [id:taskInstance.id,handler:'startBid'])}" target="_self">开始竞标</a>

                                </g:if>
                                <g:if  test="${taskInstance.status in [com.lj.tps.status.TaskStatus.TASK_INIT.code,
                                        com.lj.tps.status.TaskStatus.TASK_BIDING.code
                                ]}">
                                    <a class="page-action" href="${createLink(action: "showMyTask",params: [id:taskInstance.id,handler:'cancelTask'])}" >取消任务</a>
                                </g:if>
                                <g:if  test="${taskInstance.status ==com.lj.tps.status.TaskStatus.TASK_BIDED.code}">
                                    <a id="cancelTask" class="page-action" href="${createLink(action: "showMyTask",params: [id:taskInstance.id,handler:'taskSuccess'])}" onclick="taskSuccess(${taskInstance.id});">任务成功</a>
                                    <a id="cancelTask" class="page-action" href="${createLink(action: "showMyTask",params: [id:taskInstance.id,handler:'taskFailure'])}" onclick="taskFailure(${taskInstance.id});">任务失败</a>
                                </g:if>
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
                    <rmp:paginateInBui action="myTask" total="${taskInstanceTotal}" prev="&larr;"
                                      next="&rarr;"
                                      params="${params}"/>
                </div>
            </div>
        </div>
    </g:if>
    <g:else>
        <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
            <div class="tips-content">
                <h2>没有找到【${message(code: 'task.label', default: 'Task')}】哦</h2>
            </div>
        </div>
    </g:else>

</div>
</div>
</body>
</html>