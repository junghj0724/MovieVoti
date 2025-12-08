<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - MovieVoti</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
    <script>
        function validateForm() {
            var pw = document.getElementById("password").value;
            var pwConfirm = document.getElementById("passwordConfirm").value;
            
            if (pw !== pwConfirm) {
                alert("비밀번호가 일치하지 않습니다.");
                document.getElementById("passwordConfirm").focus();
                return false; // 폼 전송 막기
            }
            return true; // 폼 전송 허용
        }
    </script>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="member-container">
        <h2 class="member-title">회원가입</h2>
        
        <!-- 에러 메시지 처리 -->
        <c:if test="${param.error == '1'}">
            <div class="msg-box msg-error">
                회원가입에 실패했습니다. 다시 시도해주세요.
            </div>
        </c:if>
        <c:if test="${param.error == '2'}">
            <div class="msg-box msg-error">
                비밀번호가 일치하지 않습니다.
            </div>
        </c:if>

        <!-- onsubmit으로 폼 제출 전 자바스크립트 검사 실행 -->
        <form action="${pageContext.request.contextPath}/memberAction/signup" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" name="userId" class="form-input" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">비밀번호</label>
                <input type="password" id="password" name="password" class="form-input" required>
            </div>

            <!-- 비밀번호 확인 필드 추가 -->
            <div class="form-group">
                <label class="form-label">비밀번호 확인</label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-input" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">닉네임</label>
                <input type="text" name="nickname" class="form-input" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">이메일</label>
                <input type="email" name="email" class="form-input" required>
            </div>
            
            <button type="submit" class="btn-submit">가입하기</button>
        </form>
    </div>
</body>
</html>