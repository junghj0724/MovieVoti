<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - MovieVoti</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="member-container center">
        <h2 class="member-title">로그인</h2>
        
        <c:if test="${param.error == '1'}">
            <div class="msg-box msg-error">
                아이디 또는 비밀번호가 일치하지 않습니다.
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/login" method="post">
            <div class="form-group">
                <input type="text" name="userId" placeholder="아이디" class="form-input" required>
            </div>
            <div class="form-group">
                <input type="password" name="password" placeholder="비밀번호" class="form-input" required>
            </div>
            <button type="submit" class="btn-submit">로그인</button>
        </form>
        
        <div class="member-link">
            아직 계정이 없으신가요? <a href="signup.jsp">회원가입</a>
        </div>
    </div>
</body>
</html>