<%@ page import="com.lj.utils.FormatUtil" %>
<link rel="stylesheet" type="text/css" href="${resource(dir: "pageTemplate")}/style/zx_info.css"/>


<div class="hr tp-div-nexthr" style="margin-top: 0;margin-bottom: 0;padding: 0;"></div>
<div class="container pb-15">
    <!-- Example row of columns -->
    <div class="row">

        <!--右侧代码-->
        %{--<g:render template="/layouts/left_menu"/>--}%


        <div class="span16">
            <!--内容页面-->
            <div class="label-div b-30 border-all pt-5 t-20" style="position: relative; padding-left: 0;">
                %{--<div class="mmdh pull-left"><a href="">首页</a> > <a href="">投资机构</a> > <a href="">机构标题</a></div>--}%
                %{--<div class="mmkey pull-right"><b><a href="">关键字</a></b><b><a href="">关键字</a></b><b><a href="">关键字</a></b><div class="mmclear"></div></div>--}%
                <div class="mmclear"></div>
                <div style="margin-top: 14px;" class="clearfix pb-12 pl-25 pr-25">
                    <h1 class="pull-left r-10">评论</h1>
                    %{--<div class="pull-left pt-5 none-768" style="_margin-top:-33px; _margin-left:-10px;">--}%
                    %{--<span class="like-plug-gz clearfix pull-left r-15">--}%
                    %{--<a title="感兴趣，关注一下吧" href="javascript:void(0);" class="like-btn pull-right ie6png">关注本文</a>--}%
                    %{--<span class="count pull-left t-5 d-none"></span>--}%
                    %{--</span>--}%
                    %{--</div>--}%
                </div>
                %{--<div style="margin-top: 4px;" class="clearfix pl-25 pr-25">--}%
                %{--<div class="pull-left">--}%

                %{--<span class="r-15 pull-left"><span class="fc999 l-5">2013/03/02</span></span>--}%
                %{--<span class="r-15 pull-left"><span class="fc999 l-5">涉及行业：软件</span></span>--}%
                %{--<span class="fc999 l-20 pull-left">涉及公司：--}%
                %{--<span data-obj="News" data-oid="104437" id="obj_hits" class="fc999">Google</span>--}%
                %{--</span>--}%
                %{--</div>--}%
                %{--</div>--}%
                <div class="view-main t-20 pl-25 pr-25">
                    %{--<table style="width: 100%;" class="fc333 border-all">--}%
                    %{--<tbody><tr>--}%
                    %{--<td style="padding: 5px 12px;width: 25px;font-size: 22px;text-align: center;background: #E8E8E8; line-height: 30px;color: #999">导读</td>--}%
                    %{--<td style="padding: 10px 10px 12px;line-height: 24px;">内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容</td>--}%
                    %{--</tr>--}%
                    %{--</tbody></table>--}%
                    %{--<div class="view-content" style="margin-top: 18px;">--}%
                    %{--<p>内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内 内容内容内容内容内容</p>--}%
                    %{--</div>--}%
                    <div class="label-div t-15 border-all" style="padding: 0;">
                        <div class="label-main">
                            <div class="clearfix label-public pt-25 pb-25">

                                %{--<div class="label-div b-10 border-all pb-5 pt-5 pl-5 pr-5" style="position: relative; margin-left:10px;margin-right: 10px;">--}%
                                    %{--<h1>--}%
                                        %{--<a  target="_blank" href="${createLink(action: "showMyTask",params: [id:1])}">水电费的发生的粉丝发斯沙发沙发沙发蒂芬是的发生的发生斯蒂芬斯蒂芬沙发沙发斯蒂芬是的发生的发生</a>--}%
                                    %{--</h1>--}%
                                %{--</div>--}%

                                %{--<div class="label-div b-10 border-all pb-20 pt-5" style="position: relative; margin-left:10px;margin-right: 10px;">--}%
                                    %{--<div class="news-list">--}%
                                        %{--<div class="clearfix none-768 pl-20" style="position: absolute;top: 0;right: 15px;color:red">--}%
                                            %{--<a class="tags-box l-10 fc999 pull-left" title="" href="#"></a>--}%
                                            %{--<a class="tags-box l-10 fc999 pull-left" title="" href="#">2015-09-11</a>--}%
                                        %{--</div>--}%
                                        %{--<div class="clearfix pt-15">--}%
                                            %{--<div class="index-news-img span2 pull-left pt-5" style="color:red">--}%
                                                %{--luoye_lj--}%
                                            %{--</div>--}%
                                            %{--<div class="offset1 intro">--}%
                                                %{--<h1>--}%
                                                    %{--<a  target="_blank" href="${createLink(action: "showMyTask",params: [id:1])}">算了的福建省里的风景算了的福建省了地方时间了的飞机上浪费算了的飞机上浪费时间的法律沙发垫时间的法律设计费</a>--}%
                                                %{--</h1>--}%
                                                %{--<img src="http://d.hiphotos.baidu.com/image/pic/item/0b7b02087bf40ad1719bfdb2552c11dfa9ecce67.jpg"/>--}%
                                            %{--</div>--}%
                                        %{--</div>--}%
                                    %{--</div>--}%
                                %{--</div>--}%


                                <g:if test="${taskComments}">
                                    <g:each in="${taskComments}" status="i" var="taskComment">
                                        <div class="label-div b-10 border-all pb-20 pt-5" style="position: relative; margin-left:10px;margin-right: 10px;">
                                            <div class="news-list">
                                                <div class="clearfix none-768 pl-20" style="position: absolute;top: 0;right: 15px;color:red">
                                                    <a class="tags-box l-10 fc999 pull-left" title="" href="#"></a>
                                                    <a class="tags-box l-10 fc999 pull-left" title="" href="#">${FormatUtil.dateTimeFormat(taskComment?.dateCreated)}</a>
                                                </div>
                                                <div class="clearfix pt-15">
                                                    <div class="index-news-img span2 pull-left pt-5" style="color:red">
                                                        ${taskComment?.tpsUser?.username}
                                                    </div>
                                                    <div class="offset1 intro">
                                                        ${taskComment?.commentContent}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </g:each>
                                </g:if>
                                <g:else>
                                <div style="text-align: center;">
                                    暂时还没有评论,<a href="#pl">我来抢沙发</a>
                                </div>
                                </g:else>
                            </div>
                        </div>
                    </div>

                </div>

    <div id="pl"></div>

    <div class="view-main t-20 pl-25 pr-25">
        %{--<table style="width: 100%;" class="fc333 border-all">--}%
        %{--<tbody><tr>--}%
        %{--<td style="padding: 5px 12px;width: 25px;font-size: 22px;text-align: center;background: #E8E8E8; line-height: 30px;color: #999">导读</td>--}%
        %{--<td style="padding: 10px 10px 12px;line-height: 24px;">内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容</td>--}%
        %{--</tr>--}%
        %{--</tbody></table>--}%
        %{--<div class="view-content" style="margin-top: 18px;">--}%
        %{--<p>内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内 内容内容内容内容内容</p>--}%
        %{--</div>--}%
        <div class="label-div t-15 border-all" style="padding: 0;">
            <div class="label-main">
                <div class="clearfix label-public pt-25">

                    <div class="clearfix" style="display:block;">
                        <form action="${doTaskCommentUrl}" name="pl-form" method="post">
                            <div class="pull-left public-login span10">
                                %{--<div class="pl-25 fc333">没有社会化账号，使用邮箱账号注册</div>--}%
                                <div id="msg" style="margin-left: 25px;">
                                    <g:render template="/layouts/msgs_and_errors"/>
                                </div>

                                <div class="clearfix pl-25 pt-25">
                                    %{--<div class="title pull-left fc999">--}%
                                        %{--<s>*</s>旧密码--}%
                                    %{--</div>--}%
                                    %{--<div class="pull-left l-20" style="_margin-left: 0;_width: 100px;">--}%
                                        %{--<input class="span4" name="UcenterMember[email]" id="UcenterMember_email" type="text" maxlength="128" value="" />--}%
                                        %{--<g:passwordField name="oldPass" maxlength="16" required="" value="" class="span4"/>--}%
                                    %{--</div>--}%
                                    %{--<span class="pull-left l-20 fc999 info mobileNumber_msg">请填写旧密码</span>--}%
                                    <script type="text/javascript">
                                    var commentContenteditor;
                                    KindEditor.ready(function (K) {
                                        commentContenteditor = K.create('#commentContent', {
                                            uploadJson: '${createLink(controller: "tpsResourceFile",action: "uploadInEditor")}',
                                            fileManagerJson: '${createLink(controller: "tpsResourceFile",action: "manageInEditor")}',
                                            allowFileManager: true,
                                            langType: 'zh_CN',
                                            items: [ 'undo', 'redo', '|', 'preview', 'cut', 'copy', 'paste',
                                                'plainpaste', '|', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                                                'italic', 'underline',  '|', 'image','emoticons', 'link', 'unlink'
                                            ],
                                            width: '900px',
                                            height: "300px",
                                            imageSizeLimit: '2M',
                                            imageUploadLimit: 5,
                                            afterFocus: function (e) {
                                                if (editor.html() == tip)
                                                    editor.html('');
                                            },
                                            afterBlur: function (e) {

                                                this.sync();
                                            }
                                        });
                                    });
                                    </script>
                                    <input type="hidden" name="taskId" value="${params.id}"/>
                                    <textarea name="commentContent" id="commentContent">

                                    </textarea>
                                </div>


                                <div class="clearfix pl-25 pt-25 pb-30">
                                    <div class="title pull-left l-20" style="_margin-left: 10px;">&nbsp;</div>
                                    <button type="submit" title="提交" class="pull-left button button-primary button-large">提交评论</button>
                                    %{--<span class="pull-left l-20 info fc999" style="_width: auto;_margin: 0 0 0 10px;">社会化账号<a class="l-5 sina-register-button" href="javascript:void(0)" title="注册">注册</a></span>--}%
                                </div>
                            </div>
                        %{--<div class="pull-left t-50 l-20">--}%
                        %{--<div class="label-div border-all" style="padding: 10px;width: 150px;">--}%
                        %{--<img class="lazyloadimg show_fave" src="${resource(dir: "pageTemplate")}/images/user_180.gif" style="width: 150px;height: 150px; display: block;" /></div>--}%
                        %{--<div class="center t-10"><input id="file" type='file' name="file" onChange="ajaxFileUpload()" />--}%
                        %{--<input id="new_face" type='hidden' name="new_face" value="" /></div>--}%
                        %{--<img src="http://pic.3gbizhi.com/2014/1108/20141108014348193.jpg" style="max-width: 430px;"/>--}%
                        %{--</div>--}%
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>

                <!--警告：切勿删除-->
                <!--[if IE 6]> <a class="follow-btn ie6png mmmzw"></a><![endif]-->

            </div>

        </div>

    </div>
</div>

<!--右侧代码结束-->


<!-- /container -->

<div class="container">

    <div class="hr"></div>

</div>