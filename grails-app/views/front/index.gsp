<%@ page import="com.lj.tps.status.TaskStatus; com.lj.tps.status.ContactWay; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>任务发布平台-首页</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style",file:"cxzx_list.css")}"/>
    <script  type="text/javascript">
        var max=${params.max?:10},sort="${params.sort?:''}",order="${params.order?:''}";
        function _search(condition){
           var lastSort=sort;
           if(condition.hasOwnProperty('max'))
              max=condition.max;
           if(condition.hasOwnProperty('sort'))
              sort=condition.sort;

            if(lastSort==sort)
            order=(order=='desc'?'asc':'desc');
            else
            order='desc';

           window.location.href="${createLink(controller: 'front',action:'index')}?max="+max+"&sort="+sort+"&order="+order+"&simpleDesc="+$("#search-input").val();

        }
    </script>
</head>
<body>

<div class="container pb-15">
    <div class="row">
        <div class="span16">
            <div class="clearfix pb-15" style=" position:relative;">
                <div class="pull-left classifyDIV pt-10">
                    <a class="pull-left type-css nosel">任务列表</a>
                    <a class="pull-left type-css tags ${params.sort=='crcd'?'selected':''}" readonly="true" href="javascript:void(0)" onclick="_search({sort:'crcd'})">要求完成日期
                        <g:if test="${params.sort=='crcd'&& params.order=='asc'}">↑</g:if><g:else>↓</g:else>
                    </a>
                    <a  class="pull-left type-css tags ${params.sort=='price'?'selected':''}" href="javascript:void(0)" onclick="_search({sort:'price'})">价格
                        <g:if test="${params.sort=='price'&& params.order=='asc'}">↑</g:if><g:else>↓</g:else></a>
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
                                 <g:if test="${!(taskInstance.status in [TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE.code])}">
                                     <span class="label label-success"><g:formatDate date="${taskInstance.crcd}" format="yyyy-MM-dd"/>前完成</span>
                                 </g:if>


                             </div>
                             <div class="clearfix pt-3">
                                 <div class="index-news-img span14 pull-left pt-5" style="color:red">
                                     ¥&nbsp;&nbsp;<g:formatNumber number="${taskInstance.price}" format="#.##" /> &nbsp;&nbsp;
                                     <a  target="_blank" style="font-weight: bold" href="${createLink(action: "showTask",params: [id:taskInstance.id])}">${taskInstance.simpleDesc}</a>
                                     <g:if test="${taskInstance.status==TaskStatus.TASK_BIDING.code}">
                                         <a  target="_blank" href="${createLink(controller:'front',action:'joinBid',params:[id:taskInstance.id])}" class="button button-primary" style="width:500px">竞标</a>
                                     </g:if>
                                 </div>

                             </div>
                         </div>
                     </div>
                 </g:each>

                <div class="pagination pull-right">
                    <rmp:paginateInBui action="index" total="${taskInstanceTotal}" prev="&larr;"
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




</body>
</html>