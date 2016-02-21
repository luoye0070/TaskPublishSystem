<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <meta name="layout" content="front_main"/>
    <title>任务发布平台登录</title>
    <link href="${resource(dir: "css")}/Wopop_files/style_log.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="${resource(dir: "css")}/Wopop_files/style.css">
    <link rel="stylesheet" type="text/css" href="${resource(dir: "css")}/Wopop_files/userpanel.css">
    %{--<link rel="stylesheet" type="text/css" href="${resource(dir: "css")}/Wopop_files/jquery.ui.all.css">--}%
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/login.css"/>

    <script type='text/javascript'>
        if(window.parent!=window){
            parent.location.reload();
        }

        $(function(){
            var timeOut=setTimeout(function(){
                $("#msg").hide(2000);
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
                    <div class="clearfix label-public login">

                        <div  class="login">

                        <div class="login_m">
                            <div class="t-25 pl-30 fc333">
                                <g:if test='${flash.message}'>
                                    <p style="text-align:left" id="msg">
                                        <span style="color:red;">${flash.message}</span>
                                        <br/>
                                        <g:if test="${flash.disabled==true}">
                                            <a href="${createLink(controller: "userReg",action:"register",params:[username:flash.username,isEdit:true])}">修改${flash.username}注册信息 </a>
                                        </g:if>
                                    </p>
                                </g:if>
                            </div>
                            <div class="login_boder">

                                <form id="login_form1" action='${postUrl}' method='POST' autocomplete="on">


                                <div class="login_padding" id="login_model">

                                    <h2>用户名</h2>
                                    <label>
                                        <input type="text" id="username" name="username" class="txt_input txt_input2" value="">
                                    </label>
                                    <h2>密码</h2>
                                    <label>
                                        <input type="password" name="password" id="password" class="txt_input" value="">
                                    </label>


                                    <div class="rem_sub">
                                        <div class="rem_sub_l">
                                            <input type="checkbox" name="${rememberMeParameter}" <g:if test='${hasCookie}'>checked='checked' </g:if> style="_width: 20px;_margin: 0;"/>
                                            <label for="checkbox">记住我</label>
                                        </div>
                                        <label>
                                            <input type="submit" class="sub_button" name="button" id="button" value="登录" style="opacity: 0.7;">
                                        </label>
                                    </div>
                                </div>
                                </form>

                            </div>
                        </div>

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

<script type='text/javascript'>
    <!--
    (function() {
        document.forms['login_form1'].elements['username'].focus();
    })();
    // -->
</script>

</body>
</html>
