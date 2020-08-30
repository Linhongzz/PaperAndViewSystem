<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>文档展示</title>
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
    .tree{
        min-height:190%;
    }
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
                            <td><a class="btn btn-primary" href="${pageContext.request.contextPath}/wendang/download.do?id=${wendang.id}">下载</a>
                                <a class="btn btn-primary" href="${pageContext.request.contextPath}/wendang/displayWendang.do?path=${wendang.path}&id=${wendang.id}">预览</a></td>
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
    <%@ include file="../js/wendang/wendangComm.jsp" %>
</body>
<script type="text/javascript">
    $(function () {
        <%-- 展开文档管理标签--%>
        let children =  $('.wendang-manage').parent('li.parent_li').find(' > ul > li');
        children.show('fast');
        $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
    });
</script>

</html>
