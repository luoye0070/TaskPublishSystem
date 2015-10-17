
<%@ page import="com.lj.tps.status.ContactWay; com.lj.tps.status.TaskStatus; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <link href="${resource(dir: 'js/bui/css', file: 'dpl-min.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/bui/css', file: 'bui-min.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/bui/css', file: 'page-min.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'css', file: 'Validform.css')}" rel="stylesheet" type="text/css"/>
        <link href="${resource(dir: 'js/kindeditor-4.1.10/themes/default', file: 'default.css')}" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.8.1.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/bui', file: 'bui-min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10', file: 'kindeditor-min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/kindeditor-4.1.10/lang', file: 'zh_CN.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'Validform_v5.3.2_min.js')}"></script>
        <script type="text/javascript">
            BUI.use('common/page');
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
        %{--<g:render template="/layouts/msgs_and_errors"/>--}%
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
		<div id="show-task" style="margin: 10px;" role="main">
            <div class="panel">
                <div class="panel-header">
                    <h3>${message(code: 'task.label', default: 'Task')}-详情</h3>
                </div>
                <div class="panel-body">
			<ol>
			
				<g:if test="${taskInstance?.simpleDesc}">
				<li>
					<span id="simpleDesc-label" class="property-label"><g:message code="task.simpleDesc.label" default="Simple Desc" /></span>
					
						<span class="property-value" aria-labelledby="simpleDesc-label"><g:fieldValue bean="${taskInstance}" field="simpleDesc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.detailDesc}">
				<li>
					<span id="detailDesc-label" class="property-label"><g:message code="task.detailDesc.label" default="Detail Desc" /></span>
					
						<span class="property-value" aria-labelledby="detailDesc-label"></span>

                    ${taskInstance?.detailDesc}
				</li>

				</g:if>
			
				<g:if test="${taskInstance?.price}">
				<li>
					<span id="price-label" class="property-label"><g:message code="task.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${taskInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.crcd}">
				<li>
					<span id="crcd-label" class="property-label"><g:message code="task.crcd.label" default="Crcd" /></span>
					
						<span class="property-value" aria-labelledby="crcd-label"><g:formatDate date="${taskInstance?.crcd}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.contactWay}">
				<li>
					<span id="contactWay-label" class="property-label"><g:message code="task.contactWay.label" default="Contact Way" /></span>
					
						<span class="property-value" aria-labelledby="contactWay-label"><g:fieldValue bean="${taskInstance}" field="contactWay"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taskInstance?.contactInfo}">
				<li>
					<span id="contactInfo-label" class="property-label"><g:message code="task.contactInfo.label" default="Contact Info" /></span>
					
						<span class="property-value" aria-labelledby="contactInfo-label"><g:fieldValue bean="${taskInstance}" field="contactInfo"/></span>
					
				</li>
				</g:if>
			

			
				<g:if test="${taskInstance?.status}">
				<li>
					<span id="status-label" class="property-label"><g:message code="task.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label">${TaskStatus.getLabel(taskInstance.status)}</span>
					
				</li>
				</g:if>
			
			</ol>
                    </div>
                </div>
            <g:if test="${newBid}">
                <div class="panel">
            <g:form action="saveBid" method="post" class="form-horizontal">
                <input type="hidden" name="task.id" value="${taskInstance.id}"/>
                    <div class="row">

                        <div class="control-group span12">
                            <label class="control-label" for="contactWay">
                                <s>*</s><g:message code="bid.contactWay.label" default="Contact Way"/>：
                            </label>

                            <div class="controls control-row-auto">
                                <g:select name="contactWay" from="${ContactWay.getOptions()}" required="" optionKey="code" optionValue="label"
                                          value="${fieldValue(bean: newBid, field: 'contactWay')}"
                                          valueMessagePrefix="bid.contactWay"   style="width:60px" />

                            </div>
                        </div>


                        <div class="control-group span12">
                            <label class="control-label" for="contactInfo">
                                <s>*</s><g:message code="bid.contactInfo.label" default="Contact Info"/>：</label>

                            <div class="controls control-row-auto">

                                <g:textField name="contactInfo" required="" value="${newBid?.contactInfo}"/>

                            </div>
                        </div>

                    </div>

                    <div class="row">

                        <div class="control-group span12">
                            <label class="control-label" for="skillDesc">
                                <s>*</s><g:message code="bid.skillDesc.label" default="Skill Desc"/>：
                            </label>

                            <div class="controls control-row-auto">
                                <g:textArea name="skillDesc"  maxlength="10240" required="">
                                    请详细说明您的技术与优势。愈真实中标率愈高哦！
                                </g:textArea>


                            </div>
                        </div>


                        <div class="control-group span12">
                            <label class="control-label" for="price">
                                <s>*</s><g:message code="bid.price.label" default="Price"/>：
                            </label>

                            <div class="controls control-row-auto">

                                <g:textField name="price" value="${fieldValue(bean: newBid, field: 'price')}" required=""/>

                            </div>
                        </div>

                    </div>

                    <div class="row">

                        <div class="control-group span12">
                            <label class="control-label" for="gcd">
                                <s>*</s><g:message code="bid.gcd.label" default="Gcd"/>：
                            </label>

                            <div class="controls control-row-auto">

                                <g:textField name="gcd" value="${com.lj.utils.FormatUtil.dateFormat(newBid?.gcd)}"/>
                                <!-- script start -->
                                <script type="text/javascript">
                                    BUI.use('bui/calendar', function (Calendar) {
                                        var datepicker = new Calendar.DatePicker({
                                            trigger: '#gcd',
                                            showTime: false,
                                            autoRender: true,
                                            minDate:new Date()
                                        });
                                    });
                                </script>
                                <!-- script end -->
                            </div>
                        </div>
                    </div>

                <div class="control-group">
                <label class="control-label">&nbsp;</label>

                <div class="controls">
                    <button type="submit" class="button">
                        提交
                    </button>
                </div>
                </div>
                  </g:form>
                </div>


                <script type="text/javascript">
                    $(function(){

                        var validform=$(".form-horizontal").Validform({
                            tiptype:3,
                            label:".label",
                            showAllError:true,
                            ajaxPost:true,
                            beforeCheck:function(curform){
                                var editor=$("textarea[name='skillDesc']");
                                if(editor.html()=='<br />' || editor.html()==''){
                                    $.Showmsg("请详细说明您的技术与优势!");
                                    return false;
                                }
                                return true;
                            },callback:function(data){
                                $.Hidemsg();
                                if(data.success){
                                    window.location.href="${createLink(controller: "front",action:"showTask",params:[id:taskInstance.id])}";
                                }else{
                                    alert(data.msg);
                                }
                            }

                        });

                        validform.addRule([{
                            ele:"input[name='contactInfo']",
                            datatype:'m',
                            nullmsg:"请输入联系方式！",
                            errormsg:"请输入您的手机号！"
                        }]);


                        $("select[name='contactWay']").bind("change",function(){
                            var v=$(this).val();
                            if(v=="2"){
                                validform.addRule([
                                    {
                                        ele:"input[name='contactInfo']",
                                        datatype:'n',
                                        nullmsg:"请输入您的QQ号码",
                                        errormsg:"请输入正确的QQ号码！"
                                    }]);
                            }else if(v=="3"){
                                validform.addRule([
                                    {
                                        ele:"input[name='contactInfo']",
                                        datatype:'e',
                                        nullmsg:"请输入您的Email！",
                                        errormsg:"请输入正确的Email！"
                                    }]);
                            } else{
                                validform.addRule([
                                    {
                                        ele:"input[name='contactInfo']",
                                        datatype:'m',
                                        nullmsg:"请输入联系方式！",
                                        errormsg:"请输入您的手机号！"
                                    }]);
                            }

                            $("input[name='contactInfo']").val("");
                            validform.check(false,"input[name='contactInfo']");
                        });
                    });

                    var tip='请详细说明您的技术与优势。愈真实中标率愈高哦！';

                    var editor;

                    KindEditor.ready(function(K) {
                        editor = K.create('textarea[name="skillDesc"]', {
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
            </g:if>
          <g:if test="${myBid}">
            <div class="panel">
                <div class="panel-header">
                    <h3>我的竞标</h3>
                </div>
                <div class="panel-body">
                    ${myBid.skillDesc?:""}
                    <br/>
                    ${fieldValue(bean: myBid, field: "username")}
                    <br/>
                    <g:formatDate date="${myBid.gcd}" format="yyyy-MM-dd"/>
                    <br/>
                    ${com.lj.tps.status.BidStatus.getLabel(myBid.status?:-1)}
                    <br/>
                    ${fieldValue(bean: myBid, field: "price")}
                </div>
            </div>
          </g:if>
            <div class="panel">
                <div class="panel-header">
                    <h3>所有竞标</h3>
                </div>
                <div class="panel-body">
                    <g:if test="${bidInstanceList}">
                        <div>
                            <table class="table table-striped table-bordered">
                                <thead>
                                <tr>

                                    <g:sortableColumn property="skillDesc"
                                                      title="${message(code: 'bid.skillDesc.label', default: 'Skill Desc')}"
                                                      params="${params}"/>


                                    <g:sortableColumn property="gcd"
                                                      title="${message(code: 'bid.gcd.label', default: 'Gcd')}" params="${params}"/>

                                    <g:sortableColumn property="username"
                                                      title="${message(code: 'bid.username.label', default: 'Username')}"
                                                      params="${params}"/>


                                    <g:sortableColumn property="status"
                                                      title="${message(code: 'bid.status.label', default: 'Status')}"
                                                      params="${params}"/>


                                </tr>
                                </thead>
                                <g:form name="form1" action="delete" params="${params}">
                                    <tbody>

                                    <g:each in="${bidInstanceList}" status="i" var="bidInstance">
                                        <tr>
                                            <td>${bidInstance.skillDesc?:""}</td>
                                            <td><g:formatDate date="${bidInstance.gcd}" format="yyyy-MM-dd"/></td>

                                            <td>${fieldValue(bean: bidInstance, field: "username")}</td>

                                            <td>${com.lj.tps.status.BidStatus.getLabel(bidInstance.status?:-1)}</td>

                                        </tr>
                                    </g:each>
                                    </tbody>
                                </g:form>
                            </table>

                            <div>

                                <div class="pagination pull-right">
                                    <!--分页-->
                                    <rmp:paginateInBui action="showMyTask" total="${bidInstanceTotal}" prev="&larr;"
                                                       next="&rarr;"
                                                       params="${params}"/>
                                </div>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
                            <div class="tips-content">
                                <h2>没有找到【${message(code: 'bid.label', default: 'Bid')}】哦</h2>
                            </div>
                        </div>
                    </g:else>
                </div>
            </div>
		</div>

	</body>
</html>
