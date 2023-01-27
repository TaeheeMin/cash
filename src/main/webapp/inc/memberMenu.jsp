<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!-- ##### Header Area Start ##### -->
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="oneMusic-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                        <!-- Nav brand -->
                        <a href="index.html" class="nav-brand"><img src="img/core-img/logo.png" alt=""></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- Close Button -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul>
                                    <li><a href="<%=request.getContextPath()%>/cash/cashMain.jsp">Home</a></li>
                                    <li><a href="<%=request.getContextPath()%>/cash/cashList.jsp">Calendar</a></li>
                                    <li><a href="<%=request.getContextPath()%>/cash/cashStats.jsp">통계</a></li>
                                    <li><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">Profile</a></li>
                                    <li><a href="<%=request.getContextPath()%>/help/helpList.jsp">Contact</a></li>
                                    <li><a href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
                                </ul>
                            </div>
                            <!-- Nav End -->
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ##### Header Area End ##### -->
    