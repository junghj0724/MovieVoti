<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>'${keyword}' 검색 결과 - MovieVoti</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/search.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="search-container">
        <div class="search-title">
            '<span class="highlight">${keyword}</span>' 검색 결과 
            <span class="search-count">(${fn:length(searchList)}건)</span>
        </div>

        <div class="movie-list">
            <c:choose>
                <c:when test="${not empty searchList}">
                    <c:forEach var="movie" items="${searchList}">
                        <a href="${pageContext.request.contextPath}/movie/detail?id=${movie.movieId}">
                            <div class="movie-card">
                                <div class="poster-wrapper">
                                    <img src="${movie.posterPath}" alt="${movie.title}" referrerpolicy="no-referrer">
                                </div>
                                <div class="movie-info">
                                    <div class="title">${movie.title}</div>
                                    <div class="sub-info">${movie.openDt}</div>
                                    <div class="rating">
                                        <i class="fa-solid fa-star"></i> ${movie.myRating}
                                        <span style="color:#aaa; font-size:11px;">(${movie.voteAverage})</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-result">
                        <i class="fa-regular fa-face-sad-tear"></i>
                        <p>검색 결과가 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>