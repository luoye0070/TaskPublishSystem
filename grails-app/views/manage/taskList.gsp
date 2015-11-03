
<!DOCTYPE HTML>
<html>
<head>
    <title>任务列表</title>
    <link href="${resource(dir:'js/bui/css',file:'dpl-min.css')}" rel="stylesheet" type="text/css" />
    <link href="${resource(dir:'js/bui/css',file:'bui-min.css')}" rel="stylesheet" type="text/css" />
    <link href="${resource(dir:'js/bui/css',file:'page-min.css')}" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="container">
    <div class="row">
        <form id="searchForm" class="form-horizontal span24">

            <div class="row">

                <div class="control-group span12">
                    <label class="control-label">发布人：</label>
                    <div class="controls control-row-auto">

                        <g:textField name="username"/>

                    </div>
                </div>

            <div class="control-group span12">
                <label class="control-label">任务标题：</label>
                <div class="controls control-row-auto">

                    <g:textField name="simpleDesc"/>

                </div>
            </div>

            </div>


            <button  type="button" id="btnSearch" class="button button-primary" style="margin-left:350px">
                ${message(code: 'default.button.search.label', default: 'Search')}
            </button>



        </form>
    </div>
    <div class="search-grid-container" style="margin-bottom: 70px;">
        <div id="grid"></div>
    </div>

</div>

<script type="text/javascript" src="${resource(dir:'js',file:'jquery-1.8.1.min.js')}"></script>
<script type="text/javascript" src="${resource(dir:'js/bui',file:'bui-min.js')}"></script>
<script type="text/javascript">
    BUI.use(['common/search','bui/grid'],function (Search,Grid) {

        var  columns = [
                    {title:"标题",dataIndex:'simpleDesc',width:300},
                    {title:"发布人",dataIndex:'username',width:100},
                    {title:"发布人联系方式",dataIndex:'contactInfo',width:100},
                    {title:"价格",dataIndex:'price',width:100},
                    {title:"要求完成日期",dataIndex:'crcd',width:100},
                    {title:"状态",dataIndex:'status',width:100},
                    {title:'操作',dataIndex:'',width:200,renderer : function(value,obj){
                        var
                             delStr = '<span class="grid-command btn-del" title="删除用户信息">删除</span>';
                        return  delStr;
                    }}
                ],
                store = Search.createStore('${createLink(controller: "front",action:"getTasks4Bui")}', { autoLoad:true }),
                gridCfg = Search.createGridCfg(columns,{

                });

        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg
                }),
                grid = search.get('grid');


        //删除操作
        function delFunction(){
            var selections = grid.getSelection();
            delItems(selections);
        }

        function delItems(items){
            var ids = [];
            BUI.each(items,function(item){
                ids.push(item.id);
            });

            if(ids.length){
                BUI.Message.Confirm('确认要删除选中的记录么？',function(){
                    $.ajax({
                        type:'post',
                        dataType:'json',
                        url:'${createLink(controller: "front",action:"delTask")}',
                        data:{ids:ids.join(',')},
                        success:function(data){
                            if(data.success){
                                store.remove(items);
                                store.refresh();
                            }else{
                                BUI.Message.Alert(data.msg);
                            }
                        }
                    });
                },'question');
            }
        }

        //监听事件，删除一条记录
        grid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                delItems([record]);
            }
        });
    });
</script>

</body>
</html>