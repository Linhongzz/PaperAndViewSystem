<%@page pageEncoding="UTF-8"%>
<div class="top" style="z-index:999;position:absolute;background: #438eb9;height: 40px;width: 100%;font-size: 22px;line-height: 40px;color: white;font-weight: bolder;padding-left: 20px;position:fixed; top:0; ">
水利支持系统
<span style="float:right;padding-right:15px;font-size:14px!important;font-weight:normal"><a class="btn-danger" href="${pageContext.request.contextPath}/user/logout.do">退出登录</a></span>
</div>
<div class="tree well" style="margin-top:40px;">
    <ul  style="margin-left: -50px;font-size: 18px;">
        <%--如果不是root或管理员就不显示该层目录--%>
        <c:if test="${sessionScope.user.role.roleId!=3}">
            <li>
                <%--有ref可以直接跳转--%>
                <span class="glyphicon-user" aria-hidden="true"> 用户管理</span>
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
            <span class="glyphicon-folder-open">图纸部分</span>
            <ul>
                <li>
                    <span><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/tuzhi/listTuzhi.do">查询图纸</a></span>
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
                        <span><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/tuzhi/toManageTuzhi.do">管理图纸</a></span>
                        <ul>
                            <li>

                                <span>
                                    <i class="icon-leaf"></i>
                                    <a id="toAddTuZhi" href="${pageContext.request.contextPath}/tuzhi/toAddTuzhi.do">上传图纸</a>
                                </span>

                            </li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </li>
            <li>
                <span class="glyphicon-folder-open">文档部分</span>
                <ul>
                    <%--<li>
                        <span><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/wendang/listWendang.do">查询文档</a></span>
                        <ul>--%>



                        <%--有ref可以直接跳转--%>
                        <c:forEach items="${sessionScope.wendangleibieList}" var="leibie" varStatus="s">
                                <c:if test="${leibie.depth==0}">
                                    <li>
                                        <span>
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
                                                        <span>
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
                            <span><i class="icon-leaf"></i><a href="${pageContext.request.contextPath}/wendang/toManageWendang.do">管理文档</a></span>
                            <ul>
                                <li>
                                <span>
                                    <i class="icon-leaf"></i>
                                    <a id="toAddWendang" href="${pageContext.request.contextPath}/wendang/toAddWendang.do">上传文档</a>
                                </span>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                </ul>
            </li>
    </ul>
</div>
