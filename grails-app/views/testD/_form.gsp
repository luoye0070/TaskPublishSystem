<%@ page import="com.lj.tps.data.TestD" %>



<div class="row">

<div class="control-group span12">
    <label class="control-label" for="name">
        <g:message code="testD.name.label" default="Name" />：
    </label>
    <div class="controls control-row-auto">
        
        <g:textField name="name" value="${testDInstance?.name}"/>
        
    </div>
</div>


<div class="control-group span12">
    <label class="control-label" for="num">
        <s>*</s><g:message code="testD.num.label" default="Num" />：
    </label>
    <div class="controls control-row-auto">
        
        <g:field name="num" type="number" value="${testDInstance.num}" required=""/>
        
    </div>
</div>


</div>

