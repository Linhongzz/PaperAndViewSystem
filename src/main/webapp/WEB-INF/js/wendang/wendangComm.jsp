<%@page pageEncoding="UTF-8"%>
<script type="text/javascript">

$(function () {
    /*为每个叶子节点 添加点击事件 异步响应数据*/
    <c:forEach items="${sessionScope.wendangleibieList}" varStatus="s" var="leibie">
        <c:if test="${leibie.leibieId==1}">
            $("#wendang${leibie.leibieId}").click(function () {
            window.location.href = "${pageContext.request.contextPath}/wendang/toShebeishuomingshu.do";
        });
        </c:if>
        <c:if test="${leibie.leibieId!=1}">
            $("#wendang${leibie.leibieId}").click(function () {
            load(${leibie.leibieId}, 1);
        });
        </c:if>
    </c:forEach>
    /*给查询按钮添加单击事件 异步查询数据*/
    $("#search_button").click(function () {
        var text=$("#search_text").val();
        //alert(text);
        search(text,1);
    })
});
/*异步按照图纸名或者图号来查询数据，并渲染*/
function search(text,currentPage) {
    $.post("${pageContext.request.contextPath}/wendang/listWendangByFuzzyQuery.do", {text:text,currentPage:currentPage},
        /*回调函数*/
        function(json){
            /*先删除表格中现有的数据*/
            var form=$("#form_content");
            form.empty();
            /*遍历json添加表格数据*/
            var list=json.wendangList;
            $.each(list,function(idx)
            {
                var data="<tr>" +
                    "<td>"+(idx+1)+"</td>" +
                    "<td>"+list[idx].leibie.leibieName+"</td>" +
                    "<td>"+list[idx].wendangming+"</td>" +
                    "<td><a class=\"btn btn-default\" href=\"${pageContext.request.contextPath}/wendang/download.do?id="+list[idx].id+"\">下载</a>" +
                    "<a class=\"btn btn-default\" href=\"${pageContext.request.contextPath}/wendang/displayWendang.do?path=/documents/"+list[idx].path+"&id="+list[idx].id+"\">预览</a></td>" +
                    "</tr>";
                form.append(data)
            });
            var totalPage=json.totalPage;
            var currentPage=json.currentPage;
            /*修改分页标签*/
            var paging=$("#paging");
            /*清除分页条的内容*/
            paging.empty();
            if (currentPage==1){
                paging.append('<li class="disabled"><a href="#">&laquo;</a></li>');
            }
            else {
                paging.append('<li><a href="javascript:search(\''+text+'\','+(currentPage-1)+')">&laquo;</a></li>');
            }
            for (var i = 1; i <=totalPage ; i++) {
                if (currentPage==i) {
                    paging.append('<li class="active"><a href="#">'+i+'</a></li>');
                }
                else{
                    paging.append('<li><a href="javascript:search(\''+text+'\','+i+')">'+i+'</a></li>');
                }
            }
            if (currentPage==totalPage){
                paging.append('<li class="disabled"><a href="#">&raquo;</a></li>');
            }
            else {
                paging.append('<li><a href="javascript:search(\''+text+'\','+(currentPage+1)+')">&raquo;</a></li>');
            }
        });
}

/*异步按照图纸种类和当前页数查询数据并渲染页面*/
function load(leibieId,currentWendangPage) {
    $.get("${pageContext.request.contextPath}/wendang/listWendangByParams.do", {leibieId:leibieId,currentWendangPage:currentWendangPage},
        /*回调函数*/
        function(json){
            /*先删除表格中现有的数据*/
            var form=$("#form_content");
            form.empty();
            /*遍历json添加表格数据*/
            var list=json.wendangList;
            $.each(list,function(idx)
            {
                var data="<tr>" +
                    "<td>"+(idx+1)+"</td>" +
                    "<td>"+list[idx].leibie.leibieName+"</td>" +
                    "<td>"+list[idx].wendangming+"</td>" +
                    "<td><a class=\"btn btn-default\" href=\"${pageContext.request.contextPath}/wendang/download.do?id="+list[idx].id+"\">下载</a>" +
                    "<a class=\"btn btn-default\" href=\"${pageContext.request.contextPath}/wendang/displayWendang.do?path=/documents/"+list[idx].path+"&id="+list[idx].id+"\">预览</a></td>" +
                    "</tr>";
                form.append(data)
            });
            var totalPage=json.totalPage;
            var currentPage=json.currentPage;
            /*修改分页标签*/
            var paging=$("#paging");
            /*清除分页条的内容*/
            paging.empty();
            if (currentPage==1){
                paging.append('<li class="disabled"><a href="#">&laquo;</a></li>');
            }
            else {
                paging.append('<li><a href="javascript:load('+leibieId+','+(currentPage-1)+')">&laquo;</a></li>');
            }
            for (var i = 1; i <=totalPage ; i++) {
                if (currentPage==i) {
                    paging.append('<li class="active"><a href="#">'+i+'</a></li>');
                }
                else{
                    paging.append('<li><a href="javascript:load('+leibieId+','+i+')">'+i+'</a></li>');
                }
            }
            if (currentPage==totalPage){
                paging.append('<li class="disabled"><a href="#">&raquo;</a></li>');
            }
            else {
                paging.append('<li><a href="javascript:load('+leibieId+','+(currentPage+1)+')">&raquo;</a></li>');
            }
        });
}
</script>
