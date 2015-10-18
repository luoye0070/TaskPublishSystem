<%@ page import="com.lj.tps.data.TpsUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>用户信息修改</title>
    %{--<link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>--}%
    %{--<link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>--}%
    %{--<link href="${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>--}%
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
    %{--<div class="mmdh pull-left"><a href="">首页</a> > <a href="">投资机构</a> > <a href="">机构标题</a></div>--}%
    %{--<div class="mmkey pull-right"><b><a href="">关键字</a></b><b><a href="">关键字</a></b><b><a href="">关键字</a></b><div class="mmclear"></div></div>--}%
    <div class="mmclear"></div>
    <div style="margin-top: 14px;" class="clearfix pb-12 pl-25 pr-25">
        <h1 class="pull-left r-10">用户信息修改</h1>
        %{--<div class="pull-left pt-5 none-768" style="_margin-top:-33px; _margin-left:-10px;">--}%
            %{--<span class="like-plug-gz clearfix pull-left r-15">--}%
                %{--<a title="感兴趣，关注一下吧" href="javascript:void(0);" class="like-btn pull-right ie6png">关注本文</a>--}%
                %{--<span class="count pull-left t-5 d-none"></span>--}%
            %{--</span>--}%
        %{--</div>--}%
    </div>
    %{--<div style="margin-top: 4px;" class="clearfix pl-25 pr-25">--}%
        %{--<div class="pull-left">--}%

            %{--<span class="r-15 pull-left"><span class="fc999 l-5">2013/03/02</span></span>--}%
            %{--<span class="r-15 pull-left"><span class="fc999 l-5">涉及行业：软件</span></span>--}%
            %{--<span class="fc999 l-20 pull-left">涉及公司：--}%
                %{--<span data-obj="News" data-oid="104437" id="obj_hits" class="fc999">Google</span>--}%
            %{--</span>--}%
        %{--</div>--}%
    %{--</div>--}%
    <div class="view-main t-20 pl-25 pr-25">
        %{--<table style="width: 100%;" class="fc333 border-all">--}%
            %{--<tbody><tr>--}%
                %{--<td style="padding: 5px 12px;width: 25px;font-size: 22px;text-align: center;background: #E8E8E8; line-height: 30px;color: #999">导读</td>--}%
                %{--<td style="padding: 10px 10px 12px;line-height: 24px;">内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容</td>--}%
            %{--</tr>--}%
            %{--</tbody></table>--}%
        %{--<div class="view-content" style="margin-top: 18px;">--}%
            %{--<p>内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内 内容内容内容内容内容</p>--}%
        %{--</div>--}%
        <div class="label-div t-15 border-all" style="padding: 0;">
            <div class="label-main">
                <div class="clearfix label-public pt-25">

        <div class="clearfix" id="register-mail" style="display:block;">
            <g:form action="edit" controller="user" enctype="multipart/form-data" name="register-form" method="post">
                <div class="pull-left public-login span10">
                    %{--<div class="pl-25 fc333">没有社会化账号，使用邮箱账号注册</div>--}%
                    <div id="msg" style="margin-left: 25px;">
                        <g:render template="/layouts/msgs_and_errors"/>
                    </div>

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <s>*</s><g:message code="member.username.label" default="Username" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            %{--<input class="span4" name="UcenterMember[account]" id="UcenterMember_account" type="text" maxlength="32" value="" />--}%
                            <g:textField name="username" required="" value="${tpsUserInstance?.username}"  class="span4"/>
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
                            <g:textField name="IDNumber" maxlength="24" required="" value="${tpsUserInstance?.IDNumber}" class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info IDNumber_msg">身份证号码将用于验证用户的真实性</span>
                    </div>

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <s>*</s><g:message code="tpsUser.mobileNumber.label" default="Mobile Number" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                            <g:textField name="mobileNumber" maxlength="16" required="" value="${tpsUserInstance?.mobileNumber}" class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info mobileNumber_msg">手机号码将用于我们更好的联系您</span>
                    </div>

                    %{--<div class="clearfix pl-25 pt-25">--}%
                        %{--<div class="title pull-left fc999">--}%
                            %{--<s>*</s><g:message code="member.password.label" default="Password" />--}%
                        %{--</div>--}%
                        %{--<div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">--}%
                            %{--<input type="password" id="UcenterMember_password1" name="UcenterMember[password1]" value="" class="span4"/>--}%
                            %{--<g:passwordField name="password" required="" value="${tpsUserInstance?.password}" class="span4"/>--}%
                        %{--</div>--}%
                        %{--<span class="pull-left l-20 fc999 info password_msg">密码最小值为6位（字母区分大小写）</span>--}%
                    %{--</div>--}%

                    %{--<div class="clearfix pl-25 pt-25">--}%
                        %{--<div class="title pull-left fc999"><s>*</s>确认密码</div>--}%
                        %{--<div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">--}%
                            %{--<input type="password" id="UcenterMember_password2" name="UcenterMember[password2]" value="" class="span4"/>--}%
                            %{--<g:passwordField name="rePassword" required="" value="${tpsUserInstance?.rePassword}" class="span4"/>--}%
                        %{--</div>--}%
                        %{--<span class="pull-left l-20 fc999 info rePassword_msg">请再次输入密码</span>--}%
                    %{--</div>--}%

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <g:message code="member.realName.label" default="Real Name" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                            <g:textField name="realName" value="${tpsUserInstance?.realName}" class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info email_msg">请输入真实姓名</span>
                    </div>

                    <div class="clearfix pl-25 pt-25">
                        <div class="title pull-left fc999">
                            <g:message code="tpsUser.unitName.label" default="Unit Name" />
                        </div>
                        <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                            %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                            <g:textField name="unitName" maxlength="128" value="${tpsUserInstance?.unitName}"  class="span4"/>
                        </div>
                        <span class="pull-left l-20 fc999 info email_msg">请输入您的单位名称</span>
                    </div>

                    %{--<div class="clearfix pl-25 pt-25">--}%
                        %{--<div class="title pull-left">&nbsp;</div>--}%
                        %{--<div class="pull-left l-20 t-8" style="_width: auto;_margin-left: 15px;">--}%
                            %{--<input type="checkbox" checked="checked" style="_width: 20px;_margin: 0;"/></div>--}%
                        %{--<span class="pull-left l-5 info fc999" style="_width: auto;_margin: 0;">--}%
                            %{--我已阅读并接受--}%
                            %{--<a href="#" title="某某网服务条款协议" target="_blank">某某网服务条款协议</a></span>--}%
                    %{--</div>--}%
                    <div class="clearfix pl-25 pt-25 pb-30">
                        <div class="title pull-left l-20" style="_margin-left: 10px;">&nbsp;</div>
                        <a href="javascript:void(0);" title="保存" class="pull-left login-register-btn" onclick="submit_form(this)">保&nbsp;存</a>
                        %{--<span class="pull-left l-20 info fc999" style="_width: auto;_margin: 0 0 0 10px;">社会化账号<a class="l-5 sina-register-button" href="javascript:void(0)" title="注册">注册</a></span>--}%
                    </div>
                </div>
                %{--<div class="pull-left t-50 l-20">--}%
                    %{--<div class="label-div border-all" style="padding: 10px;width: 150px;">--}%
                        %{--<img class="lazyloadimg show_fave" src="${resource(dir: "pageTemplate")}/images/user_180.gif" style="width: 150px;height: 150px; display: block;" /></div>--}%
                    %{--<div class="center t-10"><input id="file" type='file' name="file" onChange="ajaxFileUpload()" />--}%
                        %{--<input id="new_face" type='hidden' name="new_face" value="" /></div>--}%
                    %{--<img src="http://pic.3gbizhi.com/2014/1108/20141108014348193.jpg" style="max-width: 430px;"/>--}%
                %{--</div>--}%
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
