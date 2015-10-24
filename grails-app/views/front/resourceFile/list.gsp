<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-3-26
  Time: 上午12:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.lj.rmp.utils.FormatUtil;com.lj.tps.enumcustom.ResourceType;" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="front_main"/>
    %{--<script type="text/javascript" src="${resource(dir: "js", file: "jquery-1.8.1.min.js")}"></script>--}%
    %{--<link href="${resource(dir: "js/bui/css", file: "dpl-min.css")}" rel="stylesheet" type="text/css"/>--}%
    %{--<link href="${resource(dir: "js/bui/css", file: "bui-min.css")}" rel="stylesheet" type="text/css"/>--}%
    %{--<link href="${resource(dir: "js/bui/css", file: "page-min.css")}" rel="stylesheet" type="text/css"/>--}%
    <script type="text/javascript" src="${resource(dir: "js/bui", file: "bui-min.js")}"></script>
    %{--<script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>--}%
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/zx_info.css"/>
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


<div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>
<div class="container pb-15">
    <!-- Example row of columns -->
    <div class="row">

        <!--右侧代码-->
        <g:render template="/layouts/left_menu"/>


        <div class="span12">
            <!--内容页面-->
            <div class="label-div b-30 border-all pt-5 t-20" style="position: relative; padding-left: 0;display: table">
                %{--<div class="mmdh pull-left"><a href="">首页</a> > <a href="">投资机构</a> > <a href="">机构标题</a></div>--}%
                %{--<div class="mmkey pull-right"><b><a href="">关键字</a></b><b><a href="">关键字</a></b><b><a href="">关键字</a></b><div class="mmclear"></div></div>--}%
                <div class="mmclear"></div>
                <div style="margin-top: 14px;" class="clearfix pb-12 pl-25 pr-25">
                    <h1 class="pull-left r-10">资源文件列表</h1>
                    %{--<div class="pull-left pt-5 none-768" style="_margin-top:-33px; _margin-left:-10px;">--}%
                    %{--<span class="like-plug-gz clearfix pull-left r-15">--}%
                    %{--<a title="感兴趣，关注一下吧" href="javascript:void(0);" class="like-btn pull-right ie6png">关注本文</a>--}%
                    %{--<span class="count pull-left t-5 d-none"></span>--}%
                    %{--</span>--}%
                    %{--</div>--}%
                </div>

    <div id="msg" style="margin-left: 25px;">
        <g:render template="/layouts/msgs_and_errors"/>
    </div>

    <!--列表-->
    <div style="margin: 10px;">
        <div class="form-links">
            <ul class="nav-tabs">
                <li class="${(com.lj.rmp.utils.Number.toInteger(params.type)==0)?"active":""}"><a href="${createLink(controller: "tpsResourceFile",action: "list",params: [type:0])}">全部</a></li>
                <g:each in="${ResourceType.types}" var="resourceType">
                    <li class="${(com.lj.rmp.utils.Number.toInteger(params.type)==resourceType.code)?"active":""}"><a href="${createLink(controller: "tpsResourceFile",action: "list",params: [type:resourceType.code])}">${resourceType.label}</a></li>
                </g:each>
            </ul>
        </div>
        <g:if test="${resourceFileInfoList}">
            <div>
                <!--订单列表-->
                <table class="table table-striped table-bordered table-condensed" style="max-width: 910px;">
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

                        %{--<g:sortableColumn property="size"--}%
                                          %{--title="${message(code: 'resourceFileInfo.size.label', default: 'Size')}"--}%
                                          %{--params="${params}"/>--}%

                        %{--<g:sortableColumn property="uploadTime"--}%
                                          %{--title="${message(code: 'resourceFileInfo.uploadTime.label', default: 'UploadTime')}"--}%
                                          %{--params="${params}"/>--}%
                        <th>URL</th>
                        <th>文件预览</th>
                    </tr>
                    </thead>
                    <g:form name="form1" action="delete" params="${params}">
                        <tbody>
                        <g:each in="${resourceFileInfoList}" status="i" var="resourceFile">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="width: 30px;">
                                    <input type="checkbox" name="ids" value="${resourceFile.id}"/>
                                </td>
                                <td style="width: 30px;">${ResourceType.getLable(resourceFile.type)}</td>
                                %{--<td>${resourceFile.fileFullName}</td>--}%
                                <td style="width: 240px;word-wrap:break-word;word-break:break-all;">${resourceFile.fileName}</td>
                                %{--<td style="width: 60px;">${FormatUtil.byteToKB(resourceFile.size)}</td>--}%
                                %{--<td style="width: 60px;">${FormatUtil.dateTimeFormat(resourceFile.uploadTime)}</td>--}%
                                <td style="width: 360px;word-wrap:break-word;word-break:break-all;"><rmp:resourceFileUrl fileFullName="${resourceFile.fileFullName}"/></td>
                                <td style="width: 160px;"><tps:resourceFilePreview id="${resourceFile.id}"/></td>
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
            <div class="tips tips-large tips-info tips-no-icon" style="text-align: center;width: 875px;">
                <div class="tips-content">
                    <h2>还没有资源文件哦</h2>

                    <p class="auxiliary-text">
                        你可以：
                        <a class="page-action" href="${createLink(controller: "tpsResourceFile",action: "upload")}" data-href=""
                           title="上传资源文件" data-id="resource_upload_menu">去上传资源文件</a>
                        %{--<a class="direct-lnk" title="编辑用户个性化功能权限" href="${createLink(controller: "tpsResourceFile",action: "upload")}">去上传资源文件</a>--}%
                    </p>
                </div>
            </div>
        </g:else>
    </div>

            </div>
        </div>
    </div>
</div>



<!-- /container -->

<div class="container">

    <div class="hr"></div>

</div>


</body>
</html>