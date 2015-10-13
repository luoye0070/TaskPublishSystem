<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <link href="\${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
        <link href="\${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
        <link href="\${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="\${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
        <script type="text/javascript" src="\${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
        <script type="text/javascript">
            BUI.use('common/page');
            \$(function(){
                var timeOut=setTimeout(function(){
                    \$("#msg").hide(1000);
                },10000);
            });
        </script>
	</head>
	<body>
    <!--消息-->
    <div style="margin: 10px;">
        <div id="msg">
        %{--<g:render template="/layouts/msgs_and_errors"/>--}%
        <g:if test="\${errors || flash.errors}">
            <div class="tips tips-small tips-warning">
                <span class="x-icon x-icon-small x-icon-error"><i class="icon icon-white icon-warning"></i></span>

                <div class="tips-content">\${errors}\${flash.errors}</div>
            </div>
        </g:if>
        <g:if test="\${msgs || flash.msgs}">
            <div class="tips tips-small tips-info">
                <span class="x-icon x-icon-small x-icon-info"><i class="icon icon-white icon-info"></i></span>

                <div class="tips-content">\${msgs}\${flash.msgs}</div>
            </div>
        </g:if>
        <g:if test="\${warnings || flash.warnings}">
            <div class="tips tips-small tips-warning">
                <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-bell"></i></span>
                <div class="tips-content">\${flash.warnings}\${warnings}</div>
            </div>
        </g:if>
        <g:if test="\${success || flash.success}">
            <div class="tips tips-small  tips-success">
                <span class="x-icon x-icon-small x-icon-success"><i class="icon icon-white icon-ok"></i></span>
                <div class="tips-content">\${flash.success}\${success}</div>
            </div>
        </g:if>
        <g:if test="\${question || flash.question}">
            <div class="tips tips-small">
                <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-question"></i></span>
                <div class="tips-content">\${flash.question}\${question}</div>
            </div>
        </g:if>
        </div>
    </div>
		<div id="show-${domainClass.propertyName}" style="margin: 10px;" role="main">
            <div class="panel">
                <div class="panel-header">
                    <h3>\${message(code: '${domainClass.propertyName}.label', default: '${className}')}-详情</h3>
                </div>
                <div class="panel-body">
			<ol>
			<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
				allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
				props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
				Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
				props.each { p -> %>
				<g:if test="\${${propertyName}?.${p.name}}">
				<li>
					<span id="${p.name}-label" class="property-label"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></span>
					<%  if (p.isEnum()) { %>
						<span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></span>
					<%  } else if (p.oneToMany || p.manyToMany) { %>
						<g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
						<span class="property-value" aria-labelledby="${p.name}-label">
                            %{--<g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}--}%
                            %{--</g:link>--}%
                            <a class="page-action" href="#" data-href="\${createLink(controller:"${p.referencedDomainClass?.propertyName}",action: "show",params: [id:${p.name[0]}.id])}"
                            title="\${message(code: '${p.referencedDomainClass?.propertyName}.label', default: '${p.referencedDomainClass?.shortName}')}详情-[\${${p.name[0]}.id}]" data-id="${p.referencedDomainClass?.propertyName}_show_menu\${${p.name[0]}.id}">
                            \${${p.name[0]}?.encodeAsHTML()}
                            </a>
                        </span>
						</g:each>
					<%  } else if (p.manyToOne || p.oneToOne) { %>
						<span class="property-value" aria-labelledby="${p.name}-label">
                            %{--<g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}
                            </g:link>--}%
                            <a class="page-action" href="#" data-href="\${createLink(controller:"${p.referencedDomainClass?.propertyName}",action: "show",params: [id:${propertyName}?.${p.name}.id])}"
                            title="\${message(code: '${p.referencedDomainClass?.propertyName}.label', default: '${p.referencedDomainClass?.shortName}')}详情-[\${${propertyName}?.${p.name}.id}]" data-id="${p.referencedDomainClass?.propertyName}_show_menu\${${propertyName}?.${p.name}.id}">
                            \${${propertyName}?.${p.name}?.encodeAsHTML()}
                            </a>
                        </span>
					<%  } else if (p.type == Boolean || p.type == boolean) { %>
						<span class="property-value" aria-labelledby="${p.name}-label"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></span>
					<%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
						<span class="property-value" aria-labelledby="${p.name}-label"><g:formatDate date="\${${propertyName}?.${p.name}}" /></span>
					<%  } else if (!p.type.isArray()) { %>
						<span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></span>
					<%  } %>
				</li>
				</g:if>
			<%  } %>
			</ol>
                    </div>
                </div>
		</div>
	</body>
</html>
