<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>用户管理</title>
    <!-- 从cdn引用bootstrap文件，所以打开时需要联网 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js"></script>
</head>
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

    .tree li.parent_li > span {
        cursor: pointer
    }

    .tree > ul > li::before,
    .tree > ul > li::after {
        border: 0
    }

    .tree li:last-child::before {
        height: 30px
    }

    .tree li.parent_li > span:hover,
    .tree li.parent_li > span:hover + ul li span {
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
        padding-left: 40%;
    }

</style>

<body>
<div class="contain">

    <!-- 左侧树形图 -->
    <%--<div class="tree well">
        <ul>
            <li>
                <span class="glyphicon-user" aria-hidden="true">用户管理</span>
                <ul>
                    <li>
                        <span><i class="icon-minus-sign"></i>
                        <a href="${pageContext.request.contextPath}/user/userList.do">显示用户</a></span>
                    </li>
                    &lt;%&ndash;用户没有添加权限
                    <c:if test="${sessionScope.user.role.roleId!=3}">

                    </c:if>&ndash;%&gt;
                    <li>
                        <span><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/user/toAddUser.do">添加用户</a> </span>
                    </li>

                </ul>
            </li>
            <li>
                <span class="glyphicon-folder-open">图纸部分</span>

                <ul>
                    <li>
                        <span><i class="icon-leaf"></i>
                            <a href="${pageContext.request.contextPath}/tuzhi/listTuzhi.do">查询图纸</a>
                        </span>
                    </li>
                    <li>
                        <span><i class="icon-leaf"></i>
                            <a href="${pageContext.request.contextPath}/document/toAddDocument.do">添加图档</a>
                        </span>
                    </li>
                </ul>
            </li>
        </ul>
    </div>--%>
    <%@ include file="tree-well.jsp" %>
    <!-- 右侧主体内容 -->
    <div class="main">
        <table class="table table-hover table-bordered ">
            <thead>
            <tr>
                <th>序号</th>
                <th>权限</th>
                <th>真实姓名</th>
                <th>用户名</th>
                <th>密码</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>


            <c:forEach var="user" items="${sessionScope.userList}" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${user.role.roleName}</td>
                    <td>${user.realName}</td>
                    <td>${user.userName}</td>
                    <td>${user.password}</td>
                    <td>
                            <%--两个按钮 修改and删除--%>
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/user/toUpdateUser.do?userId=${user.userId}" role="button">修改</a>
                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/user/deleteUser.do?userId=${user.userId}" role="button">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <ul class="pagination pagination-lg">
            <c:if test="${(sessionScope.currentPage-1)==0}">
                <li class="disabled"><a>&laquo;</a></li>
            </c:if>
            <c:if test="${(sessionScope.currentPage-1)!=0}">
                <li><a href="${pageContext.request.contextPath}/user/userList.do?pageNub=${currentPage-1}">&laquo;</a>
                </li>
            </c:if>

            <c:forEach begin="1" end="${sessionScope.userPageNum}" step="1" varStatus="s">
                <c:if test="${s.count==sessionScope.currentPage}">
                    <li class="active"><a>${s.count}</a></li>
                </c:if>
                <c:if test="${s.count!=sessionScope.currentPage}">
                    <li><a href="${pageContext.request.contextPath}/user/userList.do?pageNub=${s.count}">${s.count}</a>
                    </li>
                </c:if>
            </c:forEach>

            <c:if test="${sessionScope.currentPage==sessionScope.userPageNum}">
                <li class="disabled"><a>&raquo;</a></li>
            </c:if>
            <c:if test="${sessionScope.currentPage!=sessionScope.userPageNum}">
                <li><a href="${pageContext.request.contextPath}/user/userList.do?pageNub=${sessionScope.currentPage+1}">&raquo;</a>
                </li>
            </c:if>
        </ul>


    </div>
</div>
</body>

</html>
