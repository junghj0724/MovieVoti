<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header>
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">MovieVoti</a>
        <nav class="gnb">
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">홈</a></li>
                <!-- <li><a href="#">박스오피스</a></li> -->
                <li><a href="${pageContext.request.contextPath}/memberAction/reviews">영화평가</a></li>
                
                <li><a href="${pageContext.request.contextPath}/member/timeline.jsp" class="highlight">타임라인</a></li>
            </ul>
        </nav>
        <div class="right-area">
            <!-- 검색 폼 -->
            <form action="${pageContext.request.contextPath}/search" method="get" class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" name="keyword" placeholder="검색">
            </form>
            
            <div class="user-menu">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        
                        <!-- 관리자일 경우 관리자 페이지 링크 표시 -->
                        <c:if test="${sessionScope.loginUser.admin}">
                            <a href="${pageContext.request.contextPath}/AdminServlet?action=list" style="color: #292a32; font-weight: bold; margin-right: 10px;">
                                [관리자 페이지]
                            </a>
                        </c:if>
                        
                        <span class="user-greeting">${sessionScope.loginUser.nickname}님</span>
                        <a href="${pageContext.request.contextPath}/member/password_check.jsp">마이페이지</a>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="link-logout">로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/member/login.jsp">로그인</a>
                        <a href="${pageContext.request.contextPath}/member/signup.jsp" class="btn-signup">회원가입</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>