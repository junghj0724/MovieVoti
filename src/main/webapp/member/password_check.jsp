<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- 로그인 안 된 상태면 로그인 페이지로 -->
<c:if test="${empty sessionScope.loginUser}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 확인 - MovieVoti</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="member-container center">
        <h2 class="member-title">본인 확인</h2>
        
        <p style="margin-bottom: 20px; color: #666; font-size: 14px;">
            개인정보를 안전하게 보호하기 위해<br>
            비밀번호를 다시 한번 입력해주세요.
        </p>

        <!-- 에러 메시지 -->
        <c:if test="${param.error == 'pw'}">
            <div class="msg-box msg-error">
                비밀번호가 일치하지 않습니다.
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/memberAction/verify" method="post">
            <div class="form-group">
                <input type="password" name="password" placeholder="비밀번호" class="form-input" required autofocus>
            </div>
            <button type="submit" class="btn-submit">확인</button>
        </form>
    </div>
</body>
</html>