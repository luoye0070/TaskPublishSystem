
<%@ page import="com.lj.tps.status.TaskStatus; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title>${taskInstance?.simpleDesc?:"任务详情"}</title>
        <link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
        <script type="text/javascript">
            BUI.use('common/page');
            $(function(){
                var timeOut=setTimeout(function(){
                    $("#msg").hide(1000);
                },10000);
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
		<div id="show-task" style="margin: 10px;" role="main">
            <div class="panel">
                <div class="panel-header">
                    <h3>${message(code: 'task.label', default: 'Task')}-详情</h3>
                </div>
                <div class="panel-body">
			<ol>
			
				<g:if test="${taskInstance?.simpleDesc}">
				<li>
					<span id="simpleDesc-label" class="property-label"><g:message code="task.simpleDesc.label" default="Simple Desc" /></span>
					
						<span class="property-value" aria-labelledby="simpleDesc-label"><g:fieldValue bean="${taskInstance}" field="simpleDesc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.detailDesc}">
				<li>
					<span id="detailDesc-label" class="property-label"><g:message code="task.detailDesc.label" default="Detail Desc" /></span>
					
						<span class="property-value" aria-labelledby="detailDesc-label"></span>

                    ${taskInstance?.detailDesc}
				</li>

				</g:if>
			
				<g:if test="${taskInstance?.price}">
				<li>
					<span id="price-label" class="property-label"><g:message code="task.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${taskInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.crcd}">
				<li>
					<span id="crcd-label" class="property-label"><g:message code="task.crcd.label" default="Crcd" /></span>
					
						<span class="property-value" aria-labelledby="crcd-label"><g:formatDate date="${taskInstance?.crcd}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.contactWay}">
				<li>
					<span id="contactWay-label" class="property-label"><g:message code="task.contactWay.label" default="Contact Way" /></span>
					
						<span class="property-value" aria-labelledby="contactWay-label"><g:fieldValue bean="${taskInstance}" field="contactWay"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.contactInfo}">
				<li>
					<span id="contactInfo-label" class="property-label"><g:message code="task.contactInfo.label" default="Contact Info" /></span>
					
						<span class="property-value" aria-labelledby="contactInfo-label"><g:fieldValue bean="${taskInstance}" field="contactInfo"/></span>
					
				</li>
				</g:if>
			

			
				<g:if test="${taskInstance?.status}">
				<li>
					<span id="status-label" class="property-label"><g:message code="task.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label">${TaskStatus.getLabel(taskInstance.status)}</span>
					
				</li>
				</g:if>
			
			</ol>
                    </div>
                </div>
            <g:if test="${params.handler=='startBid' && taskInstance.status==com.lj.tps.status.TaskStatus.TASK_INIT.code}">
                <a id="startBid" class="page-action" href="javascipt:void(0);"  onclick="startBid(${taskInstance.id});">开始竞标</a>
            </g:if>
            <g:if  test="${params.handler=='cancelTask' && taskInstance.status in [com.lj.tps.status.TaskStatus.TASK_INIT.code, com.lj.tps.status.TaskStatus.TASK_BIDING.code]}">
                <a id="cancelTask" class="page-action" href="javascipt:void(0);" onclick="cancelTask(${taskInstance.id});">取消任务</a>
            </g:if>
            <g:if  test="${params.handler=='taskSuccess' && taskInstance.status ==com.lj.tps.status.TaskStatus.TASK_BIDED.code}">
                <a id="cancelTask" class="page-action" href="javascipt:void(0);" onclick="taskSuccess(${taskInstance.id});">任务成功</a>
            </g:if>
            <g:if  test="${params.handler=='taskFailure' && taskInstance.status ==com.lj.tps.status.TaskStatus.TASK_BIDED.code}">
                <a id="cancelTask" class="page-action" href="javascipt:void(0);" onclick="taskFailure(${taskInstance.id});">任务失败</a>
            </g:if>
            <br/>
            <div class="panel">
                <div class="panel-header">
                    <h3>所有竞标</h3>
                </div>
                <div class="panel-body">
                    <g:if test="${bidInstanceList}">
                        <div>
                            <table class="table table-striped table-bordered">
                                <thead>
                                <tr>


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

                                            <td>${fieldValue(bean: bidInstance, field: "contactInfo")}</td>


                                            <td>${bidInstance.skillDesc?:""}</td>

                                            <td>${fieldValue(bean: bidInstance, field: "price")}</td>

                                            <td><g:formatDate date="${bidInstance.gcd}" format="yyyy-MM-dd"/></td>

                                            <td>${fieldValue(bean: bidInstance, field: "username")}</td>

                                            <td>${com.lj.tps.status.BidStatus.getLabel(bidInstance.status?:-1)}</td>

                                            <td>
                                                <g:if test="${!(taskInstance.status in [TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE,TaskStatus.TASK_BIDED.code,TaskStatus.TASK_CANCEL.code])}">
                                                    <a class="page-action" href="${createLink(action: "setupWinner", params: [bidId: bidInstance.id,id:taskInstance.id])}">设置中标</a>
                                                </g:if>

                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </g:form>
                            </table>

                            <div>

                                <div class="pagination pull-right">
                                    <!--分页-->
                                    <rmp:paginateInBui action="showMyTask" total="${bidInstanceTotal}" prev="&larr;"
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
                            </div>
                        </div>
                    </g:else>
                </div>
            </div>
		</div>



	</body>
</html>
