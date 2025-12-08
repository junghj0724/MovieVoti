<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> <!-- 숫자 포맷팅용 -->

<c:if test="${empty boxOfficeList}">
    <c:redirect url="/home" />
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MovieVoti - 박스오피스</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="common/header.jsp" />

    <main>
        <!-- 1. 박스오피스 (DB 데이터) -->
        <section>
            <h2 class="section-title">일별 박스오피스 (KOFIC 기준)</h2>
            <div class="movie-list">
                <c:choose>
                    <c:when test="${not empty boxOfficeList}">
                        <c:forEach var="movie" items="${boxOfficeList}">
                            <!-- 클릭 시 상세 페이지로 이동 (movieId 전달) -->
                            <a href="${pageContext.request.contextPath}/movie/detail?id=${movie.movieId}">
                                <div class="movie-card">
                                    <div class="poster-wrapper" style="position: relative; width: 100%; padding-top: 150%; overflow: hidden; border-radius: 6px; background: #f0f0f0; border: 1px solid #eae9e8;">
                                        <div class="rank-badge">${movie.rank}</div>
                                        <img src="${movie.posterPath}" alt="${movie.title}" referrerpolicy="no-referrer"
                                             style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;">
                                    </div>
                                    <div class="movie-info">
                                        <div class="title">${movie.title}</div>
                                        <div class="sub-info">${movie.openDt} 개봉</div>
                                        <div class="rating">
                                            <!-- ★ 수정됨: 우리 사이트 평점 (myRating) 표시 ★ -->
                                            <i class="fa-solid fa-star"></i> ${movie.myRating} 
                                            <span style="color:#aaa; font-size:11px;">(${movie.voteAverage})</span>
                                        </div>
                                        <div class="stat">누적 ${movie.audiAcc}</div>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1 / -1; text-align: center; padding: 50px;">
                            <p>박스오피스 데이터를 불러오는 중입니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
        
        <!-- 2. 공개 예정작 -->
        <section>
            <h2 class="section-title">공개 예정작 (TMDB 기준)</h2>
             <div class="movie-list">
                <c:choose>
                    <c:when test="${not empty upcomingList}">
                        <c:forEach var="movie" items="${upcomingList}">
                            <!-- 클릭 시 상세 페이지로 이동 -->
                            <a href="${pageContext.request.contextPath}/movie/detail?id=${movie.movieId}">
                                <div class="movie-card">
                                    <div class="poster-wrapper" style="position: relative; width: 100%; padding-top: 150%; overflow: hidden; border-radius: 6px; background: #f0f0f0; border: 1px solid #eae9e8;">
                                        <img src="${movie.posterPath}" alt="${movie.title}" referrerpolicy="no-referrer"
                                             style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;">
                                    </div>
                                    <div class="movie-info">
                                        <div class="title">${movie.title}</div>
                                        <div class="sub-info">
                                            ${fn:substring(movie.openDt, 0, 4)} ・ 예정
                                        </div>
                                        <div class="stat">${movie.openDt} 개봉 예정</div>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1 / -1; text-align: center; padding: 50px;">
                            <p>예정작 정보를 불러올 수 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>
</body>
</html>