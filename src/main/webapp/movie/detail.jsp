<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${movie.title} - MovieVoti</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detail.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="detail-container">
        <!-- 1. 영화 정보 -->
        <div class="movie-header">
            <img src="${movie.posterPath}" class="detail-poster" alt="포스터">
            <div class="movie-meta">
                <h1>${movie.title}</h1>
                <div class="eng-title">${movie.openDt} 개봉</div>
                
                <div class="meta-list">
                	<p><strong>장르:</strong> ${empty movie.genre ? '정보 없음' : movie.genre}</p>
                    <c:if test="${not empty movie.audiAcc }">
                   		<p><strong>누적 관객:</strong> ${movie.audiAcc}</p>
                   	</c:if>
                    <p><strong>평균 별점:</strong> ⭐ ${movie.voteAverage}</p>
                </div>

                <div class="plot-box">
                    <h3>줄거리</h3>
                    <p>${empty movie.overview ? '줄거리 정보가 없습니다.' : movie.overview}</p>
                </div>
                <c:if test="${not empty movie.trailerKey}">
				    <div class="trailer-box" style="margin-top: 40px;">
				        <h3>메인 예고편</h3>
				        <div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%;">
				            <iframe src="https://www.youtube.com/embed/${movie.trailerKey}" 
				                    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border-radius: 8px;"
				                    frameborder="0" allowfullscreen>
				            </iframe>
				        </div>
				    </div>
				</c:if>
            </div>
        </div>

        <!-- 2. 리뷰 작성 및 목록 -->
        <div class="review-section">
            <h3>코멘트 (${reviews.size()})</h3>
            
            <!-- 로그인 한 경우에만 작성 폼 표시 -->
            <c:if test="${not empty sessionScope.loginUser}">
                <div class="review-form">
                    <form action="${pageContext.request.contextPath}/movie/detail" method="post">
                        <input type="hidden" name="movieId" value="${param.id}"> <!-- URL의 id 파라미터 -->
                        
                        <select name="rating" class="rating-select" required>
                            <option value="5">⭐⭐⭐⭐⭐ (5점)</option>
                            <option value="4">⭐⭐⭐⭐ (4점)</option>
                            <option value="3">⭐⭐⭐ (3점)</option>
                            <option value="2">⭐⭐ (2점)</option>
                            <option value="1">⭐ (1점)</option>
                        </select>
                        
                        <input type="text" name="comment" class="review-input" placeholder="이 영화에 대한 생각은?" required>
                        <button type="submit" class="btn-submit" style="width: auto; padding: 8px 20px; margin:0;">등록</button>
                    </form>
                </div>
            </c:if>
            
            <!-- 로그인 안 한 경우 -->
            <c:if test="${empty sessionScope.loginUser}">
                <p style="text-align:center; margin: 20px 0;">
                    로그인 후 평점을 남겨보세요. <a href="${pageContext.request.contextPath}/member/login.jsp" style="color:#ff2f6e">로그인하기</a>
                </p>
            </c:if>

            <!-- 리뷰 리스트 -->
            <div class="review-list">
                <c:forEach var="review" items="${reviews}">
                    <div class="review-item">
                        <div class="reviewer-face">${review.userNick.substring(0,1)}</div>
                        <div class="review-content">
                            <span class="u-name">
                                ${review.userNick} 
                                <span class="star-score">★ ${review.rating}</span>
                            </span>
                            <p>${review.comment}</p>
                            <span style="font-size:12px; color:#999;">${review.createdAt}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>