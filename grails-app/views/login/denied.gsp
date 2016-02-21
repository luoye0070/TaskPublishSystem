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
                <div class="tips tips-large tips-warning tips-no-icon" style="text-align: center">
                    <div class="tips-content">
                        您没有权限发布任务包！
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
