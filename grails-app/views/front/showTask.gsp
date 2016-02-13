<%@ page import="com.lj.tps.status.ContactWay; com.lj.tps.status.TaskStatus; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>${taskInstance.simpleDesc}</title>
    <link href="${resource(dir: 'css', file: 'Validform.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/kindeditor-4.1.10/themes/default', file: 'default.css')}" rel="stylesheet"
          type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "cxzx_list.css")}"/>
    <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10', file: 'kindeditor-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10/lang', file: 'zh_CN.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'Validform_v5.3.2_min.js')}"></script>
    <script type="text/javascript">
        BUI.use('common/page');

    </script>
</head>

<body>
<div style="margin: 10px;">
    <div id="msg">
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

<div class="container pb-15" id="container">
<div class="row">
<div class="span16">

<div class="clearfix pb-5" style=" position:relative;">
    <div class="pull-left classifyDIV pt-10">
        <a class="pull-left nosel">任务详情--${taskInstance?.simpleDesc}</a>
    </div>
</div>

<div class="clearfix pb-5" style=" position:relative;">
    <div class="pull-left classifyDIV">
        <g:if test="${canJoin}">
            <a href="${createLink(controller: 'front',action:'joinBid',params:[id:taskInstance.id])}" target="_self" class="type-button pull-left">
                参与竞标
            </a>
        </g:if>
        <div style="clear:both"></div>
        <span class="label label-success">要求完成日期：<g:formatDate date="${taskInstance.crcd}" format="yyyy-MM-dd"/></span>
        <g:if test="${isWin}">
            <span class="label label-success">联系方式：${taskInstance.contactInfo}</span>
        </g:if>
        <span class="label label-success">${TaskStatus.getLabel(taskInstance.status)}</span>
        <span class="label label-important">¥&nbsp;&nbsp;<g:formatNumber number="${taskInstance.price}" format="#.##" /></span>
    </div>
</div>

%{--${taskInstance?.detailDesc}--}%
<textarea name="taskArea">
    ${taskInstance?.detailDesc}
</textarea>

<script type="text/javascript">

    KindEditor.ready(function (K) {
        var editor=K.create('textarea[name="taskArea"]', {
            readonlyMode : true,
            allowFileManager: true,
            langType: 'zh_CN',
            items: [ ],
            width:$("#container").width()
        });

        var autoheight=editor.edit.doc.body.scrollHeight;
        editor.edit.setHeight(autoheight);

    });
</script>

<sec:ifLoggedIn>

<g:if test="${myBid}">

    <div class="clearfix pb-5" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <a class="pull-left  nosel">我的竞标</a>
        </div>
    </div>
    <div class="clearfix pb-5" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <span class="label label-success">保证完成日期：<g:formatDate date="${myBid.gcd}" format="yyyy-MM-dd"/></span>
            <g:if test="${myBid.status!=-1}">
                <span class="label label-success">${com.lj.tps.status.BidStatus.getLabel(myBid.status ?: -1)}</span>
            </g:if>
            <span class="label label-important">¥&nbsp;&nbsp;<g:formatNumber number="${myBid.price}" format="#.##" /></span>
        </div>
    </div>


    <textarea name="myBidArea">
        ${myBid.skillDesc ?: ""}
    </textarea>

    <script type="text/javascript">

        KindEditor.ready(function (K) {
            var editor=K.create('textarea[name="myBidArea"]', {
                readonlyMode : true,
                allowFileManager: true,
                langType: 'zh_CN',
                items: [ ],
                width: $("#container").width(),
                minHeight: "50px"
            });

            var autoheight=editor.edit.doc.body.scrollHeight;
            editor.edit.setHeight(autoheight);
        });
    </script>
</g:if>

</sec:ifLoggedIn>

<g:if test="${bidInstanceList && (myBid && bidInstanceList.size()>1 || (!myBid))}">
    <div class="clearfix pb-5" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <a class="pull-left  nosel">${null==myBid?"所有竞标":"其他竞标"}</a>
        </div>
    </div>
    <g:each in="${bidInstanceList}" status="i" var="curBid">
        <g:if test="${null==myBid || myBid.id.longValue()!=curBid.id.longValue()}">

            <div class="clearfix pb-5" style=" position:relative;">
                <div class="pull-left classifyDIV pt-5">
                    <a  class=" type-button pull-left" href="${createLink(controller:"front",action:'showEvaluation',params:[evaluatedPerson:curBid.username])}" target="_blank">查看评价</a>
                    <div style="clear:both"></div>
                    <span class="label label-success">竞标人：${curBid.username}</span>
                    <g:if test="${isSelfTask}">
                        <span class="label label-success">联系方式：${curBid.contactInfo}</span>
                    </g:if>
                    <span class="label label-success">保证完成日期：<g:formatDate date="${curBid.gcd}" format="yyyy-MM-dd"/></span>
                    <g:if test="${curBid.status!=-1}">
                        <span class="label label-success">${com.lj.tps.status.BidStatus.getLabel(curBid.status ?: -1)}</span>
                    </g:if>
                    <span class="label label-important">¥&nbsp;&nbsp;<g:formatNumber number="${curBid.price}" format="#.##" /></span>

                </div>
            </div>

            %{--${curBid.skillDesc ?: ""}--}%

            <textarea name="curBidArea_${i}">
                ${curBid.skillDesc ?: ""}
            </textarea>

            <script type="text/javascript">

                KindEditor.ready(function (K) {
                    var editor=K.create('textarea[name="curBidArea_${i}"]', {
                        readonlyMode : true,
                        allowFileManager: true,
                        langType: 'zh_CN',
                        items: [ ],
                        width: $("#container").width(),
                        minHeight:'50px'
                    });

                    var autoheight=editor.edit.doc.body.scrollHeight;
                    editor.edit.setHeight(autoheight);
                });
            </script>
        </g:if>
    </g:each>

    <div class="pagination pull-right">
        <rmp:paginateInBui action="showTask" total="${bidInstanceTotal}" prev="&larr;"
                           next="&rarr;"
                           params="${params}"/>
    </div>

</g:if>

</div>
</div>
</div>



%{--<g:render template="/layouts/comment_do_and_list"/>--}%
</body>
</html>
