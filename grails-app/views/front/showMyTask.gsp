
<%@ page import="com.lj.tps.status.TaskStatus; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
	<head>

		<title>${taskInstance?.simpleDesc?:"任务详情"}</title>
        <meta name="layout" content="front_main"/>

        <link href="${resource(dir: 'css', file: 'Validform.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/kindeditor-4.1.10/themes/default', file: 'default.css')}" rel="stylesheet"
              type="text/css"/>
        <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "xm_write.css")}"/>
        <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "cxzx_list.css")}"/>
        <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10', file: 'kindeditor-min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10/lang', file: 'zh_CN.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'Validform_v5.3.2_min.js')}"></script>
        <script type="text/javascript">
            BUI.use('common/page');
            $(function () {
                var timeOut = setTimeout(function () {
                    $("#msg").hide(1000);
                }, 10000);
            });

            function startBid(id){
                $.ajax({
                    dataType:'json',
                    type:'post',
                    url:"${createLink(controller: 'front',action:'updTaskStatus',params:[status: TaskStatus.TASK_BIDING.code])}",
                    data:{id:id},
                    success:function(data){
                        if(data.success){
                            alert("操作成功");
                            $("#startBid").remove();
                        }else{
                            alert("操作失败");
                        }
                    }
                });
            }

            function cancelTask(id){
                $.ajax({
                    dataType:'json',
                    type:'post',
                    url:"${createLink(controller: 'front',action:'updTaskStatus',params:[status: TaskStatus.TASK_CANCEL.code])}",
                    data:{id:id},
                    success:function(data){
                        if(data.success){
                            alert("操作成功");
                            $("#cancelTask").remove();
                        }else{
                            alert("操作失败");
                        }
                    }
                });
            }

            function taskSuccess(id){
                $.ajax({
                    dataType:'json',
                    type:'post',
                    url:"${createLink(controller: 'front',action:'updTaskStatus',params:[status: TaskStatus.TASK_COMPLETE.code])}",
                    data:{id:id},
                    success:function(data){
                        if(data.success){
                            alert("操作成功");
                            $("#cancelTask").remove();
                        }else{
                            alert("操作失败");
                        }
                    }
                });
            }

            function taskFailure(id){
                $.ajax({
                    dataType:'json',
                    type:'post',
                    url:"${createLink(controller: 'front',action:'updTaskStatus',params:[status: TaskStatus.TASK_FAILURE.code])}",
                    data:{id:id},
                    success:function(data){
                        if(data.success){
                            alert("操作成功");
                            $("#cancelTask").remove();
                        }else{
                            alert("操作失败");
                        }
                    }
                });
            }
        </script>
    </head>

<body>
<!--消息-->
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

<div class="container pb-15">
<div class="row">
<div class="span16">

<div class="clearfix pb-5" style=" position:relative;">
    <div class="pull-left classifyDIV pt-10">
        <a class="pull-left type-css nosel">任务详情--${taskInstance?.simpleDesc}</a>
    </div>
</div>

<div class="clearfix pb-5" style=" position:relative;">
    <div class="pull-left classifyDIV pt-10">
        <a  class="pull-left type-css tags" href="javascript:void(0)" >要求完成日期：<g:formatDate date="${taskInstance.crcd}" format="yyyy-MM-dd"/></a>
        <a  class="pull-left type-css tags" href="javascript:void(0)">${TaskStatus.getLabel(taskInstance.status)}</a>
        <a  class="pull-left type-css tags" style="color:red" href="javascript:void(0)">¥&nbsp;&nbsp;${taskInstance.price}</a>
    </div>
</div>


<textarea name="taskArea">
    ${taskInstance?.detailDesc}
</textarea>

<script type="text/javascript">

    KindEditor.ready(function (K) {
        K.create('textarea[name="taskArea"]', {
            readonly:true,
            allowFileManager: true,
            langType: 'zh_CN',
            items: [ ],
            width: '900px',
            height: "300px"
        });
    });
