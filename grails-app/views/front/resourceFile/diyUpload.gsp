<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-3-26
  Time: 下午11:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="front_main"/>
   <title>上传资源文件</title>
    <link href="${resource(dir: "js/diyUpload/css", file: "webuploader.css")}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: "js/diyUpload/css", file: "diyUpload.css")}" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: "js/diyUpload/js", file: "webuploader.html5only.js")}"></script>
    <script type="text/javascript" src="${resource(dir: "js/diyUpload/js", file: "diyUpload.js")}"></script>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/zx_info.css"/>
    <style>
    *{ margin:0; padding:0;}
    #box{ margin:20px 0 0 20px }
    </style>

    <script type="text/javascript">
    $(function(){
        var upload=$('#fileDiv').diyUpload({
            url:'${createLink(controller:'tpsResourceFile',action:'diyUpload')}',
            success:function( data ) {

            },
            error:function( err ) {
                console.info( err );
            },
            buttonText : '选择文件(可以批量上传)',
            chunked:true,
            chunkSize:(${fileLimitSize}),
            //最大上传的文件数量, 总文件大小,单个文件大小(单位字节);
            fileNumLimit:50,
            fileSizeLimit:(${fileLimitSize})*50,
            fileSingleSizeLimit:(${fileLimitSize}),
            accept: {}

        });

        upload.on('uploadFinished',function(){
            if(top.topManager){
                //打开左侧菜单中配置过的页面
                top.topManager.reloadPage("resource_list_menu");
            }
        });
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
            <div class="label-div b-30 border-all pt-5 t-20" style="position: relative; padding-left: 0;display: table">
                %{--<div class="mmdh pull-left"><a href="">首页</a> > <a href="">投资机构</a> > <a href="">机构标题</a></div>--}%
                %{--<div class="mmkey pull-right"><b><a href="">关键字</a></b><b><a href="">关键字</a></b><b><a href="">关键字</a></b><div class="mmclear"></div></div>--}%
                <div class="mmclear"></div>
                <div style="margin-top: 14px;" class="clearfix pb-12 pl-25 pr-25">
                    <h1 class="pull-left r-10">资源文件上传</h1>
                    %{--<div class="pull-left pt-5 none-768" style="_margin-top:-33px; _margin-left:-10px;">--}%
                    %{--<span class="like-plug-gz clearfix pull-left r-15">--}%
                    %{--<a title="感兴趣，关注一下吧" href="javascript:void(0);" class="like-btn pull-right ie6png">关注本文</a>--}%
                    %{--<span class="count pull-left t-5 d-none"></span>--}%
                    %{--</span>--}%
                    %{--</div>--}%
                </div>

                <div id="msg" style="margin-left: 25px;">
                    <g:render template="/layouts/msgs_and_errors"/>
                </div>







    %{--<div class="view-main t-20 pl-25 pr-25">--}%

    <div id="box" style="width: 890px;">
        <div id="fileDiv" ></div>
    </div>
    %{--<div style="margin: 20px 20px;">--}%
        %{--<a href="${createLink(controller: "resourceFile",action: "upload")}">旧版文件上传入口</a>--}%
    %{--</div>--}%

    %{--</div>--}%



</div>
</div>
</div>
</div>



<!-- /container -->

<div class="container">

    <div class="hr"></div>

</div>





%{--<div id="box">--}%
    %{--<div id="fileDiv" ></div>--}%
%{--</div>--}%
%{--<div style="margin: 20px 20px;">--}%
    %{--<a href="${createLink(controller: "resourceFile",action: "upload")}">旧版文件上传入口</a>--}%
%{--</div>--}%
</body>
</html>