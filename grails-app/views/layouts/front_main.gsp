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
<script type="text/javascript" src="js/borsertocss.js"> </script><!-- 判断在IE9以下浏览器中根据像素的不同而设置的样式 -->
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
                        <li class="${(controllerName=="front"&&actionName=="myBid")?"active":""}"><a href="${createLink(controller:"front",action:'myBid')}"><b>我的竞标</b></a></li>
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
            <script type="text/javascript">
                var tip_show = 1;
                //头部下拉
                var timer1 = "";
                $('#dropdownID-0').hover(function(){
                    var obj = $(this);
                    if(timer1)
                    {
                        clearTimeout(timer1);
                    }
                    timer1 = setTimeout(function(){
                        obj.find('.dropdown-menu').show();
                        tip_show = 0;
                        $(".tips-div").hide();
                        obj.find('.other-icon').css({"background":"#2E2E2E"});
                    }, 500);
                },function(){
                    var obj = $(this);
                    if(timer1)
                    {
                        clearTimeout(timer1);
                    }
                    timer1 = setTimeout(function(){
                        obj.find('.dropdown-menu').hide();
                        $(".tips-div").hide();
                        tip_show = 1;
                        getTips();
                        obj.find('.other-icon').css({"background":"none"});
                    }, 500);
                });

                var timer2 = "";
                $('#dropdownID-1').hover(function(){
                    var obj = $(this);
                    if(timer2)
                    {
                        clearTimeout(timer2);
                    }
                    timer2 = setTimeout(function(){
                        obj.find('.dropdown-menu').show();
                        tip_show = 0;
                        $(".tips-div").hide();
                        obj.find('.other-icon').css({"background":"#2E2E2E"});
                    }, 500);
                },function(){
                    var obj = $(this);
                    if(timer2)
                    {
                        clearTimeout(timer2);
                    }
                    timer2 = setTimeout(function(){
                        obj.find('.dropdown-menu').hide();
                        tip_show = 1;
                        getTips();
                        $(".tips-div").hide();
                        obj.find('.other-icon').css({"background":"none"});
                    }, 500);
                });
            </script>


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
<div class="top-div">
    <div class="container clearfix">

        %{--<div class="span11 pull-right top-ad" style="position: relative;_float: right;_height: 80px;_overflow: hidden;">--}%

            %{--<a href="#" class="pull-left" target="_blank" rel="nofollow">--}%
                %{--<img alt="" src="${resource(dir: "pageTemplate/images",file:"img1.jpg")}" style="width: 100%; display: block;"/></a>--}%

            %{--<a href="#" class="pull-left" style="display:none;" target="_blank">--}%
                %{--<img alt="" src="${resource(dir: "pageTemplate/images",file:"img2.jpg")}" style="width: 100%; display: block;"/></a>--}%


            %{--<div class="slides-icon-ad slides-ad-point" style="position: absolute;right:60px;">--}%
                %{--<a href="javascript:void(0);" class="icon-css-on ie6png">&nbsp;</a>--}%
                %{--<a href="javascript:void(0);" class="icon-css ie6png">&nbsp;</a>--}%
            %{--</div>--}%

        %{--</div>--}%

    </div>
</div>
<script type="text/javascript">
    $(function(){
        var Interval_control = '';
        var current_index = 0;
        show_pic_ad = function(index){
            $(".top-ad .pull-left").each(function(i){
                $(this).hide();
                if(i == index){

                    $(this).show();
                }
            });
        };
        show_point_ad = function(index){
            $(".top-ad .slides-ad-point a").each(function(i){
                if($(this).hasClass("icon-css-on")){
                    $(this).removeClass("icon-css-on");
                    $(this).addClass("icon-css");
                }
                if(i == index){
                    if($(this).hasClass("icon-css")){
                        $(this).removeClass("icon-css");
                    }
                    $(this).addClass("icon-css-on");
                }
            });
        };
        slides = function(){
            $(".slides-ad-point a").each(function(index){
                $(this).click(function(){
                    current_index = index;
                    show_point_ad(index);
                    show_pic_ad(current_index);
                });
            });
        };
        slides();
        Interval_control = setInterval(function(){
            show_point_ad(current_index);
            show_pic_ad(current_index);
            if (current_index == ($(".slides-icon-ad a").length - 1)){
                current_index = -1;
            }
            current_index ++;
        },5000);//设置自动切换函数
        //当触发mouseenter事件时，取消正在执行的自动切换方法，触发mouseouter事件时重新设置自动切换
        $(".top-ad .pull-left").mouseenter(function() {
            clearInterval(Interval_control);//停止自动切换
        }).mouseleave(function(){
                    Interval_control = setInterval(function(){
                        show_point_ad(current_index);
                        show_pic_ad(current_index);
                        if (current_index == ($(".top-ad .pull-left").length - 1)){
                            current_index = -1;
                        }
                        current_index ++;
                    },5000);//设置自动切换函数
                });
    });
</script>


<!--头部代码结束-->

<g:layoutBody/>

 <!--底部开始-->
