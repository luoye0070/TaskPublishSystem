<head>
    <title>没有授权</title>
    <meta name="layout" content="front_main"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "cxzx_list.css")}"/>
</head>

<body>
<div id="list-task" class="content scaffold-list" role="main">
    <div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>
    <div class="container pb-15">
        <div class="row">
            <g:render template="/layouts/left_menu"/>
            <div class="span12 pt-20">
            <div style="margin:0 auto; width:400px;">
                <div class="tips tips-large tips-warning">
                    <span class="x-icon x-icon-error">×</span>

                    <div class="tips-content">
                        <h2>没有授权</h2>

                        <p class="auxiliary-text">
                            你可以继续操作以下内容：
                        </p>

                        <p>
                            <a class="direct-lnk" title="返回登录界面"
                               href="${createLink(controller: 'logout', action: "index")}">返回登录界面</a>
                            <a class="direct-lnk" title="返回网站首页" href="./">返回首页</a>
                        </p>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
