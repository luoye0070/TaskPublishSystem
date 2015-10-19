<%@ page import="com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
<head>
    <title>发布任务</title>
    <meta name="layout" content="front_main"/>
    <link href="${resource(dir: 'css', file: 'Validform.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/kindeditor-4.1.10/themes/default', file: 'default.css')}" rel="stylesheet"
          type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "xm_write.css")}"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "cxzx_list.css")}"/>
    <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10', file: 'kindeditor-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10/lang', file: 'zh_CN.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'Validform_v5.3.2_min.js')}"></script>
    <script type="text/javascript">
        var tip='请把任务再补充详细些吧。越清晰越具体，任务完成质量越高哦！您也可以插入图片和上传附件！';

        $(function(){
            <g:if test="${isSaveOk}">
            if(top.topManager){
                //打开左侧菜单中配置过的页面
                top.topManager.reloadPage("contents_list_menu");
            }
            </g:if>

        });

        $(function(){
            var timeOut=setTimeout(function(){
                $("#msg").hide(1000);
            },10000);
        });


        var editor;

        KindEditor.ready(function(K) {
            editor = K.create('textarea[name="detailDesc"]', {
                uploadJson: '${createLink(controller: "tpsResourceFile",action: "uploadInEditor")}',
                fileManagerJson: '${createLink(controller: "tpsResourceFile",action: "manageInEditor")}',
                allowFileManager: true,
                langType: 'zh_CN',
                items:[
                    'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
                    'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                    'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                    'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                    'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                    'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                    'flash', 'media','insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
                    'anchor', 'link', 'unlink'
                ],
                width:'700px',
                height:"300px",
                imageSizeLimit:'2M',
                imageUploadLimit:5,
                afterFocus: function(e){
                    if (editor.html()==tip)
                        editor.html('');
                },
                afterBlur : function(e){

                    this.sync();
                }
            });
        });
    </script>
</head>

<body>
<div class="doc-content">


    <div id="msg">

        <g:if test="${errors || flash.errors}">
            <div class="tips tips-small tips-warning">
                <span class="x-icon x-icon-small x-icon-error"><i class="icon icon-white icon-warning"></i></span>

                <div class="tips-content">${errors}${flash.errors}</div>
            </div>
        </g:if>
        <g:if test="${msgs || flash.msgs}">
            <div class="tips tips-small tips-info">
                <span class="x-icon x-icon-small x-icon-info"><i class="icon icon-white icon-info"></i></span>

                <div class="tips-content">${msgs}${flash.msgs}</div>
            </div>
        </g:if>
        <g:if test="${warnings || flash.warnings}">
            <div class="tips tips-small tips-warning">
                <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-bell"></i></span>
                <div class="tips-content">${flash.warnings}${warnings}</div>
            </div>
        </g:if>
        <g:if test="${success || flash.success}">
            <div class="tips tips-small  tips-success">
                <span class="x-icon x-icon-small x-icon-success"><i class="icon icon-white icon-ok"></i></span>
                <div class="tips-content">${flash.success}${success}</div>
            </div>
        </g:if>
        <g:if test="${question || flash.question}">
            <div class="tips tips-small">
                <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-question"></i></span>
                <div class="tips-content">${flash.question}${question}</div>
            </div>
        </g:if>
    </div>

</div>

<div class="container pb-15">
    <div class="row">
        <div class="span16">
            <div class="clearfix pb-5" style=" position:relative;">
                <div class="pull-left classifyDIV pt-10">
                    <a class="pull-left type-css nosel">发布任务</a>
                </div>
            </div>
            <g:form action="saveTask" class="form-horizontal">
                <g:render template="taskForm"/>
                <div class="control-group pt-10">
                    <label class="control-label">&nbsp;</label>
                    <div class="controls">
                        <button type="submit" class="button button-primary button-large ">
                            ${message(code: 'default.button.save.label', default: 'Save')}
                        </button>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>




</body>
</html>
