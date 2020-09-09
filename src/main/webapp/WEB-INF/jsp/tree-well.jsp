<%@page pageEncoding="UTF-8"%>
<div class="top" style="z-index:999;position:absolute;background: #438eb9;height: 40px;width: 100%;font-size: 22px;line-height: 40px;color: white;font-weight: bolder;padding-left: 20px;position:fixed; top:0; ">
水利支持系统
<span style="float:right;padding-right:15px;font-size:14px!important;font-weight:normal">
    <a class="btn-danger" href="${pageContext.request.contextPath}/user/logout.do">退出登录</a>
</span>
</div>
<div class="tree well" style="margin-top:40px;">
    <ul  style="margin-left: -50px;font-size: 18px;">
        <%--如果不是root或管理员就不显示该层目录--%>
        <c:if test="${sessionScope.user.role.roleId!=3}">
            <li>
                <%--有ref可以直接跳转--%>
                <span class="glyphicon-user" aria-hidden="true" id="user-manage">用户管理</span>
                <ul>
                    <li>
                        <span><i class="icon-minus-sign"></i> <a href="${pageContext.request.contextPath}/user/userList.do">显示用户</a></span>
                    </li>
                    <li>
                        <span><i class="icon-leaf"></i> <a href="${pageContext.request.contextPath}/user/toAddUser.do">添加用户</a> </span>
                    </li>
                </ul>
            </li>
        </c:if>
        <li>
            <%--有ref可以直接跳转--%>
            <span class="glyphicon-folder-open tuzhi-manage">图纸部分</span>
            <ul>
                <li>
                    <span class="tuzhi-manage"><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/tuzhi/listTuzhi.do">查询图纸</a></span>
                    <ul>

                        <c:forEach items="${sessionScope.tuzhileibieList}" var="leibie" varStatus="s">
                            <li>
                                        <span>
                                            <i class="icon-leaf"></i>
                                            <a id="${leibie.leibieId}">${leibie.leibieName}</a>
                                        </span>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
                <c:if test="${sessionScope.user.role.roleId!=3}">
                    <%--有ref可以直接跳转--%>
                    <li>
                        <span class="tuzhi-manage">
                            <i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/tuzhi/toManageTuzhi.do">管理图纸</a>
                        </span>
                        <ul>
                            <li>
                                <span>
                                    <i class="icon-leaf"></i>
                                    <a id="toAddTuZhi" href="${pageContext.request.contextPath}/tuzhi/toAddTuzhi.do">上传图纸</a>
                                </span>
                            </li>
                            <li>
                                <span>
                                    <i class="icon-leaf"></i>
                                    <a id="toAddTuzhiLeibie" href="${pageContext.request.contextPath}/tuzhi/toAddTuzhiLeibie.do">添加类别</a>
                                </span>
                            </li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </li>
            <li>
                <span class="glyphicon-folder-open wendang-manage">文档部分</span>
                <ul>
                    <%--<li>
                        <span><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/wendang/listWendang.do">查询文档</a></span>
                        <ul>--%>
                        <%--有ref可以直接跳转--%>
                        <c:forEach items="${sessionScope.wendangleibieList}" var="leibie" varStatus="s">
                                <c:if test="${leibie.depth==0}">
                                    <li>
                                        <span class="wendang-manage">
                                            <c:if test="${leibie.leibieId==1}">
                                                <i class="icon-leaf"></i>
                                                <a href="${pageContext.request.contextPath}/wendang/toShebeishuomingshu.do" id="wendang${leibie.leibieId}">${leibie.leibieName}</a>
                                            </c:if>
                                            <c:if test="${leibie.leibieId!=1}">
                                                <i class="icon-leaf"></i>
                                                <a id="wendang${leibie.leibieId}">${leibie.leibieName}</a>
                                            </c:if>
                                            </span>
                                        <ul>
                                            <c:forEach items="${sessionScope.wendangleibieList}" var="leafleibie" varStatus="leafs">
                                                <c:if test="${leafleibie.depth==1&&leafleibie.parentId==leibie.leibieId}">
                                                    <li>
                                                        <span class="wendang-manage">
                                                            <i class="icon-leaf"></i>
                                                            <a id="wendang${leafleibie.leibieId}">${leafleibie.leibieName}</a>
                                                        </span>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:if>
                            </c:forEach>
                       <%-- </ul>
                    </li>--%>
                    <c:if test="${sessionScope.user.role.roleId!=3}">
                        <li>
                            <span class="wendang-manage"><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/wendang/toManageWendang.do">管理文档</a></span>
                            <ul>
                                <li>
                                <span>
                                    <i class="icon-leaf"></i>
                                    <a id="toAddWendang" href="${pageContext.request.contextPath}/wendang/toAddWendang.do">上传文档</a>
                                </span>
                                </li>
                                <li>
                                <span>
                                    <i class="icon-leaf"></i>
                                    <a id="toAddWendangLeibie" href="${pageContext.request.contextPath}/wendang/toAddWendangLeibie.do">添加类别</a>
                                </span>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                </ul>
            </li>
    </ul>
</div>
<!--树状结构动态展示-->
<script type="text/javascript">
    $(function () {
        $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
        $('.tree li.parent_li > span').on('click', function (e) {
            let children = $(this).parent('li.parent_li').find(' > ul > li');
            if (children.is(":visible")) {
                children.hide('fast');
                $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
            } else {
                children.show('fast');
                $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
            }
            e.stopPropagation();
        });
        /*初始化关闭所有的标签*/
        let children =  $('.tree li.parent_li > span').parent('li.parent_li').find(' > ul > li');
        children.hide('fast');
        $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
    });
</script>