</script>

    <div style="margin-top: 5px;margin-left: 30px">
        <g:if test="${taskInstance.status==com.lj.tps.status.TaskStatus.TASK_INIT.code}">
            <a href="${createLink(controller: 'front',action:'editTask',params:[id:taskInstance.id])}" target="_blank" class="button button-primary button-large">
                编辑
            </a>
            <a href="javascript:void(0)" id="startBid" class="button button-primary button-large" onclick="startBid(${taskInstance.id});">
                开始竞标
            </a>
        </g:if>
        <g:if  test="${ taskInstance.status in [com.lj.tps.status.TaskStatus.TASK_INIT.code, com.lj.tps.status.TaskStatus.TASK_BIDING.code]}">
            <a href="javascript:void(0)"  id="cancelTask"  class="button button-primary button-large" onclick="cancelTask(${taskInstance.id});">
                取消任务
            </a>
        </g:if>
        <g:if  test="${ taskInstance.status ==com.lj.tps.status.TaskStatus.TASK_BIDED.code}">
            <a href="javascript:void(0)"   id="taskSuccess"  class="button button-primary button-large" onclick="taskSuccess(${taskInstance.id});">
                任务成功
            </a>
        </g:if>
        <g:if  test="${params.handler=='taskFailure' && taskInstance.status ==com.lj.tps.status.TaskStatus.TASK_BIDED.code}">
            <a href="javascript:void(0)"   id="taskFailure"  class="button button-primary button-large" onclick="taskFailure(${taskInstance.id});">
                任务失败
            </a>
        </g:if>

    </div>


<g:if test="${bidInstanceList}">
    <div class="clearfix pb-5" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <a class="pull-left type-css nosel">所有竞标</a>
            <a  class="pull-left type-css tags ${params.sort=='gcd'?'selected':''}" readonly="true" href="${createLink(controller: 'front',action:'showMyTask',params: [id:taskInstance.id,sort:'gcd',order:'asc'])}">保证完成日期↑</a>
            <a  class="pull-left type-css tags ${params.sort=='price'?'selected':''}" href="${createLink(controller: 'front',action:'showMyTask',params: [id:taskInstance.id,sort:'price',order:'asc'])}">价格↑</a>
        </div>
    </div>
    <g:each in="${bidInstanceList}" status="i" var="myBid">
        <div class="clearfix pb-5" style=" position:relative;">
            <div class="pull-left classifyDIV pt-5">
                <a  class="pull-left type-css tags" href="javascript:void(0)" >竞标人：${myBid.username}</a>
                <a  class="pull-left type-css tags" href="javascript:void(0)" >保证完成日期：<g:formatDate date="${myBid.gcd}" format="yyyy-MM-dd"/></a>
                <a  class="pull-left type-css tags" href="javascript:void(0)">${com.lj.tps.status.BidStatus.getLabel(myBid.status ?: -1)}</a>
                <a  class="pull-left type-css tags" style="color:red" href="javascript:void(0)">保证价格：¥&nbsp;&nbsp;${myBid.price}</a>

            </div>
        </div>
        <textarea name="myBidArea_${i}">
            ${myBid.skillDesc ?: ""}
        </textarea>

        <script type="text/javascript">

            KindEditor.ready(function (K) {
                K.create('textarea[name="myBidArea_${i}"]', {
                    readonly:true,
                    allowFileManager: true,
                    langType: 'zh_CN',
                    items: [ ],
                    width: '900px',
                    height: "100px"
                });
            });
        </script>



        <div style="margin-top: 5px;margin-left: 30px">

            <g:if test="${(taskInstance.status in [TaskStatus.TASK_BIDING.code])}">
                <a href="${createLink(action: "setupWinner", params: [bidId: myBid.id,id:taskInstance.id])}" class="button button-primary button-large">中标</a>
            </g:if>
        </div>
     </g:each>


</g:if>
</div>
</div>
</div>

	</body>
</html>
