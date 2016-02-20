<%@ page import="com.lj.tps.status.BidStatus; com.lj.tps.status.TaskStatus; com.lj.tps.data.Bid" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="front_main"/>
    <title>我的竞标</title>

    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/zx_info.css"/>
    <script type="text/javascript">
        $(function(){
            var timeOut=setTimeout(function(){
                $("#msg").hide(1000);
            },10000);
        });
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

            window.location.href="${createLink(controller: 'front',action:'myBid')}?max="+max+"&sort="+sort+"&order="+order+"&simpleDesc="+$("#search-input").val();

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
                        <a  class="pull-left type-css tags ${params.sort=='gcd'?'selected':''}" readonly="true" href="javascript:void(0)" onclick="_search({sort:'gcd'})">要求完成日期
                           <g:if test="${params.sort=='gcd'&& params.order=='asc'}">↑</g:if><g:else>↓</g:else>
                        </a>
                        <a  class="pull-left type-css tags ${params.sort=='price'?'selected':''}"  href="javascript:void(0)" onclick="_search({sort:'price'})">价格
                            <g:if test="${params.sort=='price'&& params.order=='asc'}">↑</g:if><g:else>↓</g:else>
                        </a>
                    </div>

            </div>

        <g:if test="${bidInstanceList}">
            <g:each in="${bidInstanceList}" status="i" var="bidInstance">
                <div class="label-div b-10 border-all pb-20 pt-5" style="position: relative; padding-left: 0;">
                    <div class="news-list">
                        <div class="clearfix none-768 pl-20" style="position: absolute;top: 0;right: 15px;color:red">
                            <g:if test="${bidInstance.status==BidStatus.BID_WIN.code && bidInstance.task?.status in [TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE.code]}">
                                <span class="label label-success">${TaskStatus.getLabel(bidInstance.task?.status)}</span>
                            </g:if>
                            <g:else>
                                <g:if test="${bidInstance.status!=BidStatus.BID_WIN.code}">
                                   <span class="label label-success">${BidStatus.getLabel(bidInstance.status)}</span>
                                </g:if>
                                <span class="label label-success">保证完成日期：<g:formatDate date="${bidInstance.gcd}" format="yyyy-MM-dd"/></span>
                            </g:else>
                        </div>
                        <div class="clearfix pt-3">
                            <div class="index-news-img span14 pull-left pt-5" style="color:red">
                                ¥&nbsp;&nbsp;<g:formatNumber number="${bidInstance.price}" format="#.##" />&nbsp;&nbsp;
                                <a  target="_blank"  style="font-weight: bold" href="${createLink(action: "showTask",params: [id:bidInstance.task?.id])}">${bidInstance.task?.simpleDesc?:""}</a>
                                <g:if test="${bidInstance.status==BidStatus.BID_WIN.code && !(bidInstance.task?.status in [TaskStatus.TASK_COMPLETE.code,TaskStatus.TASK_FAILURE.code])}">
                                    <span style="color:#3399cc;font-weight: bold;font-size:16px">[竞标成功] </span>
                                </g:if>
                            </div>

                        </div>
                    </div>
                </div>
            </g:each>

            <div class="pagination pull-right">
                <rmp:paginateInBui action="myTask" total="${bidInstanceTotal}" prev="&larr;"
                                   next="&rarr;"
                                   params="${params}"/>
            </div>
        </g:if>
        <g:else>
            <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
                <div class="tips-content">
                    还没有参与竞标哦
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

</div>
</body>
</html>
