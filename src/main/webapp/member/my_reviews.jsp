<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 영화 평가 - MovieVoti</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- 공통 스타일 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<!-- 내 리뷰 전용 스타일 (분리됨) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/my_reviews.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="review-container">
        <div class="page-title">
            🎬 내가 평가한 영화 <span style="color:#ff2f6e;">${myReviews.size()}</span>편
        </div>

        <div class="my-review-list">
            <c:choose>
                <c:when test="${not empty myReviews}">
                    <c:forEach var="review" items="${myReviews}">
                        <div class="my-review-card">
                            <a href="${pageContext.request.contextPath}/movie/detail?id=${review.movieId}">
                                <img src="${review.posterPath}" class="review-poster" alt="포스터">
                            </a>
                            <div class="review-info">
                                <a href="${pageContext.request.contextPath}/movie/detail?id=${review.movieId}" class="m-title">
                                    ${review.movieTitle}
                                </a>
                                <div class="star-rating">
                                    <i class="fa-solid fa-star"></i> ${review.rating}점
                                </div>
                                <div class="comment-box">
                                    ${review.comment}
                                </div>
                                <span class="review-date">${review.createdAt} 작성함</span>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-msg">
                        <i class="fa-regular fa-comment-dots" style="font-size: 40px; margin-bottom: 10px;"></i>
                        <p>아직 남긴 평가가 없습니다.<br>영화를 보고 별점을 남겨보세요!</p>
                        <a href="${pageContext.request.contextPath}/index.jsp" style="color:#ff2f6e; font-weight:bold; margin-top:10px; display:inline-block;">박스오피스 보러가기</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>