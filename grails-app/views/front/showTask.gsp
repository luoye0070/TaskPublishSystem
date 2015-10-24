<%@ page import="com.lj.tps.status.ContactWay; com.lj.tps.status.TaskStatus; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>${taskInstance.simpleDesc}</title>
    <link href="${resource(dir: 'css', file: 'Validform.css')}" rel="stylesheet" type="text/css"/>
    <link href="${resource(dir: 'js/kindeditor-4.1.10/themes/default', file: 'default.css')}" rel="stylesheet"
          type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "cxzx_list.css")}"/>
    <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: "js/bui/common", file: "page-min.js")}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10', file: 'kindeditor-min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10/lang', file: 'zh_CN.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'Validform_v5.3.2_min.js')}"></script>
    <script type="text/javascript">
        BUI.use('common/page');
        $(function () {
            var timeOut = setTimeout(function () {
                if($("#msg").html()!='')
                $("#msg").hide(1000);
            }, 10000);
        });


    </script>
</head>

<body>
<!--消息-->
<div style="margin: 10px;">
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

<div class="container pb-15" id="container">
<div class="row">
<div class="span16">

<div class="clearfix pb-5" style=" position:relative;">
    <div class="pull-left classifyDIV pt-10">
        <a class="pull-left nosel">任务详情--${taskInstance?.simpleDesc}</a>
    </div>
</div>

<div class="clearfix pb-5" style=" position:relative;">
    <div class="pull-left classifyDIV pt-10">
        <span class="label label-success">要求完成日期：<g:formatDate date="${taskInstance.crcd}" format="yyyy-MM-dd"/></span>
        <span class="label label-success">${TaskStatus.getLabel(taskInstance.status)}</span>
        <span class="label label-important">¥&nbsp;&nbsp;<g:formatNumber number="${taskInstance.price}" format="#.##" /></span>
    </div>
</div>

%{--${taskInstance?.detailDesc}--}%
<textarea name="taskArea">
    ${taskInstance?.detailDesc}
</textarea>

<script type="text/javascript">

    KindEditor.ready(function (K) {
        var editor=K.create('textarea[name="taskArea"]', {
            readonlyMode : true,
            allowFileManager: true,
            langType: 'zh_CN',
            items: [ ],
            width:$("#container").width()
        });

        var autoheight=editor.edit.doc.body.scrollHeight;
        editor.edit.setHeight(autoheight);

    });
</script>

<sec:ifLoggedIn>
<g:if test="${newBid}">

<div class="clearfix pb-15" style=" position:relative;">
    <div class="pull-left classifyDIV pt-10">
        <a class="pull-left nosel">参与竞标</a>
    </div>
</div>


<g:form action="saveBid" method="post" class="form-horizontal">
    <input type="hidden" name="task.id" value="${taskInstance.id}"/>

    <div class="control-group">
        <label class="control-label" for="contactWay"><s>*</s><g:message code="bid.contactWay.label" default="Contact Way"/></label>
        <div class="controls">
            <g:select name="contactWay" from="${ContactWay.getOptions()}" required="" optionKey="code"
                      optionValue="label"
                      value="${fieldValue(bean: newBid, field: 'contactWay')}"
                      valueMessagePrefix="bid.contactWay" style="width:100px" class="input-xlarge"/>


        </div>
        <div class="mmclear"></div>
    </div>

    <div class="control-group">
        <label class="control-label" for="contactInfo"><s>*</s><g:message code="bid.contactInfo.label" default="Contact Info"/>：</label>
        <div class="controls">
            <g:textField name="contactInfo" required="" value="${newBid?.contactInfo}" class="input-xlarge"/>
        </div>
        <div class="mmclear"></div>
    </div>

    <div class="control-group">
        <label class="control-label" for="contactInfo"><s>*</s><g:message code="bid.price.label" default="Price"/>：</label>
    <div class="controls">
        <g:textField name="price" value="${fieldValue(bean: newBid, field: 'price')}" required="" class="input-xlarge"/>
    </div>
    <div class="mmclear"></div>
    </div>

    <div class="control-group">
        <label class="control-label" for="contactInfo"><s>*</s><g:message code="bid.gcd.label" default="Gcd"/>：</label>
        <div class="controls">
            <g:textField name="gcd" value="${com.lj.utils.FormatUtil.dateFormat(newBid?.gcd)}" class="input-xlarge"/>
            <!-- script start -->
            <script type="text/javascript">
                BUI.use('bui/calendar', function (Calendar) {
                    var datepicker = new Calendar.DatePicker({
                        trigger: '#gcd',
                        showTime: false,
                        autoRender: true,
                        minDate: new Date()
                    });
                });
            </script>
            <!-- script end -->

        </div>
        <div class="mmclear"></div>
    </div>

    <g:textArea name="skillDesc" maxlength="10240" required="">
        请详细说明您的技术与优势。愈真实中标率愈高哦！
    </g:textArea>

    <div style="margin-top: 5px;margin-left: 30px">
    <button type="submit" class="button button-primary">
        提交
    </button>
    </div>
</g:form>


