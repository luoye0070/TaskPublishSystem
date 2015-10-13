<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-3-26
  Time: 上午12:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.lj.rmp.utils.FormatUtil;com.lj.rmp.enumcustom.ResourceType;" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script type="text/javascript" src="${resource(dir: "js", file: "jquery-1.8.1.min.js")}"></script>
    <link href="${resource(dir: "js/bui/css", file: "dpl-min.css")}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: "js/bui/css", file: "bui-min.css")}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: "js/bui/css", file: "page-min.css")}" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: "js/bui", file: "bui-min.js")}"></script>
    <script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
    <script type="text/javascript">
        BUI.use('common/page');
    </script>

    <title>资源列表</title>
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
                alert("请选择要删除的资源文件！");
            });
        });
    </script>
</head>

<body>
<!--消息-->
<div style="margin: 10px;">
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
<!--列表-->
<div style="margin: 10px;">
    <div class="form-links">
        <ul class="nav-tabs">
            <li class="${(com.lj.rmp.utils.Number.toInteger(params.type)==0)?"active":""}"><a href="${createLink(controller: "resourceFile",action: "list",params: [type:0])}">全部</a></li>
            <g:each in="${com.lj.rmp.enumcustom.ResourceType.types}" var="resourceType">
                <li class="${(com.lj.rmp.utils.Number.toInteger(params.type)==resourceType.code)?"active":""}"><a href="${createLink(controller: "resourceFile",action: "list",params: [type:resourceType.code])}">${resourceType.label}</a></li>
            </g:each>
        </ul>
    </div>
    <g:if test="${resourceFileInfoList}">
        <div>
            <!--订单列表-->
            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <tr>
                    <g:sortableColumn property="id" title="${message(code: 'resourceFileInfo.id.label', default: 'id')}"
                                      params="${params}"/>

                    <g:sortableColumn property="type"
                                      title="${message(code: 'resourceFileInfo.type.label', default: 'Type')}"
                                      params="${params}"/>

                    %{--<g:sortableColumn property="fileFullName"--}%
                                      %{--title="${message(code: 'resourceFileInfo.fileFullName.label', default: 'File Full Name')}"--}%
                                      %{--params="${params}"/>--}%

                    <g:sortableColumn property="fileName"
                                      title="${message(code: 'resourceFileInfo.fileName.label', default: 'File Name')}"
                                      params="${params}"/>

                    <g:sortableColumn property="size"
                                      title="${message(code: 'resourceFileInfo.size.label', default: 'Size')}"
                                      params="${params}"/>

                    <g:sortableColumn property="uploadTime"
                                      title="${message(code: 'resourceFileInfo.uploadTime.label', default: 'UploadTime')}"
                                      params="${params}"/>
                    <th>URL</th>
                    <th>文件预览</th>
                </tr>
                </thead>
                <g:form name="form1" action="delete" params="${params}">
                <tbody>
                <g:each in="${resourceFileInfoList}" status="i" var="resourceFile">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>
                            <input type="checkbox" name="ids" value="${resourceFile.id}"/>
                        </td>
                        <td>${ResourceType.getLable(resourceFile.type)}</td>
                        %{--<td>${resourceFile.fileFullName}</td>--}%
                        <td>${resourceFile.fileName}</td>
                        <td>${FormatUtil.byteToKB(resourceFile.size)}</td>
                        <td>${FormatUtil.dateTimeFormat(resourceFile.uploadTime)}</td>
                        <td><rmp:resourceFileUrl fileFullName="${resourceFile.fileFullName}"/></td>
                        <td><rmp:resourceFilePreview id="${resourceFile.id}"/></td>
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
                    <rmp:paginateInBui action="list" total="${totalCount ?: 0}" prev="&larr;" next="&rarr;"
                                      params="${params}"/>
                </div>
            </div>
        </div>
    </g:if>
    <g:else>
        <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
            <div class="tips-content">
                <h2>还没有资源文件哦</h2>

                <p class="auxiliary-text">
                    你可以：
                    <a class="page-action" href="#" data-href="${createLink(controller: "resourceFile",action: "upload")}"
                       title="上传资源文件" data-id="resource_upload_menu">去上传资源文件</a>
                    %{--<a class="direct-lnk" title="编辑用户个性化功能权限" href="${createLink(controller: "resourceFile",action: "upload")}">去上传资源文件</a>--}%
                </p>
            </div>
        </div>
    </g:else>
</div>
</body>
</html>