<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-3-27
  Time: 下午11:44
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>flash预览</title>
</head>
<body style="margin: 0px;">
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
<g:if test="${urlStr}">
    <g:if test="${isSwf}">
        <EMBED id="flashId" src="${urlStr}"></EMBED>
    </g:if>
    <g:else>
        <g:if test="${isMp3}">
            <embed src="${resource(dir: "js",file: "audioplayer.swf")}?soundFile=${urlStr}"
                   quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer"
                   type="application/x-shockwave-flash" width="290" height="24">
            </embed>
        </g:if>
        <g:else>
        <embed
                src="${resource(dir: "js",file: "vcastr22.swf")}?vcastr_file=${urlStr}"
                quality="high"
                pluginspage="http://www.macromedia.com/go/getflashplayer"
                allowFullScreen="true"
                type="application/x-shockwave-flash" width="480" height="280">
        </embed>
        </g:else>
    </g:else>
</g:if>
</body>
</html>