
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    %{--<meta name="layout" content="_manage_bui"/>--}%
  <title>更新密码</title>
    <link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript">
        $(function(){
            <g:if test="${isSaveOk}">

            </g:if>
        });

        $(function(){
            var timeOut=setTimeout(function(){
                $("#msg").hide(1000);
            },10000);
        });
    </script>
</head>
<body>

<!--消息-->
<div style="margin: 10px;">
    <div id="msg">
        <g:render template="/layouts/msgs_and_errors"/>
    </div>
</div>

<div id="content" class="container">
    <form id="J_Form" class="form-horizontal" method="post" action="${createLink(controller: 'user',action:'changePW')}">
        <div class="row hide" id="stip">
            <div class="tips tips-small tips-info">
                <span class="x-icon x-icon-small x-icon-info"><i class="icon icon-white icon-info"></i></span>
                <div class="tips-content" id='smsg'></div>
            </div>
        </div>
        <div class="row hide" id="ftip">
            <div class="tips tips-small tips-warning">
                <span class="x-icon x-icon-small x-icon-error"><i class="icon icon-white icon-bell"></i></span>
                <div class="tips-content" id='fmsg'></div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="control-group">
                <label class="control-label"><s>*</s>旧密码</label>
                <div class="controls">
                    <input name="oldPass" id="oldPass" type="password" data-rules="{required:true}"  style="height:30px;width:200px">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group">
                <label class="control-label"><s>*</s>新密码</label>
                <div class="controls">
                    <input name="newPass" id="newPass" type="password" data-rules="{required:true}"  style="height:30px;width:200px">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group">
                <label class="control-label"><s>*</s>再次输入新密码</label>
                <div class="controls">
                    <input name="newPass1" type="password" id="newPass1"   data-rules="{equalTo:'#newPass'}"   style="height:30px;width:200px">
                </div>
            </div>
        </div>

        <div class="row form-actions actions-bar">
            <div class="span13 offset3 ">
                <button type="submit" class="button button-primary">
                    ${message(code: 'default.button.submit.label', default: 'Submit')}
                </button>
            </div>
        </div>
    </form>
</div>

</body>
</html>