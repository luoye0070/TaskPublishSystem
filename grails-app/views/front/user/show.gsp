
<%@ page import="com.lj.tps.data.TpsUser" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'tpsUser.label', default: 'TpsUser')}" />
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
		<div id="show-tpsUser" style="margin: 10px;" role="main">
            <div class="panel">
                <div class="panel-header">
                    <h3>${message(code: 'tpsUser.label', default: 'TpsUser')}-详情</h3>
                </div>
                <div class="panel-body">
			<ol>
			
				<g:if test="${tpsUserInstance?.username}">
				<li>
					<span id="username-label" class="property-label"><g:message code="tpsUser.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${tpsUserInstance}" field="username"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.password}">
				<li>
					<span id="password-label" class="property-label"><g:message code="tpsUser.password.label" default="Password" /></span>
					
						<span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${tpsUserInstance}" field="password"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.realName}">
				<li>
					<span id="realName-label" class="property-label"><g:message code="tpsUser.realName.label" default="Real Name" /></span>
					
						<span class="property-value" aria-labelledby="realName-label"><g:fieldValue bean="${tpsUserInstance}" field="realName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.IDNumber}">
				<li>
					<span id="IDNumber-label" class="property-label"><g:message code="tpsUser.IDNumber.label" default="IDN umber" /></span>
					
						<span class="property-value" aria-labelledby="IDNumber-label"><g:fieldValue bean="${tpsUserInstance}" field="IDNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.mobileNumber}">
				<li>
					<span id="mobileNumber-label" class="property-label"><g:message code="tpsUser.mobileNumber.label" default="Mobile Number" /></span>
					
						<span class="property-value" aria-labelledby="mobileNumber-label"><g:fieldValue bean="${tpsUserInstance}" field="mobileNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.unitName}">
				<li>
					<span id="unitName-label" class="property-label"><g:message code="tpsUser.unitName.label" default="Unit Name" /></span>
					
						<span class="property-value" aria-labelledby="unitName-label"><g:fieldValue bean="${tpsUserInstance}" field="unitName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.accountExpired}">
				<li>
					<span id="accountExpired-label" class="property-label"><g:message code="tpsUser.accountExpired.label" default="Account Expired" /></span>
					
						<span class="property-value" aria-labelledby="accountExpired-label"><g:formatBoolean boolean="${tpsUserInstance?.accountExpired}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.accountLocked}">
				<li>
					<span id="accountLocked-label" class="property-label"><g:message code="tpsUser.accountLocked.label" default="Account Locked" /></span>
					
						<span class="property-value" aria-labelledby="accountLocked-label"><g:formatBoolean boolean="${tpsUserInstance?.accountLocked}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.enabled}">
				<li>
					<span id="enabled-label" class="property-label"><g:message code="tpsUser.enabled.label" default="Enabled" /></span>
					
						<span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${tpsUserInstance?.enabled}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.passwordExpired}">
				<li>
					<span id="passwordExpired-label" class="property-label"><g:message code="tpsUser.passwordExpired.label" default="Password Expired" /></span>
					
						<span class="property-value" aria-labelledby="passwordExpired-label"><g:formatBoolean boolean="${tpsUserInstance?.passwordExpired}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tpsUserInstance?.roles}">
				<li>
					<span id="roles-label" class="property-label"><g:message code="tpsUser.roles.label" default="Roles" /></span>
					
						<g:each in="${tpsUserInstance.roles}" var="r">
						<span class="property-value" aria-labelledby="roles-label">
                            %{--<g:link controller="roles" action="show" id="${r.id}">${r?.encodeAsHTML()}--}%
                            %{--</g:link>--}%
                            <a class="page-action" href="#" data-href="${createLink(controller:"roles",action: "show",params: [id:r.id])}"
                            title="${message(code: 'roles.label', default: 'Roles')}详情-[${r.id}]" data-id="roles_show_menu${r.id}">
                            ${r?.encodeAsHTML()}
                            </a>
                        </span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
                    </div>
                </div>
		</div>
	</body>
</html>
