<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>上传图纸</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js"></script>
<style>
    form {
        padding-left: 25%;
        padding-right: 55%;
    }

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
        padding-left: 40%!important;
    }
</style>

<body>


<div class="contain">
    <%@ include file="tree-well.jsp" %>
    <div class="main">
        <form action="${pageContext.request.contextPath}/tuzhi/updateTuzhi.do" enctype="multipart/form-data" method="post">
            <%--类别pojo 图名 图号 地址--%>
            <div class="form-group has-success">
                <label class="control-label">类别</label>
                <select class="form-control" name="tuzhiLeibie" id="tuzhiLeibie">
                    <c:forEach items="${sessionScope.tuzhileibieList}" var="tuzhiLeibie" varStatus="s">
                        <c:if test="${sessionScope.changeTuzhi.leibie.leibieId==tuzhiLeibie.leibieId}">
                            <option value="${tuzhiLeibie.leibieId}" selected>${tuzhiLeibie.leibieName}</option>
                        </c:if>
                        <c:if test="${sessionScope.changeTuzhi.leibie.leibieId!=tuzhiLeibie.leibieId}">
                            <option value="${tuzhiLeibie.leibieId}">${tuzhiLeibie.leibieName}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group has-success">
                <label class="control-label" for="tuming">图名</label>
                <input type="text" class="form-control" id="tuming" name="tuming" value="${sessionScope.changeTuzhi.tuming}" >
            </div>
            <div class="form-group has-success">
                <label class="control-label" for="tuhao">图号</label>
                <input type="text" class="form-control" id="tuhao" name="tuhao" value="${sessionScope.changeTuzhi.tuhao}">
            </div>
            <button type="submit" class="btn btn-primary">确认修改</button>
        </form>
    </div>
</div>
</body>
<script>
    <c:if test="${not empty sessionScope.updateTuzhi_msg}">

    $(function () {
        alert("${sessionScope.updateTuzhi_msg}")
    });
    </c:if>
    <% request.getSession().removeAttribute("updateTuzhi_msg");%>
</script>
<script type="text/javascript">
    $(function () {
        <%-- 展开图纸管理标签--%>
        let children =  $('.tuzhi-manage').parent('li.parent_li').find(' > ul > li');
        children.show('fast');
        $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
    });
</script>
</html>
