<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- 1. 로그인 체크 -->
<c:if test="${empty sessionScope.loginUser}">
    <c:redirect url="login.jsp" />
</c:if>

<!-- 2. 비밀번호 검증 체크 (isVerified 세션이 없으면 비밀번호 확인 페이지로 튕김) -->
<c:if test="${sessionScope.isVerified != true}">
    <c:redirect url="password_check.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - MovieVoti</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="member-container wide">
        <h2 class="member-title">내 정보 수정</h2>
        
        <c:if test="${param.msg == 'updated'}">
            <div class="msg-box msg-success">
                정보가 성공적으로 수정되었습니다!
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/memberAction/update" method="post">
            <div class="form-group">
                <label class="info-label">아이디</label>
                <div class="info-value">
                    ${sessionScope.loginUser.userId}
                </div>
            </div>
            
            
            <div class="form-group">
                <label class="form-label">닉네임</label>
                <input type="text" name="nickname" value="${sessionScope.loginUser.nickname}" class="form-input" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">이메일</label>
                <input type="email" name="email" value="${sessionScope.loginUser.email}" class="form-input" required>
            </div>

            <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">

            <div class="form-group">
                <label class="form-label">새 비밀번호 (변경 원할 때만 입력)</label>
                <input type="password" name="password" class="form-input" placeholder="변경할 비밀번호">
            </div>
            
            <button type="submit" class="btn-submit dark">수정 완료</button>
        </form>
        <hr style="margin: 30px 0; border: 0; border-top: 1px solid #ddd;">
        
        <div style="text-align: right;">
            <form action="${pageContext.request.contextPath}/memberAction/delete" method="post">
                <button type="submit" 
                        onclick="return confirm('정말로 탈퇴하시겠습니까? 탈퇴 후에는 복구할 수 없습니다.');"
                        style="background: #dc3545; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;">
                    회원 탈퇴
                </button>
            </form>
        </div>
    </div>
</body>
</html>