


<style type="text/css">
/*body {*/
    /*margin: 0;*/
    /*padding: 0;*/
    /*font-size: 12px;*/
    /*font-family: "Microsoft Yahei", Verdana, Arial, Helvetica, sans-serif*/
/*}*/
.leftMenu {
    min-width:220px;
    width:288px;
    /*margin:40px auto 0 auto;*/
    float: left;
}
.menu {
    border: #bdd7f2 1px solid;
    border-top: #0080c4 4px solid;
    border-bottom: #0080c4 4px solid;
    background: #f4f9ff url(images/leftdhbg.jpg) repeat-y right;
    margin-left: 10px;
}
.menu .ListTitle {
    border-bottom: 1px #98c9ee solid;
    display: block;
    text-align: center;
    /*position: relative;*/
    height: 38px;
    line-height: 38px;
    cursor: pointer;
    /*+min-width:220px;*/

+width:100%;
}
.ListTitlePanel {
    position: relative;
}
.leftbgbt {
    position: absolute;
    background: url(images/leftbgbt.jpg) no-repeat;
    width: 11px;
    height: 52px;
    left: -11px;
    top: -4px;
}
    /*.leftbgbt {
        float:left;
        background: url(images/leftbgbt.jpg) no-repeat;
        width: 11px;
        height: 52px;
        left: 0px;
        top: 0px;
        zoom:1;
        z-index:200px;
    }
    */.leftbgbt2 {
          position: absolute;
          background: url(images/leftbgbt2.jpg) no-repeat;
          width: 11px;
          height: 48px;
          left: -11px;
          top: -1px;
      }
.menuList {
    display: block;
    height: auto;
}
.menuList div {
    height: 28px;
    line-height: 24px;
    border-bottom: 1px #98c9ee dotted;
}
.menuList div a {
    display: block;
    background: #fff;
    line-height: 28px;
    height: 28px;
    text-align: center;
    color: #185697;
    text-decoration: none;
}
.menuList div a:hover {
    color: #f30;
    background: #0080c4;
    color: #fff;
}
</style>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>--}%
<script type="text/javascript">
    $(document).ready(function() {
        var menuParent = $('.menu > .ListTitlePanel > div');//获取menu下的父层的DIV
        var menuList = $('.menuList');
        $('.menu > .menuParent > .ListTitlePanel > .ListTitle').each(function(i) {//获取列表的大标题并遍历
            $(this).click(function(){
                if($(menuList[i]).css('display') == 'none'){
                    $(menuList[i]).slideDown(300);
                }
                else{
                    $(menuList[i]).slideUp(300);
                }
            });
        });
    });
</script>

<!--右侧代码-->
<div class="span4">

    %{--<div class="t-20 mygz">--}%
    %{--<dl>--}%
    %{--<dd><p class="t">关注</p><p>1</p></dd>--}%
    %{--<dd class="border"><p class="t">分享</p><p>0</p></dd>--}%
    %{--<dd><p class="t">讨论</p><p>2</p></dd>--}%
    %{--<div class="mmclear"></div>--}%
    %{--</dl>--}%
    %{--</div>--}%

    <div class="label-div t-20 border-all">
        <div class="l-15">
            <h3 class="label-title border-b b-15 small clearfix" style="padding-bottom: 14px;">个人后台</h3>
        </div>
        <div class="label-main tody-hot l-15" style="display: table;margin-left: 0px;" >

<div class="leftMenu">
    <div class="menu">
        <div class="menuParent">
            <div class="ListTitlePanel">
                <div class="ListTitle">
                    <strong>个人中心</strong>
                    <div class="leftbgbt"> </div>
                </div>
            </div>
            <div class="menuList">
                %{--<div> <a href="${createLink(controller: "user",action: "show")}">我的信息</a></div>--}%
                <div> <a href="${createLink(controller: "user",action: "changePW")}">密码修改 </a> </div>
                <div> <a href="${createLink(controller: "user",action: "edit")}">信息修改</a></div>
            </div>
        </div>
        <div class="menuParent">
            <div class="ListTitlePanel">
                <div class="ListTitle">
                    <strong>文件中心</strong>
                    <div class="leftbgbt2"> </div>
                </div>
            </div>
            <div class="menuList">
                <div> <a href="#">我的课程</a></div>
                <div> <a href="#">课程资源</a></div>
                <div> <a href="#">班级统计</a></div>
                <div> <a href="#">课程题库</a></div>
            </div>
        </div>
        <div class="menuParent">
            <div class="ListTitlePanel">
                <div class="ListTitle">
                    <strong>任务中心</strong>
                    <div class="leftbgbt2"> </div>
                </div>
            </div>
            <div class="menuList">
                <div> <a href="#">我的帖子</a></div>
                <div> <a href="#">新回复</a></div>
                <div> <a href="#">课程板块</a></div>
                <div> <a href="#">问答中心</a></div>
            </div>
        </div>
        %{--<div class="menuParent">--}%
            %{--<div class="ListTitlePanel">--}%
                %{--<div class="ListTitle">--}%
                    %{--<strong>资源中心</strong>--}%
                    %{--<div class="leftbgbt2"> </div>--}%
                %{--</div>--}%
            %{--</div>--}%
            %{--<div class="menuList">--}%
                %{--<div> <a href="#">教学资源</a></div>--}%
                %{--<div> <a href="#">教学经历</a></div>--}%
            %{--</div>--}%
        %{--</div>--}%
    </div>
</div>


        </div>
    </div>
</div>