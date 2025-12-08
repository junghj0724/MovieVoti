<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${empty sessionScope.loginUser}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 타임라인 - MovieVoti</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/timeline.css?v=3">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <main class="timeline-container">
        <div class="timeline-header">
            <h2>🎬 My Movie Diary</h2>
            <p>${sessionScope.loginUser.nickname}님의 영화 추억이 담긴 기록장입니다.</p>
        </div>

        <div class="timeline-list">
            <c:if test="${empty diaryList}">
                <div class="empty-msg">
                    <i class="fa-regular fa-calendar-plus"></i>
                    <p>아직 기록된 추억이 없습니다.<br>오른쪽 아래 <strong>+ 버튼</strong>을 눌러 첫 번째 일기를 써보세요!</p>
                </div>
            </c:if>

            <c:forEach var="diary" items="${diaryList}" varStatus="status">
                <div class="timeline-item ${status.index % 2 == 0 ? 'left' : 'right'}">
                    <div class="timeline-content">
                        <c:choose>
                            <c:when test="${not empty diary.posterPath}">
                                <img src="https://image.tmdb.org/t/p/w200${diary.posterPath}" 
                                     alt="Poster" 
                                     style="width: 80px; height: 120px; object-fit: cover; border-radius: 4px; flex-shrink: 0;">
                            </c:when>
                            <c:otherwise>
                                <img src="https://placehold.co/80x120?text=No+Img" 
                                     alt="No Image" 
                                     style="width: 80px; height: 120px; object-fit: cover; border-radius: 4px; flex-shrink: 0;">
                            </c:otherwise>
                        </c:choose>

                        <div style="width: 100%;">
                            <div style="margin-bottom: 8px;">
                                <span class="date-badge" style="position: static; display: inline-block;">
                                    <fmt:formatDate value="${diary.watchedDate}" pattern="yyyy.MM.dd"/>
                                </span>
                            </div>

                            <div style="display: flex; align-items: center; margin-bottom: 8px;">
                                <h3 class="movie-title" style="font-size: 1.1rem; margin: 0;">${diary.movieTitle}</h3>
                                <span class="diary-mood" title="그 날의 기분" style="margin-left: 8px;">${diary.mood}</span>
                            </div>

                            <div class="diary-tags">
                                <c:if test="${not empty diary.location}">
                                    <span><i class="fas fa-map-marker-alt"></i> ${diary.location}</span>
                                </c:if>
                                <c:if test="${not empty diary.companion}">
                                    <span><i class="fas fa-user-friends"></i> ${diary.companion}</span>
                                </c:if>
                            </div>

                            <div class="comment-text">
                                "${diary.content}"
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <div class="fab-btn" onclick="openDiaryModal()" title="일기 쓰기">
        <i class="fas fa-pen"></i>
    </div>

    <dialog id="diaryModal">
        <h3 style="margin-top: 0; margin-bottom: 20px;">📝 오늘의 영화 기록</h3>
        
        <form action="${pageContext.request.contextPath}/timeline/write" method="post" class="modal-form" autocomplete="off">
            
            <label>영화 제목 (자동완성)</label>
            <div class="autocomplete" style="position: relative; margin-bottom: 15px;">
                <input id="movieTitleInput" type="text" name="movieTitle" placeholder="영화 제목을 입력하세요" required>
                <input type="hidden" id="posterPathInput" name="posterPath">
            </div>
            
            <label>관람 날짜</label>
            <input type="date" name="watchedDate" required>
            
            <div style="display: flex; gap: 10px;">
                <div style="flex: 1;">
                    <label>장소</label>
                    <input type="text" name="location" placeholder="예: CGV, 집">
                </div>
                <div style="flex: 1;">
                    <label>함께한 사람</label>
                    <input type="text" name="companion" placeholder="예: 혼자, 연인">
                </div>
            </div>

            <label>오늘의 기분</label>
            <select name="mood">
                <option value="😍">😍 너무 좋았어</option>
                <option value="😂">😂 빵 터짐</option>
                <option value="😭">😭 눈물 펑펑</option>
                <option value="😨">😨 심장이 쫄깃</option>
                <option value="😴">😴 꿀잠 잤음</option>
                <option value="🤯">🤯 충격 그 자체</option>
            </select>
            
            <label>짧은 일기</label>
            <textarea name="content" rows="4" placeholder="그 날의 분위기나 감상을 짧게 남겨주세요." required></textarea>
            
            <div class="modal-btns">
                <button type="button" class="btn-cancel" onclick="document.getElementById('diaryModal').close()">취소</button>
                <button type="submit" class="btn-save">기록하기</button>
            </div>
        </form>
    </dialog>

    <script>
        // === 1. 모달창 열기/닫기 ===
        function openDiaryModal() {
            const dateInput = document.querySelector('input[name="watchedDate"]');
            if (!dateInput.value) {
                dateInput.value = new Date().toISOString().substring(0, 10);
            }
            document.getElementById('diaryModal').showModal();
        }
        
        const modal = document.getElementById('diaryModal');
        modal.addEventListener('click', (event) => {
            if (event.target === modal) {
                modal.close();
            }
        });

        // === 2. 영화 제목 자동완성 (디바운싱 적용) ===
        let timeout = null;
        const input = document.getElementById("movieTitleInput");
        const posterInput = document.getElementById("posterPathInput");
        
        input.addEventListener("input", function(e) {
            const val = this.value;
            closeAllLists(); 
            
            if (!val || val.length < 2) return false;
            
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                fetch('${pageContext.request.contextPath}/api/autocomplete?q=' + encodeURIComponent(val))
                .then(response => response.json())
                .then(data => {
                    showAutocompleteList(data);
                })
                .catch(err => console.error('검색 실패:', err));
            }, 300);
        });

        function showAutocompleteList(data) {
            closeAllLists();
            
            const listDiv = document.createElement("DIV");
            listDiv.setAttribute("id", input.id + "autocomplete-list");
            listDiv.setAttribute("class", "autocomplete-items");
            input.parentNode.appendChild(listDiv);
            
            data.forEach(movie => {
                const itemDiv = document.createElement("DIV");
                
                // [수정] 포스터 경로에 TMDB 도메인 추가
                let poster = movie.posterPath 
                             ? 'https://image.tmdb.org/t/p/w92' + movie.posterPath 
                             : 'https://placehold.co/30x45?text=NoImg';
                
                let year = movie.openDt ? movie.openDt.substring(0, 4) : "";
                
                itemDiv.innerHTML = `
                    <img src="\${poster}" class="autocomplete-thumb">
                    <div style="flex:1;">
                        <strong style="display:block;">\${movie.title}</strong>
                        <span style="font-size:0.8em; color:#888;">\${year}</span>
                        <input type='hidden' value='\${movie.title}'>
                        <input type='hidden' value='\${movie.posterPath}'>
                    </div>
                `;
                
                itemDiv.addEventListener("click", function(e) {
                    input.value = this.querySelector("input[type=hidden]").value;
                    posterInput.value = this.querySelectorAll("input[type=hidden]")[1].value;
                    closeAllLists();
                });
                
                listDiv.appendChild(itemDiv);
            });
        }

        function closeAllLists(elmnt) {
            var x = document.getElementsByClassName("autocomplete-items");
            for (var i = 0; i < x.length; i++) {
                if (elmnt != x[i] && elmnt != input) {
                    x[i].parentNode.removeChild(x[i]);
                }
            }
        }

        document.addEventListener("click", function (e) {
            closeAllLists(e.target);
        });
    </script>
</body>
</html>