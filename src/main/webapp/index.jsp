<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    pageContext.setAttribute("path", request.getContextPath());
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>index</title>
    <link rel="stylesheet" href="resources/media.css">
    <link rel="stylesheet" href="resources/layui/css/layui.css"/>
    <script src="resources/layui/layui.all.js"></script>
    <script src="https://cdn.bootcss.com/jquery/3.4.0/jquery.js"></script>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    .container {
        text-align: center;
    }

    .background_img {
        display: inline-block;
        width: 1261px;
        height: 946px;
        background-image: url(resources/img/img_2.jpg);
    }

    .card {
        font-size: 16px;
        text-align: center;
        display: block;
        top: 60%;
        margin-left: 650px;
        width: 600px;
        line-height: 30px;
        position: relative;
    }

    p {
        color: red;
        margin-top: 210px;
        font-size: 3rem;
        font-weight: bold;
        font-family: 'STXingkai', Courier;
        letter-spacing: 10px;
    }

    span,
    pre {
        color: yellow;
        font-family: 'STXingkai', Courier;
        font-size: 28px;
    }
</style>

<body>
<div class="container">
    <div class="background_img">

        <p>水电站运行管理支持系统</p>
        <div class="card">

                <span>精品之上 精诚服务 精益求精
                   <br>  <pre>                  比别人多做一点，做得更好一点  </pre>
                </span>
            <a href="${path}/user/login.do">点击进入登录页面</a>

        </div>

    </div>
</div>
</body>




<script>
</script>

</html>
