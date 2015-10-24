<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>发表评价</title>

    <meta name="layout" content="front_main"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "cxzx_list.css")}"/>
    <script type="text/javascript">

        $(function(){
            var timeOut=setTimeout(function(){
                if($("#msg").html()!='')
                    $("#msg").hide(1000);
            },10000);
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
                    <a class="pull-left type-css nosel">发表评价</a>

                </div>
            </div>

            <g:form action="saveEvaluation" class="form-horizontal span12">
                <input type="hidden" name="taskId" value="${taskId}"/>
                <input type="hidden" name="bidId" value="${bidId}"/>
                <input type="hidden" name="simpleDesc"  value="${simpleDesc}"/>
                <input type="hidden" name="evaluatedPerson" value="${evaluatedPerson}"/>
                <div class="control-group ">
                    <label class="control-label" >评价人：</label>
                    <div class="controls">
                        ${evaluatedPerson}
                    </div>
                    <div class="mmclear"></div>
                </div>

                <div class="control-group">
                    <label class="control-label">参与任务：</label>
                    <div class="controls">
                        <a href="${createLink(controller: 'front',action:'showMyTask',params:[id:taskId])}" target="_blank"><span class="link">${simpleDesc}</span></a>

                    </div>
                    <div class="mmclear"></div>
                </div>

                <div class="control-group">
                    <label class="control-label"></label>
                    <div class="controls">
                        <label class=" pull-left radio " for="evaluationLevel" style="margin-top:0;padding-top:0"><input  name="evaluationLevel" type="radio" value="1">好评&nbsp;&nbsp;</label>
                        <label class=" pull-left radio " for="evaluationLevel"><input  name="evaluationLevel" type="radio" value="0">中评&nbsp;&nbsp;</label>
                        <label class="  pull-left radio " for="evaluationLevel"><input  name="evaluationLevel" type="radio" value="-1">差评</label>
                    </div>
                    <div class="mmclear"></div>
                </div>

                <div class="control-group">
                    <label class="control-label"></label>
                    <div class="controls">
                        <textArea name="evaluationContent" style="width: 400px;height: 100px" placeholder="好评" maxlength="500"></textArea>
                    </div>
                    <div class="mmclear"></div>
                </div>

                <br/>
                <br/>
                <br/>


                <div class="control-group">
                    <label class="control-label">&nbsp;</label>
                    <div class="controls">
                        <button type="button" class="button button-primary" onclick="_submit()">
                            提交评价
                        </button>
                    </div>
                </div>
            </g:form>


        </div>
    </div>
</div>

<script type="text/javascript">

    function _submit(){

        if($("input[name='evaluationLevel']:checked").val()==undefined){
            alert("请评价!");
            return false;
        }
        var editor=$("textarea[name='evaluationContent']");
        if(editor.val().trim()==''){
            alert("请输入评价内容!");
            return false;
        }

        if(editor.val().length>500){
            alert("请评价内容过长，最多500个字符!");
            return false;
        }
        $(".form-horizontal").submit();
    }

</script>

</body>
</html>