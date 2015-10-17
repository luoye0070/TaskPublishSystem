<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <meta name="layout" content="front_main"/>
    <title>发包管理系统登录</title>
    %{--<link rel="Shortcut Icon" href="${resource(dir: 'images', file: 'favicon_picc.ico')}"/>--}%
   %{--<link rel="stylesheet" href="${resource(dir:'css/login/css',file:'style.css')}">--}%
  %{--<link rel="stylesheet" href="${resource(dir:'css/login/css',file:'demo.css')}">--}%
    %{--<link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>--}%
    %{--<link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>--}%
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/login.css"/>
    <script type='text/javascript'>
        if(window.parent!=window){
            parent.location.reload();
        }

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
        <div class="span16">
            <div class="label-public-title t-30">
                <ul class="clearfix">
                    <li class="pull-left selected border-all r-20"><a href="#" title="登录" style="_padding: 0;">登录</a></li>
                    <li class="pull-left border-all"><a href="${createLink(controller: "userReg",action: "register")}" title="注册">注册</a></li>

                </ul>
            </div>
            <div class="label-div t-15 border-all" style="padding: 0;">
                <div class="label-main">
                    <div class="clearfix label-public">
                        <div class="pull-left third-party l-30 pt-25">
                            %{--<div class="fc333">社会化账号直接登录</div>--}%
                            %{--<div class="clearfix t-25">--}%
                                %{--<div class="pull-left sina-div r-10 b-10" style="_width: 110px;">--}%
                                    %{--<a class="ie6png" href="/oauth/sina.html?url=aHR0cDovL3d3dy5iaW9kaXNjb3Zlci5jb20vZG9jdW1lbnQuaHRtbA%3D%3D">新浪微博</a>--}%
                                %{--</div>--}%
                                %{--<div class="pull-left tencent-div r-10 b-10" style="_width: 110px;">--}%
                                    %{--<a class="ie6png" href="/oauth/qq.html?url=aHR0cDovL3d3dy5iaW9kaXNjb3Zlci5jb20vZG9jdW1lbnQuaHRtbA%3D%3D">腾讯微博</a>--}%
                                %{--</div>--}%
                                %{--<div class="pull-left renren-div r-10 b-10" style="_width: 110px;">--}%
                                    %{--<a class="ie6png" href="/oauth/renren.html?url=aHR0cDovL3d3dy5iaW9kaXNjb3Zlci5jb20vZG9jdW1lbnQuaHRtbA%3D%3D">人人网</a>--}%
                                %{--</div>--}%
                                %{--<div class="pull-left linkin-div b-10" style="_width: 110px;">--}%
                                    %{--<a class="ie6png" href="/oauth/linkin.html?url=aHR0cDovL3d3dy5iaW9kaXNjb3Zlci5jb20vbG9naW4uaHRtbD91cmw9YUhSMGNEb3ZMM2QzZHk1aWFXOWthWE5qYjNabGNpNWpiMjB2Wkc5amRXMWxiblF1YUhSdGJBJTNEJTNE">LinkedIn</a>--}%
                                %{--</div>--}%
                            %{--</div>--}%
                            %{--<p class="fc999" style="max-width: 470px;">欢迎加入生物探索，这里有最新的资讯、丰富的产品、贴心的服务，还有你正在寻找的圈子和朋友。</p>--}%
                            <img src="http://pic.3gbizhi.com/2014/1108/20141108014348193.jpg" style="max-width: 570px;"/>
                        </div>
                        <form id="login_form1" action='${postUrl}' method='POST' autocomplete="on">
                            <div class="pull-left border-l public-login span7" style="min-height: 385px;float: left">
                                %{--<div class="t-25 pl-30 fc333">没有社会化账号，使用用户名登录</div>--}%
                                <div class="t-25 pl-30 fc333">
                                    <g:if test='${flash.message}'>
                                        <p style="color:red;text-align:left" id="msg">
                                            ${flash.message}
                                        </p>
                                    </g:if>
                                </div>
                                <div class="clearfix pt-25">
                                    <div class="title pull-left fc999" style="width: 60px;">用户名</div>
                                    <div class="pull-left l-20" style="_margin-left: 0;width: 100px;">
                                        <input type="text" id="username" name="username" required="required" value="" class="span4"/></div>
                                    <span class="pull-left l-20 fcCF261F info username_msg"></span>
                                </div>
                                <div class="clearfix pt-25">
                                    <div class="title pull-left fc999" style="width: 60px;">密码</div>
                                    <div class="pull-left l-20" style="_margin-left: 0;width: 100px;">
                                        <input type="password" id="password" name="password" required="required" value="" class="span4"/></div>
                                    <span class="pull-left l-20 fcCF261F info password_msg"></span>
                                </div>
                                <div class="clearfix pt-25">
                                    <div class="title pull-left" style="margin-left: 6px;_margin-left: 3px;">&nbsp;</div>
                                    <a href="javascript:void(0);" title="登录" onclick="submit_form(this)"  class="pull-left login-register-btn">登&nbsp;录</a>
                                    %{--<button type="submit" title="登录"  class="pull-left login-register-btn">登&nbsp;录</button>--}%
                                    <div class="pull-left l-20 t-8" style="_width: auto;_margin-left: 15px;">
                                        <input type="checkbox" name="${rememberMeParameter}" <g:if test='${hasCookie}'>checked='checked' </g:if> style="_width: 20px;_margin: 0;"/>
                                    </div>
                                    <span class="pull-left l-5 info fc999" style="_width: auto;_margin: 0;">下次自动登录<!-- <span class="l-10 fcccc">|</span><a class="fc999 l-10" href="" title="忘记密码">忘记密码</a> --></span>
                                </div>
                            </div>
                        </form>
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
            $(".username_msg").html('请输入您的邮箱');
            $("#username").focus();
            setTimeout(function(){$(".username_msg").html('');},3000);
            return false;
        }
        //密码验证
        if($('#password').attr("value") == ''){
            $(".password_msg").html('请输入您的密码');
            setTimeout(function(){$(".password_msg").html('');},3000);
            $("#password").focus();
            return false;
        }

        document.getElementById("login_form1").submit();
        return true;
    };
