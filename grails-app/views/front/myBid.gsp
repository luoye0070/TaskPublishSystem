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
                        <a  class="pull-left type-css tags ${params.sort=='gcd'?'selected':''}" readonly="true" href="${createLink(controller: 'front',action:'myBid',params: [sort:'gcd',order:'asc'])}">保证完成日期↑</a>
                        <a  class="pull-left type-css tags ${params.sort=='price'?'selected':''}" href="${createLink(controller: 'front',action:'myBid',params: [sort:'price',order:'asc'])}">价格↑</a>
                    </div>

                </div>

        <g:if test="${bidInstanceList}">
            <g:each in="${bidInstanceList}" status="i" var="bidInstance">
                <div class="label-div b-10 border-all pb-20 pt-5" style="position: relative; padding-left: 0;">
                    <div class="news-list">
                        <div class="clearfix none-768 pl-20" style="position: absolute;top: 0;right: 15px;color:red">
                            <a class="tags-box l-10 fc999 pull-left" title="" href="#">${BidStatus.getLabel(bidInstance.status)}</a>
                            <a class="tags-box l-10 fc999 pull-left" title="" href="#">保证完成日期：<g:formatDate date="${bidInstance.gcd}" format="yyyy-MM-dd"/></a>
                        </div>
                        <div class="clearfix pt-3">
                            <div class="index-news-img span2 pull-left pt-5" style="color:red">
                                ¥&nbsp;&nbsp;${bidInstance.price}
                            </div>
                            <div class="offset1 intro">
                                <h1>
                                    <a  target="_blank" href="${createLink(action: "showTask",params: [id:bidInstance.task?.id])}">${bidInstance.task?.simpleDesc?:""}</a>
                                </h1>
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
                    <h2>还没有任务哦</h2>
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