<script type="text/javascript">
    $(function () {

        var validform = $(".form-horizontal").Validform({
            tiptype: 3,
            label: ".label",
            showAllError: true,
            ajaxPost: true,
            beforeCheck: function (curform) {
                var editor = $("textarea[name='skillDesc']");
                if (editor.html() == '<br />' || editor.html() == '') {
                    $.Showmsg("请详细说明您的技术与优势!");
                    return false;
                }
                return true;
            }, callback: function (data) {
                $.Hidemsg();
                if (data.success) {
                    window.location.href = "${createLink(controller: "front",action:"showTask",params:[id:taskInstance.id])}";
                } else {
                    alert(data.msg);
                }
            }

        });

        validform.addRule([
            {
                ele: "input[name='contactInfo']",
                datatype: 'm',
                nullmsg: "请输入联系方式！",
                errormsg: "请输入您的手机号！"
            }
        ]);


        $("select[name='contactWay']").bind("change", function () {
            var v = $(this).val();
            if (v == "2") {
                validform.addRule([
                    {
                        ele: "input[name='contactInfo']",
                        datatype: 'n',
                        nullmsg: "请输入您的QQ号码",
                        errormsg: "请输入正确的QQ号码！"
                    }
                ]);
            } else if (v == "3") {
                validform.addRule([
                    {
                        ele: "input[name='contactInfo']",
                        datatype: 'e',
                        nullmsg: "请输入您的Email！",
                        errormsg: "请输入正确的Email！"
                    }
                ]);
            } else {
                validform.addRule([
                    {
                        ele: "input[name='contactInfo']",
                        datatype: 'm',
                        nullmsg: "请输入联系方式！",
                        errormsg: "请输入您的手机号！"
                    }
                ]);
            }

            $("input[name='contactInfo']").val("");
            validform.check(false, "input[name='contactInfo']");
        });
    });

    var tip = '请详细说明您的技术与优势。愈真实中标率愈高哦！';

    var editor;

    KindEditor.ready(function (K) {
        editor = K.create('textarea[name="skillDesc"]', {
            uploadJson: '${createLink(controller: "tpsResourceFile",action: "uploadInEditor")}',
            fileManagerJson: '${createLink(controller: "tpsResourceFile",action: "manageInEditor")}',
            allowFileManager: true,
            langType: 'zh_CN',
            items: [
                'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
                'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
                'anchor', 'link', 'unlink'
            ],
            width: $("#container").width(),
            height: "300px",
            imageSizeLimit: '2M',
            imageUploadLimit: 5,
            afterFocus: function (e) {
                if (editor.html() == tip)
                    editor.html('');
            },
            afterBlur: function (e) {

                this.sync();
            }
        });
    });
</script>
</g:if>


<g:if test="${myBid}">

    <div class="clearfix pb-5" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <a class="pull-left  nosel">我的竞标</a>
        </div>
    </div>
    <div class="clearfix pb-5" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <span class="label label-success">保证完成日期：<g:formatDate date="${myBid.gcd}" format="yyyy-MM-dd"/></span>
            <g:if test="${myBid.status!=-1}">
                <span class="label label-success">${com.lj.tps.status.BidStatus.getLabel(myBid.status ?: -1)}</span>
            </g:if>
            %{--<span class="label label-success">${com.lj.tps.status.BidStatus.getLabel(myBid.status ?: -1)}</span>--}%
            <span class="label label-important">¥&nbsp;&nbsp;<g:formatNumber number="${myBid.price}" format="#.##" /></span>
        </div>
    </div>

    %{--${myBid.skillDesc ?: ""}--}%
    %{--<div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>--}%
    <textarea name="myBidArea">
        ${myBid.skillDesc ?: ""}
    </textarea>

    <script type="text/javascript">

        KindEditor.ready(function (K) {
            var editor=K.create('textarea[name="myBidArea"]', {
                readonlyMode : true,
                allowFileManager: true,
                langType: 'zh_CN',
                items: [ ],
                width: $("#container").width(),
                minHeight: "50px"
            });

            var autoheight=editor.edit.doc.body.scrollHeight;
            editor.edit.setHeight(autoheight);
        });
    </script>
</g:if>

</sec:ifLoggedIn>

<g:if test="${bidInstanceList}">
    <div class="clearfix pb-5" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <a class="pull-left  nosel">${null==myBid?"所有竞标":"其他竞标"}</a>
        </div>
    </div>
    <g:each in="${bidInstanceList}" status="i" var="curBid">
        <g:if test="${null==myBid || myBid.id.longValue()!=curBid.id.longValue()}">

            <div class="clearfix pb-5" style=" position:relative;">
                <div class="pull-left classifyDIV pt-5">
                    <span class="label label-success">竞标人：${curBid.username}</span>
                    <span class="label label-success">保证完成日期：<g:formatDate date="${curBid.gcd}" format="yyyy-MM-dd"/></span>
                    <g:if test="${curBid.status!=-1}">
                        <span class="label label-success">${com.lj.tps.status.BidStatus.getLabel(curBid.status ?: -1)}</span>
                    </g:if>
                    <span class="label label-important">¥&nbsp;&nbsp;<g:formatNumber number="${curBid.price}" format="#.##" /></span>

                    %{--<a  class=" type-button pull-left" href="${createLink(controller:"front",action:'showEvaluation',params:[evaluatedPerson:curBid.username])}" target="_blank">查看评价</a>--}%

                </div>
            </div>

            %{--${curBid.skillDesc ?: ""}--}%

            <textarea name="curBidArea_${i}">
                ${curBid.skillDesc ?: ""}
            </textarea>

            <script type="text/javascript">

                KindEditor.ready(function (K) {
                    var editor=K.create('textarea[name="curBidArea_${i}"]', {
                        readonlyMode : true,
                        allowFileManager: true,
                        langType: 'zh_CN',
                        items: [ ],
                        width: $("#container").width(),
                        minHeight:'50px'
                    });

                    var autoheight=editor.edit.doc.body.scrollHeight;
                    editor.edit.setHeight(autoheight);
                });
            </script>
        </g:if>
    </g:each>

    <div class="pagination pull-right">
        <rmp:paginateInBui action="showTask" total="${bidInstanceTotal}" prev="&larr;"
                           next="&rarr;"
                           params="${params}"/>
    </div>

</g:if>

</div>
</div>
</div>



%{--<g:render template="/layouts/comment_do_and_list"/>--}%
</body>
</html>
