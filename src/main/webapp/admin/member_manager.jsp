<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지 - 회원 관리</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css?v=3">

</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="admin-container">
        <h1 class="admin-title">[관리자] 회원 관리</h1>
        
        <!-- 회원 추가 폼 -->
        <div class="add-member-box">
            <h3 class="sub-title" style="margin-top:0;">➕ 신규 회원 수동 추가</h3>
            <form action="${pageContext.request.contextPath}/AdminServlet" method="post">
                <input type="hidden" name="action" value="insert">
                <div class="add-form-row">
                    <input type="text" name="id" placeholder="아이디" class="admin-input" required>
                    <input type="text" name="pw" placeholder="비밀번호" class="admin-input" required>
                    <input type="text" name="email" placeholder="이메일" class="admin-input">
                    <input type="text" name="nick" placeholder="닉네임" class="admin-input">
                    <button type="submit" class="btn btn-add">추가하기</button>
                </div>
            </form>
        </div>
    
        <h3 class="sub-title">📋 전체 회원 목록</h3>
        <table class="admin-table">
            <thead>
                <tr>
                    <th width="15%">ID</th>
                    <th width="15%">비밀번호</th>
                    <th width="20%">이메일</th>
                    <th width="15%">닉네임</th>
                    <th width="15%">가입일</th>
                    <th width="20%">관리 기능</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty memList}">
                        <c:forEach var="m" items="${memList}">
                            <tr>
                                <!-- Action 주소 변경 -->
                                <form action="${pageContext.request.contextPath}/AdminServlet" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <td>
                                        <input type="hidden" name="id" value="${m.userId}">
                                        ${m.userId}
                                    </td>
                                    <td><input type="text" name="pw" value="${m.password}" class="admin-input" style="width:90%"></td>
                                    <td><input type="text" name="email" value="${m.email}" class="admin-input" style="width:90%"></td>
                                    <td><input type="text" name="nick" value="${m.nickname}" class="admin-input" style="width:90%"></td>
                                    <td style="color:#888; font-size:13px;">${m.joinDate}</td>
                                    <td style="display: flex; gap: 5px; justify-content: center;">
                                        <button type="submit" class="btn btn-mod">수정</button>
                                        
                                        <!-- 링크 주소 변경 -->
                                        <button type="button" class="btn btn-del" 
                                            onclick="if(confirm('정말 강퇴하시겠습니까?')) location.href='${pageContext.request.contextPath}/AdminServlet?action=delete&id=${m.userId}'">
                                            강퇴
                                        </button>
                                        
                                        <!-- 링크 주소 변경 -->
                                        <button type="button" class="btn btn-log" 
                                            onclick="location.href='${pageContext.request.contextPath}/AdminServlet?action=logs&id=${m.userId}'">
                                            로그
                                        </button>
                                    </td>
                                </form>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="6" style="padding: 30px;">등록된 회원이 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>