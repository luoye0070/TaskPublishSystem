<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <link rel="icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="zh-CN" />
    <script type="text/javascript" src="${resource(dir: "js",file:"jquery-1.8.1.min.js")}"></script>
    <title><g:layoutTitle/></title>
    <meta name="Keywords" content="任务发布平台"/>
    <meta name="Description" content="任务发布平台"/>
    <link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
    <!-- Le styles -->
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/basic.css"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/hf.css"/>
    %{--<link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/index.css"/>--}%
    <script type="text/javascript" src="${resource(dir: "pageTemplate")}/js/bioV4.min.js"></script>
    <script type="text/javascript" src="${resource(dir: "pageTemplate")}/js/jquery.lazyload.mini.js"></script>
    %{--<link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/comment.css"/>--}%
    <script type="text/javascript" src="${resource(dir: "pageTemplate")}/js/function.js"></script>
    <!--[if IE 6]>
    <script type="text/javascript" src="${resource(dir: "pageTemplate/js",file:"DD_belatedPNG.js")}"></script>
    <script type="text/javascript">
         DD_belatedPNG.fix('img,.ie6png');
    </script>
    <![endif]-->
    <link type="text/css" rel="stylesheet" href="${resource(dir: "pageTemplate")}/style/biobox2.css" />
    <script type="text/javascript" src="${resource(dir: "pageTemplate")}/js/biobox.js"></script>
    <g:layoutHead/>
    <r:layoutResources />
</head>
<body>
<script type="text/javascript" src="${resource(dir:"pageTemplate/js",file:"borsertocss.js")}"> </script><!-- 判断在IE9以下浏览器中根据像素的不同而设置的样式 -->
<!--头部代码开始-->
<div class="navbar navbar-fixed-top" style="_position: relative;_z-index: 10000;">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <div class="nav-collapse">
                <ul class="nav" id="navID">
                    <li class="${(controllerName=="front"&&actionName=="index")?"active":""}"><a href="${createLink(controller:"front",action:'index')}"><b>首页</b></a></li>

                    <sec:ifLoggedIn>
                        <li class="${(controllerName=="front"&&actionName=="myTask")?"active":""}"><a href="${createLink(controller:"front",action:'myTask')}"><b>我的任务</b></a></li>
                        <li class="${(controllerName=="front"&&actionName=="mySelector")?"active":""}"><a href="${createLink(controller:"front",action:'mySelector')}"><b>我的中标</b></a></li>
                        <li class="${(controllerName=="front"&&actionName=="myBid")?"active":""}"><a href="${createLink(controller:"front",action:'myBid')}"><b>我参与的竞标</b></a></li>
                    </sec:ifLoggedIn>
                        <li class="${(controllerName=="front"&&actionName=="editTask")?"active":""}"><a href="${createLink(controller:"front",action:'createTask')}"><b>发布任务</b></a></li>
                </ul>
            </div><!--/.nav-collapse -->
            <ul class="nav pull-right login-none nav-tips">
                <li class="ie6png divider-vertical" style="_width: 30px;_height: 40px;_background: url(${resource(dir: "pageTemplate/images",file:"icons.png")}) no-repeat 10px -106px;">
                    <a class="dropdown-toggle clearfix" href="${createLink(controller:"user",action:'edit')}" style="padding: 7px 5px;">
                    <img class="logo-before pull-left" src="${resource(dir: "pageTemplate/images",file:"avatar-icon.png")}" /></a></li>
            </ul>
            <div class="popup-div tips-div" style="position: absolute;z-index: 10000001;display: none;"></div>



            <ul class="nav pull-right pl-20 myul">
                <sec:ifNotLoggedIn>
                   <li class=""><a href="${createLink(controller: "userReg",action: "register")}">注册</a></li>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="" style="height: 40px;margin-left: 5px;margin-right: 5px;">
                    <div class="hy" style="height: 40px;line-height: 40px;color: white">
                        欢迎您，<span><sec:loggedInUserInfo field="username"/></span>
                    </div>
                    </li>
                    <li>
                        <a href="${createLink(controller:'logout',action:'index')}" title="退出系统">[退出]</a>
                    </li>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                <li class="l10"><a href="${createLink(controller: "login",action: "auth")}">登录</a></li>
                </sec:ifNotLoggedIn>
            </ul>

        </div>
    </div>
</div>
<div class="top-div" style="background: #F8F8F8;">
    <div class="container clearfix">

        <div class="span16" style="position: relative;_float: right;_height: 80px;_overflow: hidden;margin-left:0 ">

            <a href="#"  target="_blank" rel="nofollow">
                <img alt="" src="${resource(dir: "pageTemplate/images",file:"img2.jpg")}" style="width: 100%; display: block;height:100px"/></a>

        </div>

    </div>
</div>


<!--头部代码结束-->
<div style="margin-bottom:30px;background: #F8F8F8;">
<g:layoutBody/>
</div>
 <!--底部开始-->
<div class="footer navbar-fixed-bottom">

    <div class="clearfix" style="background:#EDEDED;">

        <ul class="about-ul">
            <li class="fc666">客服电话 400-100-8884</li>
            <li><span>|</span></li>

            <li><a title="企业服务" href="#" class="fc666" target="_blank">企业服务</a></li>
            <li><span>|</span></li>
            <li><a title="公司博客" href="#" class="fc666" target="_blank" >公司博客</a></li>
            <li><span>|</span></li>
            <li><a title="加入我们" href="#" class="fc666" target="_blank">加入我们</a></li>
            <li><span>|</span></li>
            <li><a title="服务协议" href="#" class="fc666" target="_blank">服务协议</a></li>

            <div class="clear"></div>
        </ul>
    </div>




</div>


<script type="text/javascript">
    //回到顶部
    backToTop('body');

</script>
<!--底部结束-->


<g:javascript library="application"/>
<r:layoutResources />
</body>
</html>
