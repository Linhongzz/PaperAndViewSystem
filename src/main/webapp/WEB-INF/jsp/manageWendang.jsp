<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>管理文档</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js"></script>
</head>
<!-- 加载公共的侧边栏 -->
<style>
    .tree {
        height: 100%;
        padding: 19px;
        margin-bottom: 20px;
        background-color: #fbfbfb;
        border: 1px solid #999;
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
        -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05)
    }

    .tree li {
        list-style-type: none;
        margin: 0;
        padding: 10px 5px 0 5px;
        position: relative
    }

    .tree li::before,
    .tree li::after {
        content: '';
        left: -20px;
        position: absolute;
        right: auto
    }

    .tree li::before {
        border-left: 1px solid #999;
        bottom: 50px;
        height: 100%;
        top: 0;
        width: 1px
    }

    .tree li::after {
        border-top: 1px solid #999;
        height: 20px;
        top: 25px;
        width: 25px
    }

    .tree li span {
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        border: 1px solid #999;
        border-radius: 5px;
        display: inline-block;
        padding: 3px 8px;
        text-decoration: none
    }

    .tree li.parent_li>span {
        cursor: pointer
    }

    .tree>ul>li::before,
    .tree>ul>li::after {
        border: 0
    }

    .tree li:last-child::before {
        height: 30px
    }

    .tree li.parent_li>span:hover,
    .tree li.parent_li>span:hover+ul li span {
        background: #eee;
        border: 1px solid #94a0b4;
        color: #000
    }

    .main {
        flex: 1;
          margin-top:40px
    }

    .contain {
        display: flex;
        height: 100vh;
    }

    .pagination {
        padding-left: 0%!important;
    }
    .tree{min-height:190%}
</style>

<body>
<div class="contain">
    <%@ include file="tree-well.jsp" %>
    <div class="main">

        <form class="form-inline" style="text-align: center">
            <div class="form-group">

                <label for="search_text">模糊查询</label>

                <input type="email" class="form-control" id="search_text" name="text" placeholder="请输入需要查询的内容">
            </div>
            <%--<button type="button" class="btn btn-default" id="search_button"></button>--%>
            <a class="btn btn-primary" href="#" id="search_button">查询</a>
        </form>
        <table class="table table-hover table-bordered ">
            <thead>
            <tr>
                <th>序号</th>
                <th>类别</th>
                <th>文档名</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="form_content">
            <c:forEach items="${sessionScope.wendangList}" var="wendang" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${wendang.leibie.leibieName}</td>
                    <td>${wendang.wendangming}</td>
                    <td><a class="btn btn-default" href="${pageContext.request.contextPath}/wendang/toUpdateWendang.do?wendangId=${wendang.id}">修改</a>
                        <a class="btn btn-danger" href="javascript:deleteWendang(${wendang.id})">删除</a></td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
        <ul class="pagination pagination-lg" id="paging">

            <li class="disabled"><a href="#">&laquo;</a></li>
            <li class="active"><a href="javascript:load(0,1)">1</a></li>
            <c:forEach begin="2" end="${sessionScope.totalWendangPage}" step="1" var="i">
                <li><a href="javascript:load(0,${i})">${i}</a></li>
            </c:forEach>
            <li><a href="javascript:load(0,2)">&raquo;</a></li>
        </ul>


    </div>
</div>

<script type="text/javascript">
    $(function () {
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
                        "<td><a class=\"btn btn-default\" href=\"${pageContext.request.contextPath}/wendang/toUpdateWendang.do?wendangId="+list[idx].id+"\">修改</a>" +
                        "<a class=\"btn btn-danger\" href=\"javascript:deleteWendang("+list[idx].id+")\">删除</a></td>" +
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
                        "<td><a class=\"btn btn-default\" href=\"${pageContext.request.contextPath}/wendang/toUpdateWendang.do?wendangId="+list[idx].id+"\">修改</a>" +
                        "<a class=\"btn btn-danger\" href=\"javascript:deleteWendang("+list[idx].id+")\">删除</a></td>" +
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

    //删除记录
    function deleteWendang(wendangId) {
        if (confirm("确认删除这条记录吗？")){//弹出确认框

            $.get("${pageContext.request.contextPath}/wendang/deleteWendang.do",{wendangId:wendangId},
                //回调函数
                function (data) {
                    alert(data.updateWendang_msg);
                    location.reload();//刷新页面
                }

            );
        }
    }
</script>
<script>
    <c:if test="${not empty sessionScope.updateWendang_msg}">

    $(function () {
        alert("${sessionScope.updateWendang_msg}")
    });
    </c:if>
    <% request.getSession().removeAttribute("updateWendang_msg");%>
</script>
</body>

<script type="text/javascript">
    $(function () {
        <%-- 展开文档管理标签--%>
        let children =  $('.wendang-manage').parent('li.parent_li').find(' > ul > li');
        children.show('fast');
        $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
    });
</script>
<%@ include file="../js/wendang/wendangComm.jsp" %>
</html>
