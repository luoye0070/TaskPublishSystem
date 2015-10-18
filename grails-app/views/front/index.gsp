<%@ page import="com.lj.tps.status.TaskStatus; com.lj.tps.status.ContactWay; com.lj.tps.data.Task" %>
<!DOCTYPE html>
<html>
<head>
    <title>任务发布平台-首页</title>
    <meta name="layout" content="front_main"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style",file:"cxzx_list.css")}"/>
    <script type="text/javascript" src="${resource(dir: "js",file:"list.js")}"></script>

    <script  type="text/javascript">
        var max=${params.max?:10},sort="${params.sort?:''}",order="${params.order?:''}";
        function _search(condition){
           if(condition.hasOwnProperty('max'))
              max=condition.max;
           if(condition.hasOwnProperty('sort'))
              sort=condition.sort;
           if(condition.hasOwnProperty('order'))
             order=condition.order;

           window.location.href="${createLink(controller: 'front',action:'index')}?max="+max+"&sort="+sort+"&order="+order+"&simpleDesc="+$("#search-input").val();

        }
    </script>
</head>
<body>

<div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>
<div class="container pb-15">
    <div class="row">
        <div class="span16">
            <div class="clearfix pb-15" style=" position:relative;">
                <div class="pull-left classifyDIV pt-10">
                    <a class="pull-left type-css nosel">任务列表</a>
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
                                 <a class="tags-box l-10 fc999 pull-left" title="" href="#"><g:formatDate date="${taskInstance.crcd}" format="yyyy-MM-dd"/>完成</a>
                             </div>
                             <div class="clearfix pt-3">
                                 <div class="index-news-img spanm3 pull-left pt-5" style="color:red">
                                     ¥&nbsp;&nbsp;${taskInstance.price}
                                 </div>
                                 <div class="offset3 intro">
                                     <h1>
                                         <a  target="_blank" href="${createLink(action: "showTask",params: [id:taskInstance.id])}">${taskInstance.simpleDesc}</a>
                                     </h1>
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
                        <h2>还没有任务哦</h2>
                    </div>
                </div>
            </g:else>
        </div>
    </div>
</div>




</body>
</html>