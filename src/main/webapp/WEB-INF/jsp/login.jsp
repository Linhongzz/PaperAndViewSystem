<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <title>login</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/media.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css" />
            <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.4.1.min.js"></script>
            <script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js"></script>
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
                background: url(${pageContext.request.contextPath}/resources/img/img_1.jpg) no-repeat;
            }
            
            .footer {
                display: inline-block;
                width: 1276px;
            }
            
            .layui-card {
                font-size: 16px;
                text-align: center;
                display: block;
               margin-top:100px;
                margin-left: 40%;
                width: 400px;
                line-height: 50px;
              
                background-color: rgba(255, 255, 255, 0.5);
            }
            
            p {
                color: black;
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
            .layui-btn{padding:0px 46px}
        </style>
        <script>
            <c:if test = "${not empty requestScope.login_msg}" >
                alert("${requestScope.login_msg}");
            </c:if>
        </script>
    <script language="javascript">
           function checkForm(){
        //判断用户名是否为空
        if(document.form1.userName.value==""||document.form1.password.value==""){
              layer.msg("用户名或密码不能为空");
        
        }else{
            //使用form对象的submit()方法，实现提交。
            document.form1.submit();        
        }
  }
     </script>
        <body>
            <div class="container">
                <div style="  display: inline-block; width: 1276px; border: 1px solid gray;">
                    <div class="background_img ">
                        <p>水电站运行管理支持系统</p>
                        <div class="layui-card">
                            <span>思考--创造机会
                   <br>  <pre>              努力--成就未来  </pre>
                </span>

                            <div class="layui-card-header">用户登录</div>
                            <div class="layui-card-body">
                                <form class="layui-form" name="form1" action="${pageContext.request.contextPath}/user/checkUser.do">
                                    <!-- //用户名输入框begin -->
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">用户名：</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="userName" id="1" lay-verify="title" autocomplete="off" placeholder="请输入用户名" class="layui-input">
                                        </div>
                                    </div>
                                    <!-- //用户名end -->
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">密&nbsp;&nbsp; 码：</label>
                                        <div class="layui-input-block">
                                            <input type="password" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-input-block">

                                            <button type="button" class="layui-btn layui-btn-normal" onclick="checkForm()" >登录</button>
                                            <button type="reset" class="layui-btn layui-btn-primary">清除</button>
                                        </div>
                                    </div>
                                    <!-- 密码框end -->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer" style="border: 1px solid gray;">桃林口水电站、河北工程大学</div>
            </div>
        </body>



        <script>
            layui.use(['form', 'layedit', 'laydate'], function() {
                var form = layui.form,
                    layer = layui.layer,
                    layedit = layui.layedit,
                    laydate = layui.laydate;

            });
        </script>

    

        </html>