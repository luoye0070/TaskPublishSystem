<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-4-20
  Time: 上午1:12
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
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
    <title>上传资源文件</title>
    <script type="text/javascript">
        $(function(){
            $("#addFile").click(function(event){
                var htmlStr="<div>"+
                        "<input type=\"file\" name=\"upFile\"/>&nbsp;&nbsp;<input type=\"button\" onclick=\"del(this)\" value=\"删除\"/>"+
                        "<br/> <br/>"+
                        "</div>";
                $("#fileList").append(htmlStr);
            });
        });
        function del(obj){
            $(obj).parent().remove();
        }
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
<div style="margin: 10px;">
    <g:form action="upload" name="form1" method="post" enctype="multipart/form-data">
        <div id="fileList">
            <div>
                <input type="file" name="upFile"/>&nbsp;&nbsp;<input type="button" onclick="del(this)" value="删除"/>
                <br/> <br/>
            </div>
        </div>
        <input id="addFile" type="button" value="添加"/>&nbsp;&nbsp;<input type="submit" value="上传"/>
    </g:form>
</div>
</body>
</html>