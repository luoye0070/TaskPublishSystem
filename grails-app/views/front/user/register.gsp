<%@ page import="com.lj.tps.data.TpsUser" %>
<!DOCTYPE html>
<html>
<head>
    <title>注册用户</title>
    <link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript">
        $(function(){
            <g:if test="${isSaveOk}">

            </g:if>
        });

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
    <g:render template="/layouts/msgs_and_errors"/>
    </div>
</div>
<div id="create-tpsUser" style="margin: 10px;" role="main">

    <g:form action="register" controller="userReg" class="form-horizontal" >
        <%@ page import="com.lj.tps.data.TpsUser" %>



        <div class="row">

            <div class="control-group span12">
                <label class="control-label" for="username">
                    <s>*</s><g:message code="member.username.label" default="Username" />：
                </label>
                <div class="controls control-row-auto">

                    <g:textField name="username" required="" value="${params.username}"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label" for="IDNumber">
                    <s>*</s><g:message code="tpsUser.IDNumber.label" default="IDN umber" />：
                </label>
                <div class="controls control-row-auto">

                    <g:textField name="IDNumber" maxlength="24" required="" value="${params.IDNumber}"/>

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span12">
                <label class="control-label" for="mobileNumber">
                    <s>*</s><g:message code="tpsUser.mobileNumber.label" default="Mobile Number" />：
                </label>
                <div class="controls control-row-auto">

                    <g:textField name="mobileNumber" maxlength="16" required="" value="${params.mobileNumber}"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label" for="realName">
                    <g:message code="member.realName.label" default="Real Name" />：
                </label>
                <div class="controls control-row-auto">

                    <g:textField name="realName" value="${params.realName}"/>

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span12">
                <label class="control-label" for="password">
                    <s>*</s><g:message code="member.password.label" default="Password" />：
                </label>
                <div class="controls control-row-auto">

                    <g:passwordField name="password" required="" value="${params.password}"/>

                </div>
            </div>

            <div class="control-group span12">
                <label class="control-label" for="password">
                    <s>*</s><g:message code="member.rePassword.label" default="Password" />：
                </label>
                <div class="controls control-row-auto">

                    <g:passwordField name="rePassword" required="" value="${params.rePassword}"/>

                </div>
            </div>

        </div>

        <div class="row">

            <div class="control-group span24">
                <label class="control-label" for="unitName">
                    <g:message code="tpsUser.unitName.label" default="Unit Name" />：
                </label>
                <div class="controls control-row-auto">

                    <g:textField name="unitName" maxlength="128" value="${params.unitName}" style="width: 300px;"/>

                </div>
            </div>


        </div>

        <div class="control-group">
            <label class="control-label">&nbsp;</label>
            <div class="controls">
                <button type="submit" class="button">
                    ${message(code: 'default.button.register.label', default: 'Register')}
                </button>
            </div>
        </div>
    </g:form>
</div>
</body>
</html>