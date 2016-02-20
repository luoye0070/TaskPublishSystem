<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>${evaluatedPerson ?: ""}--评价</title>

    <meta name="layout" content="front_main"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate/style", file: "cxzx_list.css")}"/>

</head>

<body>
<div id="list-task" class="content scaffold-list" role="main">
    <div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>

    <div class="container">
        <div class="row">
            <g:render template="/layouts/left_menu"/>
            <div class="span12">

                <div class="clearfix pb-5" style=" position:relative;">
                    <div class="pull-left classifyDIV pt-10">
                        <a class="pull-left type-css tags ${(params.evaluationLevel != '-1' && params.evaluationLevel != '0') ? 'selected' : ''}"
                           href="${createLink(controller: 'front', action: "showEvaluation", params: [evaluationLevel: 1, evaluatedPerson: evaluatedPerson])}">好评(${good ?: 0})</a>
                        <a class="pull-left type-css tags ${params.evaluationLevel == '0' ? 'selected' : ''}"
                           href="${createLink(controller: 'front', action: "showEvaluation", params: [evaluationLevel: 0, evaluatedPerson: evaluatedPerson])}">中评(${mid ?: 0})</a>
                        <a class="pull-left type-css tags ${params.evaluationLevel == '-1' ? 'selected' : ''}"
                           href="${createLink(controller: 'front', action: "showEvaluation", params: [evaluationLevel: -1, evaluatedPerson: evaluatedPerson])}">差评(${bad ?: 0})</a>
                    </div>
                </div>



                <g:if test="${evaluationList}">

                    <g:each in="${evaluationList}" var="evaluation">
                        <div class="label-div b-10 border-all pb-20 pt-5" style="position: relative; padding-left: 0;">
                            <div class="news-list">
                                <div class="clearfix none-768 pl-20"
                                     style="position: absolute;top: 0;right: 15px;color:red">
                                    <span class="label label-success">评价人：${evaluation.valuer}</span>
                                    <span class="label label-success">评价时间：${evaluation.evaluationTime}</span>
                                </div>

                                <div class="clearfix pt-3">
                                    <div class="index-news-img span16 pull-left pt-5" style="color:red">
                                        ¥&nbsp;&nbsp;100&nbsp;&nbsp;
                                        <a target="_blank" style="font-weight: bold"
                                           href="${createLink(action: "showMyTask", params: [id: evaluation.id])}">${evaluation.simpleDesc}</a>
                                        <span class="label label-success">${evaluation.evaluationLevel == 1 ? "好评" : (evaluation.evaluationLevel == 0 ? "中评" : "差评")}</span>
                                        <br/>
                                        <br/>

                                        <div style="color:#000000">${evaluation.evaluationContent}</div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </g:each>
                    <div class="pagination pull-right">
                        <rmp:paginateInBui action="showEvaluation" total="${evaluationCount}" prev="&larr;"
                                           next="&rarr;"
                                           params="${params}"/>
                    </div>

                </g:if>
                <g:else>
                    <div class="tips tips-large tips-info tips-no-icon" style="text-align: center">
                        <div class="tips-content">

                            <g:if test="${params.evaluationLevel == '0'}">
                                还没有中评哦。
                            </g:if>
                            <g:elseif test="${params.evaluationLevel == '-1'}">
                                还没有差评哦。
                            </g:elseif>
                            <g:else>
                                还没有好评哦。
                            </g:else>

                        </div>
                    </div>
                </g:else>

            </div>
        </div>
    </div>
</div>
</body>
</html>