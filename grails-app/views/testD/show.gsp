
<%@ page import="com.lj.tps.data.TestD" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'testD.label', default: 'TestD')}" />
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
		<div id="show-testD" style="margin: 10px;" role="main">
            <div class="panel">
                <div class="panel-header">
                    <h3>${message(code: 'testD.label', default: 'TestD')}-详情</h3>
                </div>
                <div class="panel-body">
			<ol>
			
				<g:if test="${testDInstance?.name}">
				<li>
					<span id="name-label" class="property-label"><g:message code="testD.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${testDInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${testDInstance?.num}">
				<li>
					<span id="num-label" class="property-label"><g:message code="testD.num.label" default="Num" /></span>
					
						<span class="property-value" aria-labelledby="num-label"><g:fieldValue bean="${testDInstance}" field="num"/></span>
					
				</li>
				</g:if>
			
			</ol>
                    </div>
                </div>
		</div>
	</body>
</html>
