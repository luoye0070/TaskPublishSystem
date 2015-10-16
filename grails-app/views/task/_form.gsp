<%@ page import="com.lj.tps.status.ContactWay; com.lj.tps.data.Task" %>



<div class="row">
<h2>明确需求标题和详情</h2>
<div class="control-group span12">
    <div class="controls">

        <g:textField name="simpleDesc" maxlength="150" required="" value="${taskInstance?.simpleDesc}" class="input-large"/>
    </div>
</div>


<div class="control-group span22">

    <g:textArea name="detailDesc"  maxlength="10240" required="">
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

        <g:textField name="price" required="" value="${taskInstance?.price}"/>
        
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



