<%@ page import="com.lj.tps.status.TaskStatus; com.lj.tps.status.ContactWay; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
<head>
  <title>我的任务</title>
    <meta name="layout" content="front_main"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/zx_info.css"/>
    <script type="text/javascript">
        $(function(){
            var timeOut=setTimeout(function(){
                $("#msg").hide(1000);
            },10000);
        });

        var max=${params.max?:10},sort="${params.sort?:''}",order="${params.order?:''}";
        function _search(condition){
            if(condition.hasOwnProperty('max'))
                max=condition.max;
            if(condition.hasOwnProperty('sort'))
                sort=condition.sort;
            if(condition.hasOwnProperty('order'))
                order=condition.order;

            window.location.href="${createLink(controller: 'front',action:'myTask')}?max="+max+"&sort="+sort+"&order="+order+"&simpleDesc="+$("#search-input").val();

        }
    </script>
</head>

<body>
<div id="list-task" class="content scaffold-list" role="main">


<div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>
<div class="container pb-15">
<!-- Example row of columns -->
<div class="row">

<!--右侧代码-->
<g:render template="/layouts/left_menu"/>


<div class="span12">
    <div class="clearfix pb-10" style=" position:relative;">
        <div class="pull-left classifyDIV pt-10">
            <a  class="pull-left type-css tags ${params.sort=='crcd'?'selected':''}" readonly="true" href="javascript:void(0)" onclick="_search({sort:'crcd',order:'desc'})">要求完成日期↓</a>
            <a  class="pull-left type-css tags ${params.sort=='price'?'selected':''}" href="javascript:void(0)" onclick="_search({sort:'price',order:'desc'})">价格↓</a>
        </div>
        <div style="position: absolute; right:0px; background:#06f;" class="pull-right t-20 classifySearch" >
            <input type="text" class="search-input pull-left span4" id="search-input" value="${params.simpleDesc?:''}">
            <a class="search-btn-css pull-left search-btn" title="搜索" href="javascript:void(0)" onclick="_search({})"></a>
        </div>
    </div>

    <g:if test="${taskInstanceList}">
        <g:each in="${taskInstanceList}" status="i" var="taskInstance">
            <div class="label-div b-10 border-all pb-20 pt-5" style="position: relative; padding-left: 0;">
                <div class="news-list">
                    <div class="clearfix none-768 pl-20" style="position: absolute;top: 0;right: 15px;color:red">
                        <span class="label label-success">${TaskStatus.getLabel(taskInstance.status)}</span>
                        <g:if test="${!(taskInstance.status in [TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE.code,TaskStatus.TASK_CANCEL.code])}">
                            <span class="label label-success"><g:formatDate date="${taskInstance.crcd}" format="yyyy-MM-dd"/>前完成</span>
                        </g:if>
                    </div>
                    <div class="clearfix pt-3">
                        <div class="index-news-img span14 pull-left pt-5" style="color:red">
                            ¥&nbsp;&nbsp;<g:formatNumber number="${taskInstance.price}" format="#.##" /> &nbsp;&nbsp;
                            <a  target="_blank"  style="font-weight: bold" href="${createLink(action: "showMyTask",params: [id:taskInstance.id])}">${taskInstance.simpleDesc}</a>
                            <g:if test="${taskInstance.bidderCount && taskInstance.status==com.lj.tps.status.TaskStatus.TASK_BIDING.code}">
                                <span style="color:#3399cc;font-weight: bold;font-size:16px">[${taskInstance.bidderCount}人竞标]</span>
                            </g:if>
                        </div>
                    </div>
                </div>
            </div>
        </g:each>

        <div class="pagination pull-right">
            <rmp:paginateInBui action="myTask" total="${taskInstanceTotal}" prev="&larr;"
                               next="&rarr;"
                               params="${params}"/>
        </div>
    </g:if>
    <g:else>
        <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
            <div class="tips-content">
                还没有任务哦
            </div>
        </div>
    </g:else>

</div>
</div>
</div>
</div>
<div>

</div>

</div>
</body>
</html>