<%@ page import="com.lj.tps.data.Bid" %>
<!DOCTYPE html>
<html>
<head>
    <g:set var="entityName" value="${message(code: 'bid.label', default: 'Bid')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
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
        $(function () {
            $("#allCheck").on("change", function (event) {
                if ($(this).attr("checked")) {
                    //alert("checked");
                    $("input[name='ids']").attr("checked", true);
                } else {
                    //alert("unchecked");
                    $("input[name='ids']").attr("checked", false);
                }
            });
            $("#deleteBt").click(function (event) {
                //alert("delete");
                for (i = 0; i < $("input[name='ids']").length; i++) {
                    if ($($("input[name='ids']")[i]).attr("checked")) {
                        if (confirm("确定要删除吗？")) {
                            $("#form1").submit();
                        }
                        return;
                    }
                }
                alert("请选择要删除的内容！");
            });
        });
        $(function () {
            var timeOut = setTimeout(function () {
                $("#msg").hide(1000);
            }, 10000);
        });
    </script>
</head>

<body>
<div id="list-bid" class="content scaffold-list" role="main">

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
    <g:form name="searchForm" action="list" class="form-horizontal">

        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.contactWay.label', default: 'Contact Way')}：</label>

                <div class="controls control-row-auto">

                    <g:select name="contactWay" from="${bidInstance.constraints.contactWay.inList}" required=""
                              value="${fieldValue(bean: bidInstance, field: 'contactWay')}"
                              valueMessagePrefix="bid.contactWay"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.contactInfo.label', default: 'Contact Info')}：</label>

                <div class="controls control-row-auto">

                    <g:textField name="contactInfo" required="" value="${bidInstance?.contactInfo}"/>

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.skillDesc.label', default: 'Skill Desc')}：</label>

                <div class="controls control-row-auto">

                    <g:textArea name="skillDesc" cols="40" rows="5" maxlength="10240" required=""
                                value="${bidInstance?.skillDesc}"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.price.label', default: 'Price')}：</label>

                <div class="controls control-row-auto">

                    <g:field name="price" value="${fieldValue(bean: bidInstance, field: 'price')}" required=""/>

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.gcd.label', default: 'Gcd')}：</label>

                <div class="controls control-row-auto">

                    <g:textField name="gcdBegin" value="${params?.gcdBegin}"/>
                    <!-- script start -->
                    <script type="text/javascript">
                        BUI.use('bui/calendar', function (Calendar) {
                            var datepicker = new Calendar.DatePicker({
                                trigger: '#gcdBegin',
                                showTime: true,
                                autoRender: true
                            });
                        });
                    </script>
                    <!-- script end -->
                    -
                    <g:textField name="gcdEnd" value="${params?.gcdEnd}"/>
                    <!-- script start -->
                    <script type="text/javascript">
                        BUI.use('bui/calendar', function (Calendar) {
                            var datepicker = new Calendar.DatePicker({
                                trigger: '#gcdEnd',
                                showTime: true,
                                autoRender: true
                            });
                        });
                    </script>
                    <!-- script end -->

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.username.label', default: 'Username')}：</label>

                <div class="controls control-row-auto">

                    <g:textField name="username" required="" value="${bidInstance?.username}"/>

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.task.label', default: 'Task')}：</label>

                <div class="controls control-row-auto">

                    <g:select id="task" name="task.id" from="${com.lj.tps.data.Task.list()}" optionKey="id"
                              value="${bidInstance?.task?.id}" class="many-to-one" noSelection="['null': '']"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label">${message(code: 'bid.status.label', default: 'Status')}：</label>

                <div class="controls control-row-auto">

                    <g:select name="status" from="${bidInstance.constraints.status.inList}" required=""
                              value="${fieldValue(bean: bidInstance, field: 'status')}"
                              valueMessagePrefix="bid.status"/>

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
    <g:if test="${bidInstanceList}">
        <div>
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <g:sortableColumn property="id" title="${message(code: 'bid.id.label', default: 'id')}"
                                      params="${params}"/>

                    <g:sortableColumn property="contactWay"
                                      title="${message(code: 'bid.contactWay.label', default: 'Contact Way')}"
                                      params="${params}"/>

                    <g:sortableColumn property="contactInfo"
                                      title="${message(code: 'bid.contactInfo.label', default: 'Contact Info')}"
                                      params="${params}"/>

                    <g:sortableColumn property="skillDesc"
                                      title="${message(code: 'bid.skillDesc.label', default: 'Skill Desc')}"
                                      params="${params}"/>

                    <g:sortableColumn property="price"
                                      title="${message(code: 'bid.price.label', default: 'Price')}" params="${params}"/>

                    <g:sortableColumn property="gcd"
                                      title="${message(code: 'bid.gcd.label', default: 'Gcd')}" params="${params}"/>

                    <g:sortableColumn property="username"
                                      title="${message(code: 'bid.username.label', default: 'Username')}"
                                      params="${params}"/>

                    <th><g:message code="bid.task.label"
                                   default="Task"/></th>

                    <g:sortableColumn property="status"
                                      title="${message(code: 'bid.status.label', default: 'Status')}"
                                      params="${params}"/>

                    <th>操作</th>
                </tr>
                </thead>
                <g:form name="form1" action="delete" params="${params}">
                    <tbody>
                    <g:each in="${bidInstanceList}" status="i" var="bidInstance">
                        <tr>
                            <td>
                                <input type="checkbox" name="ids" value="${bidInstance.id}"/>&nbsp;${bidInstance.id}
                            </td>

                            <td>
                                <a class="page-action" href="${createLink(action: "show", params: [id: bidInstance.id])}#"
                                   data-href="${createLink(action: "show", params: [id: bidInstance.id])}"
                                   title="${message(code: 'bid.label', default: 'Bid')}详情-[${bidInstance.id}]"
                                   data-id="bid_show_menu${bidInstance.id}">
                                    ${fieldValue(bean: bidInstance, field: "contactWay")}</a>
                            </td>

                            <td>${fieldValue(bean: bidInstance, field: "contactInfo")}</td>

                            <td>${fieldValue(bean: bidInstance, field: "skillDesc")}</td>

                            <td>${fieldValue(bean: bidInstance, field: "price")}</td>

                            <td><g:formatDate date="${bidInstance.gcd}"/></td>

                            <td>${fieldValue(bean: bidInstance, field: "username")}</td>

                            <td>${fieldValue(bean: bidInstance, field: "task")}</td>

                            <td>${fieldValue(bean: bidInstance, field: "status")}</td>

                            <td>
                                <a class="page-action" href="${createLink(action: "editBid", params: [id: bidInstance.id])}"
                                   data-href="${createLink(action: "editBid", params: [id: bidInstance.id])}"
                                   title="${message(code: 'bid.label', default: 'Bid')}编辑-[${bidInstance.id}]"
                                   data-id="bid_edit_menu${bidInstance.id}">编辑</a>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </g:form>
            </table>

            <div>
                <ul class="toolbar pull-left">
                    <li><label class="checkbox"><input type="checkbox" id="allCheck"><a href="#">全选</a></label></li>
                    <li><button class="button button-danger" id="deleteBt"><i class="icon-white icon-trash"></i>批量删除
                    </button></li>
                </ul>

                <div class="pagination pull-right">
                    <!--分页-->
                    <lj:paginateInBui action="list" total="${bidInstanceTotal}" prev="&larr;"
                                      next="&rarr;"
                                      params="${params}"/>
                </div>
            </div>
        </div>
    </g:if>
    <g:else>
        <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
            <div class="tips-content">
                <h2>没有找到【${message(code: 'bid.label', default: 'Bid')}】哦</h2>

                %{--<p class="auxiliary-text">--}%
                %{--你可以：--}%
                %{--<a class="page-action" href="#" data-href="${createLink(controller: "contentsManage",action: "editContentClass")}" title="添加内容类别" data-id="contentClass_add_menu">添加内容类别</a>--}%
                %{--<a class="direct-lnk" title="添加内容类别" href="${createLink(controller: "contentsManage",action: "editContentClass")}">添加内容类别</a>--}%
                %{--</p>--}%
            </div>
        </div>
    </g:else>
</div>
</div>
</body>
</html>