</script>

%{--<div class="container">--}%


    %{--<section>--}%
        %{--<div id="container_demo" >--}%
            %{--<div id="wrapper">--}%
                %{--<div id="login" class="animate form">--}%
                    %{--<form  action='${postUrl}' method='POST' autocomplete="on" id="loginForm">--}%
                        %{--<h1>发包管理系统登录</h1>--}%
    %{--<g:if test='${flash.message}'>--}%
                        %{--<p style="color:red;text-align: center">--}%
                            %{--${flash.message}--}%
                        %{--</p>--}%
    %{--</g:if>--}%
                        %{--<p>--}%
                            %{--<label for="username" class="uname" data-icon="u" > 用户名 </label>--}%
                            %{--<input id="username" name="username" required="required" type="text" />--}%
                        %{--</p>--}%
                        %{--<p>--}%
                            %{--<label for="password" class="youpasswd" data-icon="p"> 密码</label>--}%
                            %{--<input id="password" name="password" required="required" type="password" />--}%
                        %{--</p>--}%
                        %{--<p class="keeplogin">--}%
                            %{--<input type="checkbox" name="${rememberMeParameter}" <g:if test='${hasCookie}'>checked='checked' </g:if>/>--}%
                            %{--<label for="${rememberMeParameter}">记住我</label>--}%
                        %{--</p>--}%
                        %{--<p class="login button">--}%
                            %{--<input type="submit" value="登录" />--}%
                        %{--</p>--}%

                    %{--</form>--}%
                %{--</div>--}%


            %{--</div>--}%
        %{--</div>--}%
    %{--</section>--}%
%{--</div>--}%

<script type='text/javascript'>
    <!--
    (function() {
        document.forms['loginForm'].elements['username'].focus();
    })();
    // -->
</script>

</body>
</html>
