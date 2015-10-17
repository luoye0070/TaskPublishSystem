<%@ page import="com.lj.tps.status.ContactWay; com.lj.tps.data.Task" %>



<div class="row">
<h2>明确需求标题和详情</h2>
<div class="control-group span12">

    <div class="controls">
       <label for="simpleDesc"></label>
        <g:textField name="simpleDesc" maxlength="150"  value="${taskInstance?.simpleDesc}" class="input-large"
                       placeholder="请用一句话概括您要做什么？比如打车App开发"
                 />

    </div>
</div>


<div class="control-group span22">

    <g:textArea name="detailDesc"  maxlength="10240"  id="detailDesc">
        ${null==taskInstance?.detailDesc?"请把任务再补充详细些吧。越清晰越具体，任务完成质量越高哦！您也可以插入图片和上传附件！":taskInstance.detailDesc}
    </g:textArea>
    <br/>
</div>


</div>

<div class="row">

<div class="control-group span12">
    <label class="control-label" for="price">
        <s>*</s><g:message code="task.price.label" default="Price" />：
    </label>
    <div class="controls control-row-auto">
        <input type="number" name="price" id="price"  value="${taskInstance?.price}" />

    </div>
</div>


<div class="control-group span12">
    <label class="control-label" for="crcd">
        <s>*</s><g:message code="task.crcd.label" default="Crcd" />：
    </label>
    <div class="controls control-row-auto">
        
            <g:textField name="crcd" value="${com.lj.utils.FormatUtil.dateFormat(taskInstance?.crcd)}"/>
            <!-- script start -->
            <script type="text/javascript">
                BUI.use('bui/calendar',function(Calendar){
                    var datepicker = new Calendar.DatePicker({
                        trigger:'#crcd',
                        showTime:false,
                        autoRender : true ,
                        minDate:new Date()
                    });
                });
            </script>
            <!-- script end -->
        
    </div>
</div>


</div>

<div class="row">
    <h2>留下联系方式</h2>
    <div class="control-group span12">
        <label class="control-label" for="contactInfo">

            <g:select name="contactWay" from="${ContactWay.getOptions()}" required="" optionKey="code" optionValue="label"
                      value="${fieldValue(bean: taskInstance, field: 'contactWay')}"
                      valueMessagePrefix="task.contactWay"
                      style="width:60px"
            />

        </label>
        <div class="controls control-row-auto">

            <g:textField name="contactInfo" required="" value="${taskInstance?.contactInfo}"/>

        </div>
    </div>

</div>

<script type="text/javascript">
    $(function(){

        var validform=$(".form-horizontal").Validform({
            tiptype:3,
            label:".label",
            showAllError:true,
            ajaxPost:false,
            beforeCheck:function(curform){
               var editor=$("textarea[name='detailDesc']");
               if(editor.html()=='<br />' || editor.html()==''){
                   $.Showmsg("请把任务再补充详细些吧!");
                  return false;
               }
               return true;
            }
        });

        validform.addRule([{
            ele:"input[name='simpleDesc']",
            datatype:"s2-50",
            nullmsg:"任务标题最多50字",
            errormsg:"任务标题填写错误，2-50字"
        },{
            ele:"input[name='price']",
            datatype:'*',
            nullmsg:"请输入您要求的价格",
            errormsg:"请输入数值！"
        },{
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

</script>



