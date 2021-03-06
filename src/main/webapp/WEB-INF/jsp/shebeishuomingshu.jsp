<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>文档展示</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js"></script>
</head>
<!-- 加载公共的侧边栏 -->
<style>
<%--    缩略图大小指定--%>


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
        margin-top: 40px
    }

    .contain {
        display: flex;
        height: 100vh;
    }

    .pagination {
        padding-left: 0% !important;
    }

    .tree {
        min-height: 190%;
    }
</style>

<body>
<div class="contain">
    <%@ include file="tree-well.jsp" %>
    <%--设备说明书类别图片展示--%>
    <div class="main">
        <div class="row">
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/1haozhubianyaqi.jpg" alt="1号变压器">
                    <div class="caption">
                        <h3>1号变压器</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=2"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/3haobianyaqi.jpg" alt="3号变压器">
                    <div class="caption">
                        <h3>3号变压器</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=3"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/GISshi.jpg" alt="GIS室">
                    <div class="caption">
                        <h3>GIS室</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=4"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/changneiqizhongji.jpg" alt="厂内起重机">
                    <div class="caption">
                        <h3>厂内起重机</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=5"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/yaliguan.jpg" alt="压力罐">
                    <div class="caption">
                        <h3>压力罐</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=6"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/fadianji.jpg" alt="发电机">
                    <div class="caption">
                        <h3>发电机</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=7"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/shuilunfadianji.jpg" alt="水轮发电机">
                    <div class="caption">
                        <h3>水轮发电机</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=8"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/shuilunji.jpg" alt="水轮机">
                    <div class="caption">
                        <h3>水轮机</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=9"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/kongyajijiyaliguan.jpg" alt="空压机及压力罐">
                    <div class="caption">
                        <h3>空压机及压力罐</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=10"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <img src="${pageContext.request.contextPath}/resources/img/peidianzhuangzhi.jpg" alt="配电装置">
                    <div class="caption">
                        <h3>配电装置</h3>
                        <p>
                            <a href="${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=11"
                               class="btn btn-primary" role="button">查看说明书</a></p>
                    </div>
                </div>
            </div>

        </div>


    </div>
</div>
</body>

<script type="text/javascript">
    $(function () {
        <%-- 展开文档管理标签--%>
        let children =  $('.wendang-manage').parent('li.parent_li').find(' > ul > li');
        children.show('fast');
        $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
    });
</script>
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
           window.location.href = "${pageContext.request.contextPath}/wendang/listWendangByParamsRedirect.do?leibieId=${leibie.leibieId}";
        });
        </c:if>
        </c:forEach>
    });
</script>
</html>
