<head>

<title>没有授权</title>
    <link href="${resource(dir:'js/bui/css',file:'dpl-min.css')}" rel="stylesheet" type="text/css" />
    <link href="${resource(dir:'js/bui/css',file:'bui-min.css')}" rel="stylesheet" type="text/css" />
    <link href="${resource(dir:'js/bui/css',file:'page-min.css')}" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
    <script type="text/javascript">
        BUI.use('common/page');
        function closeCurrent(){
            top.topManager.closePage();
        }
    </script>
</head>

<body>
<hr>
<div class="row">
    <div class="span10 offset6">
        <div class="tips tips-large tips-warning">
            <span class="x-icon x-icon-error">×</span>
            <div class="tips-content">
                <h2>没有授权</h2>
                <p class="auxiliary-text">
                    你可以继续操作以下内容：
                </p>
                <p>
                    <a class="direct-lnk" title="返回登录界面" href="${createLink(controller:'logout',action: "index")}">返回登录界面</a>
                    <a class="direct-lnk" title="关闭该页" href="#" onclick="closeCurrent()">关闭该页</a>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
