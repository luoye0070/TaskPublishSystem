<%@ page import="com.lj.tps.data.TpsUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>用户信息修改</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/zx_info.css"/>
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




<div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>
<div class="container pb-15">
<!-- Example row of columns -->
<div class="row">

<!--右侧代码-->
<g:render template="/layouts/left_menu"/>


<div class="span12">
<!--内容页面-->
<div class="label-div b-30 border-all pt-5 t-20" style="position: relative; padding-left: 0;">

    <div class="mmclear"></div>
    <div style="margin-top: 14px;" class="clearfix pb-12 pl-25 pr-25">
        <h1 class="pull-left r-10">用户信息修改</h1>

    </div>

    <div class="view-main t-20 pl-25 pr-25">

        <div class="label-div t-15 border-all" style="padding: 0;">
            <div class="label-main">
                <div class="clearfix label-public pt-25">

        <div class="clearfix" id="register-mail" style="display:block;">
            <g:form action="edit" controller="user" enctype="multipart/form-data" name="register-form" method="post">
                <div class="pull-left public-login span10">
                    <div id="msg" style="margin-left: 25px;">
                        <g:render template="/layouts/msgs_and_errors"/>
                    </div>

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <s>*</s><g:message code="member.username.label" default="Username" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            <g:textField name="username" required="" value="${tpsUserInstance?.username}"  class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info username_msg">用户名将用于登录，请牢记</span>
                    </div>

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <s>*</s><g:message code="tpsUser.IDNumber.label" default="IDN umber" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            <g:textField name="IDNumber" maxlength="24" required="" value="${tpsUserInstance?.IDNumber}" class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info IDNumber_msg">身份证号码将用于验证用户的真实性</span>
                    </div>

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <s>*</s><g:message code="tpsUser.mobileNumber.label" default="Mobile Number" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            <g:textField name="mobileNumber" maxlength="16" required="" value="${tpsUserInstance?.mobileNumber}" class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info mobileNumber_msg">手机号码将用于我们更好的联系您</span>
                    </div>


                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <g:message code="member.realName.label" default="Real Name" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            <g:textField name="realName" value="${tpsUserInstance?.realName}" class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info email_msg">请输入真实姓名</span>
                    </div>

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <g:message code="tpsUser.unitName.label" default="Unit Name" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            <g:textField name="unitName" maxlength="128" value="${tpsUserInstance?.unitName}"  class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info email_msg">请输入您的单位名称</span>
                    </div>

                    <div class="clearfix pl-25 pt-25 pb-30">
                        <div class="title pull-left l-20" style="_margin-left: 10px;">&nbsp;</div>
                        <a href="javascript:void(0);" title="保存" class="pull-left login-register-btn" onclick="submit_form(this)">保&nbsp;存</a>
                    </div>
                </div>

            </g:form>
        </div>
        </div>
                </div>
        </div>

    </div>


    <!--警告：切勿删除-->
    <!--[if IE 6]> <a class="follow-btn ie6png mmmzw"></a><![endif]-->

</div>

</div>

</div>
</div>

<!--右侧代码结束-->


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

</body>
</html>
