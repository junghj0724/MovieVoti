<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${empty sessionScope.loginUser}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 타임라인 - MovieVoti</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- 공통 스타일 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- 타임라인 스타일 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/timeline.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <main class="timeline-container">
        <div class="timeline-header">
            <h2>🎨 나의 영화 기록장</h2>
            <p style="color: #666; margin-top: 10px;">
                ${sessionScope.loginUser.nickname}님이 기록한 영화 추억들입니다.
            </p>
        </div>

        <div class="timeline-list">
            <!-- 데이터가 없을 때 보여줄 메시지 -->
            <div class="empty-msg">
                <i class="fa-regular fa-calendar-xmark"></i>
                <p>아직 기록된 타임라인이 없습니다.<br>영화 일기를 작성하여 추억을 남겨보세요!</p>
                <a href="${pageContext.request.contextPath}/index.jsp">박스오피스 보러가기</a>
            </div>
        </div>
    </main>
</body>
</html>