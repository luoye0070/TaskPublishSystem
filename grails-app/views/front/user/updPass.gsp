
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta name="layout" content="front_main"/>
  <title>更新密码</title>
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
                    <h1 class="pull-left r-10">密码修改</h1>
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
                                    <g:form action="changePW" controller="user" enctype="multipart/form-data" name="register-form" method="post">
                                        <div class="pull-left public-login span10">
                                            %{--<div class="pl-25 fc333">没有社会化账号，使用邮箱账号注册</div>--}%
                                            <div id="msg" style="margin-left: 25px;">
                                                <g:render template="/layouts/msgs_and_errors"/>
                                            </div>

                                            <div class="clearfix pl-25 pt-25">
                                                <div class="title pull-left fc999">
                                                    <s>*</s>旧密码
                                                </div>
                                                <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                                    %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                                                    <g:passwordField name="oldPass" maxlength="16" required="" value="" class="span4"/>
                                                </div>
                                                <span class="pull-left l-20 fc999 info mobileNumber_msg">请填写旧密码</span>
                                            </div>

                                            <div class="clearfix pl-25 pt-25">
                                            <div class="title pull-left fc999">
                                            <s>*</s>新密码
                                            </div>
                                            <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                            <g:passwordField name="newPass" required="" value="" class="span4"/>
                                            </div>
                                            <span class="pull-left l-20 fc999 info password_msg">密码最小值为6位（字母区分大小写）</span>
                                            </div>

                                            <div class="clearfix pl-25 pt-25">
                                            <div class="title pull-left fc999"><s>*</s>确认密码</div>
                                            <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                            <g:passwordField name="newPass1" required="" value="" class="span4"/>
                                            </div>
                                            <span class="pull-left l-20 fc999 info rePassword_msg">再次输入新密码</span>
                                            </div>
                                            <div class="clearfix pl-25 pt-25 pb-30">
                                                <div class="title pull-left l-20" style="_margin-left: 10px;">&nbsp;</div>
                                                <a href="javascript:void(0);" title="提交" class="pull-left login-register-btn" onclick="submit_form(this)">提&nbsp;交</a>
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
        if($('#oldPass').attr("value") == ''){
            $(".mobileNumber_msg").html('请输入旧密码');
            $(".mobileNumber_msg").css("color","#CF261F");
            $("#oldPass").focus();
            setTimeout(function(){$(".mobileNumber_msg").html('请输入旧密码');$(".mobileNumber_msg").css("color","#999");},3000);
            return false;
        }

        if($('#newPass').attr("value") == ''){
            $(".password_msg").html('请输入您的设置的密码');
            $(".password_msg").css("color","#CF261F");
            $("#newPass").focus();
            setTimeout(function(){$(".password_msg").html('密码最小值为6位（字母区分大小写）');$(".password_msg").css("color","#999");},3000);
            return false;
        }
        if($('#newPass1').attr("value") == ''){
            $(".rePassword_msg").html('请输入再次输入密码');
            $(".rePassword_msg").css("color","#CF261F");
            $("#newPass1").focus();
            setTimeout(function(){$(".rePassword_msg").html('请输入再次输入密码');$(".rePassword_msg").css("color","#999");},3000);
            return false;
        }

        document.getElementById("register-form").submit();
        return true;
    };

</script>









%{--<!--消息-->--}%
%{--<div style="margin: 10px;">--}%
    %{--<div id="msg">--}%
        %{--<g:render template="/layouts/msgs_and_errors"/>--}%
    %{--</div>--}%
%{--</div>--}%

%{--<div id="content" class="container">--}%
    %{--<form id="J_Form" class="form-horizontal" method="post" action="${createLink(controller: 'user',action:'changePW')}">--}%
        %{--<div class="row hide" id="stip">--}%
            %{--<div class="tips tips-small tips-info">--}%
                %{--<span class="x-icon x-icon-small x-icon-info"><i class="icon icon-white icon-info"></i></span>--}%
                %{--<div class="tips-content" id='smsg'></div>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="row hide" id="ftip">--}%
            %{--<div class="tips tips-small tips-warning">--}%
                %{--<span class="x-icon x-icon-small x-icon-error"><i class="icon icon-white icon-bell"></i></span>--}%
                %{--<div class="tips-content" id='fmsg'></div>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<br>--}%
        %{--<div class="row">--}%
            %{--<div class="control-group">--}%
                %{--<label class="control-label"><s>*</s>旧密码</label>--}%
                %{--<div class="controls">--}%
                    %{--<input name="oldPass" id="oldPass" type="password" data-rules="{required:true}"  style="height:30px;width:200px">--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="row">--}%
            %{--<div class="control-group">--}%
                %{--<label class="control-label"><s>*</s>新密码</label>--}%
                %{--<div class="controls">--}%
                    %{--<input name="newPass" id="newPass" type="password" data-rules="{required:true}"  style="height:30px;width:200px">--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="row">--}%
            %{--<div class="control-group">--}%
                %{--<label class="control-label"><s>*</s>再次输入新密码</label>--}%
                %{--<div class="controls">--}%
                    %{--<input name="newPass1" type="password" id="newPass1"   data-rules="{equalTo:'#newPass'}"   style="height:30px;width:200px">--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%

        %{--<div class="row form-actions actions-bar">--}%
            %{--<div class="span13 offset3 ">--}%
                %{--<button type="submit" class="button button-primary">--}%
                    %{--${message(code: 'default.button.submit.label', default: 'Submit')}--}%
                %{--</button>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</form>--}%
%{--</div>--}%

</body>
</html>