<%@ page import="com.lj.tps.data.TpsUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>注册用户</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/login.css"/>
    <script type="text/javascript">
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
                    <li class="pull-left r-20 border-all"><a href="${createLink(controller: "login",action: "auth")}" title="登录">登录</a></li>
                    <li class="pull-left selected border-all"><a href="#" title="注册" style="_padding: 0;">注册</a></li>
                </ul>
            </div>
            <div class="label-div t-15 border-all" style="padding: 0;">
                <div class="label-main">
                    <div class="clearfix label-public pt-25">
                        <div class="clearfix" id="register-mail" style="display:block;">
                            <g:form action="register" controller="userReg" enctype="multipart/form-data" name="register-form" method="post">
                                <div class="pull-left public-login span10">
                                <div id="msg" style="color: red;margin-left: 25px;">
                                    <g:render template="/layouts/msgs_and_errors"/>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="member.username.label" default="Username" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        <g:textField name="username" required="" value="${params.username}"  class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info username_msg">用户名将用于登录，请牢记</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="tpsUser.IDNumber.label" default="IDN umber" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        <g:textField name="IDNumber" maxlength="24" required="" value="${params.IDNumber}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info IDNumber_msg">身份证号码将用于验证用户的真实性</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="tpsUser.mobileNumber.label" default="Mobile Number" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        <g:textField name="mobileNumber" maxlength="16" required="" value="${params.mobileNumber}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info mobileNumber_msg">手机号码将用于我们更好的联系您</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <s>*</s><g:message code="member.password.label" default="Password" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        <g:passwordField name="password" required="" value="${params.password}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info password_msg">密码最小值为6位（字母区分大小写）</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999"><s>*</s>确认密码</div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        <g:passwordField name="rePassword" required="" value="${params.rePassword}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info rePassword_msg">请再次输入密码</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <g:message code="member.realName.label" default="Real Name" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        <g:textField name="realName" value="${params.realName}" class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info email_msg">请输入真实姓名</span>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    <div class="title pull-left fc999">
                                        <g:message code="tpsUser.unitName.label" default="Unit Name" />
                                    </div>
                                    <div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">
                                        <g:textField name="unitName" maxlength="128" value="${params.unitName}"  class="span4"/>
                                    </div>
                                    <span class="pull-left l-20 fc999 info email_msg">请输入您的单位名称</span>
                                </div>

                                <div class="clearfix pl-25 pt-25 pb-30">
                                    <div class="title pull-left l-20" style="_margin-left: 10px;">&nbsp;</div>
                                    <a href="javascript:void(0);" title="注册" class="pull-left login-register-btn" onclick="submit_form(this)">注&nbsp;册</a>
                                </div>
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

    function IdentityCodeValid(code) {
        var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
        var tip = "";
        var pass= true;

        if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
            tip = "身份证号格式错误";
            pass = false;
        }

        else if(!city[code.substr(0,2)]){
            tip = "地址编码错误";
            pass = false;
        }
        else{
            //18位身份证需要验证最后一位校验位
            if(code.length == 18){
                code = code.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                //校验位
                var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++)
                {
                    ai = code[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var last = parity[sum % 11];
                if(parity[sum % 11] != code[17]){
                    tip = "校验位错误";
                    pass =false;
                }
            }
        }
        //if(!pass) alert(tip);
        return pass;
    }
     function isUserExist(username){
         var exist=false;
         $.ajax({
             data:{username:username},
             url:"${createLink(controller:"userReg",action: "userExist",absolute: true)}",
             async:false,
             success:function(data){
                 //alert(data);
                exist=Boolean(data);
             }
         });
         //alert(exist);
         return exist;
     }
    function validUserName(){
        //用户名验证
        if($('#username').attr("value") == ''){
            $(".username_msg").html('请输入您的用户名');
            $(".username_msg").css("color","#CF261F");
            $("#username").focus();
            setTimeout(function(){$(".username_msg").html('用户名将用于登录，请牢记');$(".username_msg").css("color","#999");},3000);
            return false;
        }else if(isUserExist($('#username').attr("value"))){
            $(".username_msg").html('您的用户名已经注册过了，换一个试试吧');
            $(".username_msg").css("color","#CF261F");
            $("#username").focus();
            setTimeout(function(){$(".username_msg").html('用户名将用于登录，请牢记');$(".username_msg").css("color","#999");},3000);
            return false;
        }
        return true;
    }
    function validID(){
        if($('#IDNumber').attr("value") == ''){
            $(".IDNumber_msg").html('请输入您的身份证号码');
            $(".IDNumber_msg").css("color","#CF261F");
            $("#IDNumber").focus();
            setTimeout(function(){$(".IDNumber_msg").html('身份证号码将用于验证用户的真实性');$(".IDNumber_msg").css("color","#999");},3000);
            return false;
        }else if(!IdentityCodeValid($('#IDNumber').attr("value"))){
            $(".IDNumber_msg").html('请输入有效的身份证号码');
            $(".IDNumber_msg").css("color","#CF261F");
            $("#IDNumber").focus();
            setTimeout(function(){$(".IDNumber_msg").html('身份证号码将用于验证用户的真实性');$(".IDNumber_msg").css("color","#999");},3000);
            return false;
        }
        return true;
    }
    function validPhone(){
        if($('#mobileNumber').attr("value") == ''){
            $(".mobileNumber_msg").html('请输入您的手机号码');
            $(".mobileNumber_msg").css("color","#CF261F");
            $("#mobileNumber").focus();
            setTimeout(function(){$(".mobileNumber_msg").html('手机号码将用于我们更好的联系您');$(".mobileNumber_msg").css("color","#999");},3000);
            return false;
        }else{//验证手机号码是否有效
            var mobile=$('#mobileNumber').attr("value");
            var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
            if(mobile.length!=11||!myreg.test(mobile))
            {
                $(".mobileNumber_msg").html('请输入有效的手机号码');
                $(".mobileNumber_msg").css("color","#CF261F");
                $("#mobileNumber").focus();
                setTimeout(function(){$(".mobileNumber_msg").html('手机号码将用于我们更好的联系您');$(".mobileNumber_msg").css("color","#999");},3000);
                return false;
            }
        }
        return true;
    }
    function validPwd(){
        if($('#password').attr("value") == ''){
            $(".password_msg").html('请输入您的设置的密码');
            $(".password_msg").css("color","#CF261F");
            $("#password").focus();
            setTimeout(function(){$(".password_msg").html('密码最小值为6位（字母区分大小写）');$(".password_msg").css("color","#999");},3000);
            return false;
        }
        return true;
    }
    function validRePwd(){
        if($('#rePassword').attr("value") == ''){
            $(".rePassword_msg").html('请输入再次输入密码');
            $(".rePassword_msg").css("color","#CF261F");
            $("#rePassword").focus();
            setTimeout(function(){$(".rePassword_msg").html('请输入再次输入密码');$(".rePassword_msg").css("color","#999");},3000);
            return false;
        }
        if($('#password').attr("value") !=$('#rePassword').attr("value")){
            $(".rePassword_msg").html('确认密码输入不正确');
            $(".rePassword_msg").css("color","#CF261F");
            $("#rePassword").focus();
            setTimeout(function(){$(".rePassword_msg").html('请输入再次输入密码');$(".rePassword_msg").css("color","#999");},3000);
            return false;
        }
        return true;
    }
    //网站后台登录
    adminLogin = function(){
         if(!validUserName()){
             return false;
         }
         if(!validID()){
             return false;
         }
         if(!validPhone()){
             return false;
         }
         if(!validPwd()){
             return false;
         }
         if(!validRePwd()){
             return false;
         }
        document.getElementById("register-form").submit();
        return true;
    };
    $(function(){
        $('#username').blur(function(){
            validUserName();
        });
        $('#IDNumber').blur(function(){
            validID();
        });
        $('#mobileNumber').blur(function(){
            validPhone();
        });
        $('#password').blur(function(){
            validPwd();
        });
        $('#rePassword').blur(function(){
            validRePwd();
        });
    });
</script>
</body>
</html>
