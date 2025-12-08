<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 활동 기록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css?v=3">

</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="log-container">
        <h2 class="admin-title" style="font-size: 22px; border:none; margin-bottom:10px;">
            📜 [ <span style="color:#ff2f6e;">${targetId}</span> ] 님의 활동 기록
        </h2>
        <hr style="border: 0; border-top: 1px solid #eee; margin-bottom: 20px;">
        
        <ul class="log-list">
            <c:choose>
                <c:when test="${not empty logs}">
                    <c:forEach var="log" items="${logs}">
                        <li class="log-item">${log}</li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li class="log-item" style="text-align: center; color: #999;">활동 기록이 없습니다.</li>
                </c:otherwise>
            </c:choose>
        </ul>
        
        <div style="text-align: center;">
            <button onclick="history.back()" class="btn btn-back">
                목록으로 돌아가기
            </button>
        </div>
    </div>
</body>
</html>