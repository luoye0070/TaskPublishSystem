<%=packageName%>
<% import grails.persistence.Event %>

<%  excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
	persistentPropNames = domainClass.persistentProperties*.name
	boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate')
	if (hasHibernate && org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder.getMapping(domainClass)?.identity?.generator == 'assigned') {
		persistentPropNames << domainClass.identifier.name
	}
	props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
	Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
props.eachWithIndex { p, i ->
        if (i%2==0) { %>
<div class="row">
<% }
		if (p.embedded) {
			def embeddedPropNames = p.component.persistentProperties*.name
			def embeddedProps = p.component.properties.findAll { embeddedPropNames.contains(it.name) && !excludedProps.contains(it.name) }
			Collections.sort(embeddedProps, comparator.constructors[0].newInstance([p.component] as Object[]))
			%><fieldset class="embedded"><legend><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></legend><%
				for (ep in p.component.properties) {
					renderFieldForProperty(ep, p.component, "${p.name}.")
				}
			%></fieldset><%
		} else {
			renderFieldForProperty(p, domainClass)
		}
        if (i%2!=0||(i==props.size()-1)) { %>
</div>
<% }
	}

private renderFieldForProperty(p, owningClass, prefix = "") {
	boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate')
	boolean display = true
	boolean required = false
	if (hasHibernate) {
		cp = owningClass.constrainedProperties[p.name]
		display = (cp ? cp.display : true)
		required = (cp ? !(cp.propertyType in [boolean, Boolean]) && !cp.nullable && (cp.propertyType != String || !cp.blank) : false)
	}
	if (display) { %>
<div class="control-group span12">
    <label class="control-label" for="${prefix}${p.name}">
        <% if (required) { %><s>*</s><% } %><g:message code="${domainClass.propertyName}.${prefix}${p.name}.label" default="${p.naturalName}" />：
    </label>
    <div class="controls control-row-auto">
        <%if(p.type==Date){%>
            <g:textField name="${p.name}" value="\${com.lj.utils.FormatUtil.dateTimeFormat(${domainClass.propertyName}Instance?.${p.name})}"/>
            <!-- script start -->
            <script type="text/javascript">
                BUI.use('bui/calendar',function(Calendar){
                    var datepicker = new Calendar.DatePicker({
                        trigger:'#${p.name}',
                        showTime:true,
                        autoRender : true
                    });
                });
            </script>
            <!-- script end -->
        <%}else{%>
        ${renderEditor(p)}
        <%}%>
    </div>
</div>

<%  }   } %>
