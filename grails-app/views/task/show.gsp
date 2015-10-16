
<%@ page import="com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
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
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${taskInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
			</ol>
                    </div>
                </div>
		</div>
	</body>
</html>
