<%@ page import="com.lj.tps.status.BidStatus; com.lj.tps.status.TaskStatus; com.lj.tps.data.Bid" %>
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

<!--列表-->
<div style="margin: 10px;">
    <g:if test="${bidInstanceList}">
        <div>
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <g:sortableColumn property="id" title="${message(code: 'bid.id.label', default: 'id')}"
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



                            <td>${fieldValue(bean: bidInstance, field: "contactInfo")}</td>

                            <td>${fieldValue(bean: bidInstance, field: "skillDesc")}</td>

                            <td>${fieldValue(bean: bidInstance, field: "price")}</td>

                            <td><g:formatDate date="${bidInstance.gcd}"/></td>

                            <td>${fieldValue(bean: bidInstance, field: "username")}</td>

                            <td>${bidInstance.task?.simpleDesc}</td>

                            <td>${BidStatus.getLabel(bidInstance.status)}</td>

                            <td>
                                <a class="page-action" href="${createLink(action: "showMyTask", params: [id:bidInstance.task?.id])}">查看</a>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </g:form>
            </table>

        </div>
    </g:if>
    <g:else>
        <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
            <div class="tips-content">
                <h2>没有找到【${message(code: 'bid.label', default: 'Bid')}】哦</h2>

            </div>
        </div>
    </g:else>
</div>
</div>
</body>
</html>