<div class="footer">

    <!--<p class="fc999 b-5 footer-info">致力于前沿生物科技和成功商业模式的传播</p>-->
    <div class="clearfix" style="background:#EDEDED;">

        <!--<p class="fc999 pull-left footer-info">Copyright (c) 2013 生物探索网站<span class="l-20">苏ICP备11025281号</span></p>-->

        <ul class="about-ul">
            <li class="fc666">客服电话 400-100-8884</li>
            <li><span>|</span></li>
            %{--<li><a title="广告投放" href="#" class="fc666" target="_blank">广告投放</a></li>--}%
            %{--<li><span>|</span></li>--}%
            <li><a title="企业服务" href="#" class="fc666" target="_blank">企业服务</a></li>
            <li><span>|</span></li>
            <li><a title="公司博客" href="#" class="fc666" target="_blank" >公司博客</a></li>
            <li><span>|</span></li>
            <li><a title="加入我们" href="#" class="fc666" target="_blank">加入我们</a></li>
            <li><span>|</span></li>
            <li><a title="服务协议" href="#" class="fc666" target="_blank">服务协议</a></li>
            %{--<li><span>|</span></li>--}%
            <!-- <li id="zk_btn" class="ie6png down-class">
                   	 <a title="友情链接" href="javascript:void(0);" class="fc666">友情链接</a>
                    </li>-->
            %{--<li id="zk_btn" class="ie6png down-class">--}%
                %{--<a title="友情链接" href="javascript:void(0);" class="fc666">友情链接</a>--}%
            %{--</li>--}%
            <div class="clear"></div>
        </ul>
    </div>

    <div class="friend-link border-all t-20 b-20">
        <ul class="clearfix">
            <li><a href="http://www.everlab.net/" title="Everlab云端实验室" target="_blank" class="fc666">Everlab云端实验室</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.pharmsources.cn/" title="国际医药资源网" target="_blank" class="fc666">国际医药资源网</a></li>
            <li><span>|</span></li>
            <li><a href="http://ggene.cn/index.html" title="基因时代" target="_blank" class="fc666">基因时代</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.labome.cn" title="来邦网" target="_blank" class="fc666">来邦网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.labbase.net" title="来宝网" target="_blank" class="fc666">来宝网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.csh-asia.org/" title="冷泉港亚洲" target="_blank" class="fc666">冷泉港亚洲</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.mycodes.net/" title="源码之家" target="_blank">源码之家</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.helixnet.cn/bbs/index.php" title="螺旋网" target="_blank" class="fc666">螺旋网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.qqzl.cc/" title="全球制冷网" target="_blank" class="fc666">全球制冷网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.bio1000.com" title="生物帮" target="_blank" class="fc666">生物帮</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.biobox.cn/" title="生物百花网" target="_blank" class="fc666">生物百花网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.shengwu114.com/" title="生物114" target="_blank" class="fc666">生物114</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.biosou.com" title="生物搜" target="_blank" class="fc666">生物搜</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.51atgc.com" title="生物无忧" target="_blank" class="fc666">生物无忧 </a></li>
            <li><span>|</span></li>
            <li><a href="http://www.bioguider.com/" title="生物行" target="_blank" class="fc666">生物行</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.bio-diag.net/" title="生物诊断网" target="_blank" class="fc666">生物诊断网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.labscn.com" title="实验室中国" target="_blank" class="fc666">实验室中国</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.tilsi.org" title="太仓生命信息研究所" target="_blank" class="fc666">太仓生命信息研究所</a></li>
            <li><span>|</span></li>
            <li><a href="http://bip.taicang.gov.cn/" title="太仓市生物医药产业园" target="_blank" class="fc666">太仓市生物医药产业园</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.biomean.com" title="探生网" target="_blank" class="fc666">探生网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.bio-vc.org/" title="投融资峰会" target="_blank" class="fc666">投融资峰会</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.vedeng.com/" title="VEDENG贝登" target="_blank" class="fc666">VEDENG贝登</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.cusabio.cn/" title="武汉华美生物" target="_blank" class="fc666">武汉华美生物</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.xinxueshu.com/" title="新学术" target="_blank" class="fc666">新学术</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.he-cn.com" title="医药经理人" target="_blank" class="fc666">医药经理人</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.chinastemcell.org/" title="中国干细胞信息平台" target="_blank" class="fc666">中国干细胞信息平台</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.312tree.com/" title="中国苗木网" target="_blank" class="fc666">中国苗木网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.sepu.net/" title="中国色谱网" target="_blank" class="fc666">中国色谱网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.zg17.com/" title="中国仪器网" target="_blank" class="fc666">中国仪器网</a></li>
            <li><span>|</span></li>
            <li><a href="http://www.chinapubmed.net/" title="中文PubMed" target="_blank" class="fc666">中文PubMed</a></li>
        </ul>
    </div>
    <script type="text/javascript">
        $(document).ready(function(){
            var flag = 0;
            $(".friend-link").hide();
            //Down
            $("#zk_btn").click(function(){
                if(flag == 0){
                    $(".friend-link").slideDown(400);
                    $(this).removeClass('down-class');
                    $(this).addClass('up-class');
                    $("html,body").animate({scrollTop:($(".friend-link").offset().top+2000)},600);
                    flag = 1;
                }else{
                    $(".friend-link").slideUp(400);
                    $(this).removeClass('up-class');
                    $(this).addClass('down-class');
                    flag = 0;
                }
            });
        });
    </script>

    <p>Copyright (c)2015　<a href="http://www.mycodes.net/" title="源码之家" target="_blank">源码之家</a>　备8888888888号</p>

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
