<%@ page import="com.lj.tps.status.ContactWay; com.lj.tps.data.Bid" %>



<div class="row">

    <div class="control-group span12">
        <label class="control-label" for="contactWay">
            <s>*</s><g:message code="bid.contactWay.label" default="Contact Way"/>：
        </label>

        <div class="controls control-row-auto">
            <g:select name="contactWay" from="${ContactWay.getOptions()}" required="" optionKey="code" optionValue="label"
                      value="${fieldValue(bean: bidInstance, field: 'contactWay')}"
                      valueMessagePrefix="bid.contactWay"
                      style="width:60px"
            />

        </div>
    </div>


    <div class="control-group span12">
        <label class="control-label" for="contactInfo">
            <s>*</s><g:message code="bid.contactInfo.label" default="Contact Info"/>：
        </label>

        <div class="controls control-row-auto">

            <g:textField name="contactInfo" required="" value="${bidInstance?.contactInfo}"/>

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
                ${null==bidInstance?.skillDesc?"请详细说明您的技术与优势。愈真实中标率愈高哦！":bidInstance.skillDesc}
            </g:textArea>


        </div>
    </div>


    <div class="control-group span12">
        <label class="control-label" for="price">
            <s>*</s><g:message code="bid.price.label" default="Price"/>：
        </label>

        <div class="controls control-row-auto">

            <g:textField name="price" value="${fieldValue(bean: bidInstance, field: 'price')}" required=""/>

        </div>
    </div>

</div>

<div class="row">

    <div class="control-group span12">
        <label class="control-label" for="gcd">
            <s>*</s><g:message code="bid.gcd.label" default="Gcd"/>：
        </label>

        <div class="controls control-row-auto">

            <g:textField name="gcd" value="${com.lj.utils.FormatUtil.dateFormat(bidInstance?.gcd)}"/>
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



