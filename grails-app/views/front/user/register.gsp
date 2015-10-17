<%@ page import="com.lj.tps.data.TpsUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>注册用户</title>
    %{--<link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>--}%
    %{--<link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>--}%
    %{--<link href="${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>--}%
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/login.css"/>
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
%{--<!--消息-->--}%
%{--<div style="margin: 10px;">--}%
    %{--<div id="msg">--}%
    %{--<g:render template="/layouts/msgs_and_errors"/>--}%
    %{--</div>--}%
%{--</div>--}%


<div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>
<div class="container pb-15">
    <!-- Example row of columns -->
    <div class="row">
        <div class="span16">
            <div class="label-public-title t-30">
                <ul class="clearfix">
                    <li class="pull-left r-20 border-all"><a href="${createLink(controller: "login",action: "auth")}" title="登录">登录</a></li>
                    <li class="pull-left selected border-all"><a href="#" title="注册" style="_padding: 0;">注册</a></li>
                </ul>
            </div>
            <div class="label-div t-15 border-all" style="padding: 0;">
                <div class="label-main">
                    <div class="clearfix label-public pt-25">
                        <div class="pull-left public-login span10" id="register-third" style="display:none;">
                            <div class="fc333 l-30">使用社会化账号直接注册，无需填写任何资料，30秒完成注册</div>
                            <div class="clearfix t-25 third-party l-30">
                                <div class="pull-left sina-div r-10 b-10">
                                    <a class="ie6png" href="#">新浪微博</a>
                                </div>
                                <div class="pull-left tencent-div r-10 b-10">
                                    <a class="ie6png" href="#">腾讯微博</a>
                                </div>
                                <div class="pull-left renren-div r-10 b-10">
                                    <a class="ie6png" href="#">人人网</a>
                                </div>
                                <div class="pull-left linkin-div b-10">
                                    <a class="ie6png" href="#">LinkedIn</a>
                                </div>
                            </div>
                            <p class="l-30 t-30 fc999">没有社会化账号？请使用<a href="#" title="邮箱注册" class="l-5 email-register-button">邮箱注册</a></p>
                        </div>

                        <div class="clearfix" id="register-mail" style="display:block;">
                            <g:form action="register" controller="userReg" enctype="multipart/form-data" name="register-form" method="post">
                                <div class="pull-left public-login span10">
                                %{--<div class="pl-25 fc333">没有社会化账号，使用邮箱账号注册</div>--}%
                                <div id="msg" style="color: red;margin-left: 25px;">
                                    <g:render template="/layouts/msgs_and_errors"/>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="member.username.label" default="Username" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        %{--<input class="span4" name="UcenterMember[account]" id="UcenterMember_account" type="text" maxlength="32" value="" />--}%
                                        <g:textField name="username" required="" value="${params.username}"  class="span4"/>
                                        %{--<span class="pull-left l-20 fcCF261F info username_msg"></span>--}%
                                    </div>
                                    <span class="pull-left l-20 fc999 info username_msg">用户名将用于登录，请牢记</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="tpsUser.IDNumber.label" default="IDN umber" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                                        <g:textField name="IDNumber" maxlength="24" required="" value="${params.IDNumber}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info IDNumber_msg">身份证号码将用于验证用户的真实性</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="tpsUser.mobileNumber.label" default="Mobile Number" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                                        <g:textField name="mobileNumber" maxlength="16" required="" value="${params.mobileNumber}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info mobileNumber_msg">手机号码将用于我们更好的联系您</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="member.password.label" default="Password" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        %{--<input type="password" id="UcenterMember_password1" name="UcenterMember[password1]" value="" class="span4"/>--}%
                                        <g:passwordField name="password" required="" value="${params.password}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info password_msg">密码最小值为6位（字母区分大小写）</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999"><s>*</s>确认密码</div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        %{--<input type="password" id="UcenterMember_password2" name="UcenterMember[password2]" value="" class="span4"/>--}%
                                        <g:passwordField name="rePassword" required="" value="${params.rePassword}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info rePassword_msg">请再次输入密码</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <g:message code="member.realName.label" default="Real Name" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                                        <g:textField name="realName" value="${params.realName}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info email_msg">请输入真实姓名</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <g:message code="tpsUser.unitName.label" default="Unit Name" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                                        <g:textField name="unitName" maxlength="128" value="${params.unitName}"  class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info email_msg">请输入您的单位名称</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left">&nbsp;</div>
                                    <div class="pull-left l-20 t-8" style="_width: auto;_margin-left: 15px;">
                                        <input type="checkbox" checked="checked" style="_width: 20px;_margin: 0;"/></div>
                                    <span class="pull-left l-5 info fc999" style="_width: auto;_margin: 0;">
                                        我已阅读并接受
                                        <a href="#" title="某某网服务条款协议" target="_blank">某某网服务条款协议</a></span>
                                </div>
                                <div class="clearfix pl-25 pt-25 pb-30">
                                    <div class="title pull-left l-20" style="_margin-left: 10px;">&nbsp;</div>
                                    <a href="javascript:void(0);" title="注册" class="pull-left login-register-btn" onclick="submit_form(this)">注&nbsp;册</a>
                                    %{--<span class="pull-left l-20 info fc999" style="_width: auto;_margin: 0 0 0 10px;">社会化账号<a class="l-5 sina-register-button" href="javascript:void(0)" title="注册">注册</a></span>--}%
                                </div>
                            </div>
                                <div class="pull-left t-50 l-20">
                                    <div class="label-div border-all" style="padding: 10px;width: 150px;">
                                        <img class="lazyloadimg show_fave" src="${resource(dir: "pageTemplate")}/images/user_180.gif" style="width: 150px;height: 150px; display: block;" /></div>
                                    <div class="center t-10"><input id="file" type='file' name="file" onChange="ajaxFileUpload()" />
                                        <input id="new_face" type='hidden' name="new_face" value="" /></div>
                                    %{--<img src="http://pic.3gbizhi.com/2014/1108/20141108014348193.jpg" style="max-width: 430px;"/>--}%
                                </div>
                            </g:form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- /container -->
<div class="container">

    <div class="hr"></div>

</div>

<script type="text/javascript">
    $(document).ready(function(){
        $(".email-register-button").click(function(){
            $("#register-mail").fadeIn();
            $("#register-third").hide();
            $('#UcenterMember_account').focus();
        });
        $(".sina-register-button").click(function(){
            $("#register-mail").hide();
            $("#register-third").fadeIn();
        });
    });

    $('input').keydown(function(event){
        if(event.keyCode == 13)submit_form('.login-register-btn');
    });

    var submit_form = function(obj) {
        adminLogin();
    };


    //网站后台登录
    adminLogin = function(){
        //用户名验证
        if($('#username').attr("value") == ''){
            $(".username_msg").html('请输入您的用户名');
            $(".username_msg").css("color","#CF261F");
            $("#username").focus();
            setTimeout(function(){$(".username_msg").html('用户名将用于登录，请牢记');$(".username_msg").css("color","#999");},3000);
            return false;
        }

        if($('#IDNumber').attr("value") == ''){
            $(".IDNumber_msg").html('请输入您的身份证号码');
            $(".IDNumber_msg").css("color","#CF261F");
            $("#IDNumber").focus();
            setTimeout(function(){$(".IDNumber_msg").html('身份证号码将用于验证用户的真实性');$(".IDNumber_msg").css("color","#999");},3000);
            return false;
        }
        if($('#mobileNumber').attr("value") == ''){
            $(".mobileNumber_msg").html('请输入您的手机号码');
            $(".mobileNumber_msg").css("color","#CF261F");
            $("#mobileNumber").focus();
            setTimeout(function(){$(".mobileNumber_msg").html('手机号码将用于我们更好的联系您');$(".mobileNumber_msg").css("color","#999");},3000);
            return false;
        }
        if($('#password').attr("value") == ''){
            $(".password_msg").html('请输入您的设置的密码');
            $(".password_msg").css("color","#CF261F");
            $("#password").focus();
            setTimeout(function(){$(".password_msg").html('密码最小值为6位（字母区分大小写）');$(".password_msg").css("color","#999");},3000);
            return false;
        }
        if($('#rePassword').attr("value") == ''){
            $(".rePassword_msg").html('请输入再次输入密码');
            $(".rePassword_msg").css("color","#CF261F");
            $("#rePassword").focus();
            setTimeout(function(){$(".rePassword_msg").html('请输入再次输入密码');$(".rePassword_msg").css("color","#999");},3000);
            return false;
        }

        document.getElementById("register-form").submit();
        return true;
    };

</script>

%{--<div id="create-tpsUser" style="margin: 10px;" role="main">--}%

    %{--<g:form action="register" controller="userReg" class="form-horizontal" >--}%
        %{--<%@ page import="com.lj.tps.data.TpsUser" %>--}%



        %{--<div class="row">--}%

            %{--<div class="control-group span12">--}%
                %{--<label class="control-label" for="username">--}%
                    %{--<s>*</s><g:message code="member.username.label" default="Username" />：--}%
                %{--</label>--}%
                %{--<div class="controls control-row-auto">--}%

                    %{--<g:textField name="username" required="" value="${params.username}"/>--}%

                %{--</div>--}%
            %{--</div>--}%

            %{--<div class="control-group span12">--}%
                %{--<label class="control-label" for="IDNumber">--}%
                    %{--<s>*</s><g:message code="tpsUser.IDNumber.label" default="IDN umber" />：--}%
                %{--</label>--}%
                %{--<div class="controls control-row-auto">--}%

                    %{--<g:textField name="IDNumber" maxlength="24" required="" value="${params.IDNumber}"/>--}%

                %{--</div>--}%
            %{--</div>--}%

        %{--</div>--}%

        %{--<div class="row">--}%

            %{--<div class="control-group span12">--}%
                %{--<label class="control-label" for="mobileNumber">--}%
                    %{--<s>*</s><g:message code="tpsUser.mobileNumber.label" default="Mobile Number" />：--}%
                %{--</label>--}%
                %{--<div class="controls control-row-auto">--}%

                    %{--<g:textField name="mobileNumber" maxlength="16" required="" value="${params.mobileNumber}"/>--}%

                %{--</div>--}%
            %{--</div>--}%

            %{--<div class="control-group span12">--}%
                %{--<label class="control-label" for="realName">--}%
                    %{--<g:message code="member.realName.label" default="Real Name" />：--}%
                %{--</label>--}%
                %{--<div class="controls control-row-auto">--}%

                    %{--<g:textField name="realName" value="${params.realName}"/>--}%

                %{--</div>--}%
            %{--</div>--}%

        %{--</div>--}%

        %{--<div class="row">--}%

            %{--<div class="control-group span12">--}%
                %{--<label class="control-label" for="password">--}%
                    %{--<s>*</s><g:message code="member.password.label" default="Password" />：--}%
                %{--</label>--}%
                %{--<div class="controls control-row-auto">--}%

                    %{--<g:passwordField name="password" required="" value="${params.password}"/>--}%

                %{--</div>--}%
            %{--</div>--}%

            %{--<div class="control-group span12">--}%
                %{--<label class="control-label" for="password">--}%
                    %{--<s>*</s><g:message code="member.rePassword.label" default="Password" />：--}%
                %{--</label>--}%
                %{--<div class="controls control-row-auto">--}%

                    %{--<g:passwordField name="rePassword" required="" value="${params.rePassword}"/>--}%

                %{--</div>--}%
            %{--</div>--}%

        %{--</div>--}%

        %{--<div class="row">--}%

            %{--<div class="control-group span24">--}%
                %{--<label class="control-label" for="unitName">--}%
                    %{--<g:message code="tpsUser.unitName.label" default="Unit Name" />：--}%
                %{--</label>--}%
                %{--<div class="controls control-row-auto">--}%

                    %{--<g:textField name="unitName" maxlength="128" value="${params.unitName}" style="width: 300px;"/>--}%

                %{--</div>--}%
            %{--</div>--}%


        %{--</div>--}%

        %{--<div class="control-group">--}%
            %{--<label class="control-label">&nbsp;</label>--}%
            %{--<div class="controls">--}%
                %{--<button type="submit" class="button">--}%
                    %{--${message(code: 'default.button.register.label', default: 'Register')}--}%
                %{--</button>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</g:form>--}%
%{--</div>--}%

</body>
</html>
