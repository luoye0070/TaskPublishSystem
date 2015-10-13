<!DOCTYPE HTML>
<html>
<head>
    <title>资源管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="Shortcut Icon" href="${resource(dir: 'images', file: 'favicon_picc.ico')}"/>
    <link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'main.css')}" rel="stylesheet" type="text/css"/>
</head>

<body>
<div class="header">
    <div class="dl-title"><span class="">资源管理</span></div>

        <div class="dl-log">欢迎您，<span class="dl-log-user"></span>
            %{--<a href="${createLink(controller:'logout',action:'index')}" title="退出系统" class="dl-log-quit">[退出]</a>--}%
        </div>

</div>

<div class="content">
    <div class="dl-main-nav">
        <ul id="J_Nav" class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-storage">内容管理</div></li>
        </ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-conten">

    </ul>
</div>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
<script>
    BUI.use('common/main', function () {
        var config = [
            {
                id: 'resourceManage',
                menu: [
                    {
                        text: '资源文件管理',
                        items: [
                            {id: 'resource_list_menu', text: '资源文件列表', href: '${createLink(controller:"resourceFile",action:'list')}'},
                            {id: 'resource_upload_menu', text: '资源文件上传', href: '${createLink(controller:"resourceFile",action:'diyUploadPage')}'}
                        ]
                    }
                ]
            }
        ];
        new PageUtil.MainPage({
            modulesConfig: config
        });
    });

</script>
</body>
</html>