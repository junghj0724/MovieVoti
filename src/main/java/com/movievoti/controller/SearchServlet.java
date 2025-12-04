package com.movievoti.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.movievoti.model.dao.MovieDAO;
import com.movievoti.service.MovieApiService;
import com.movievoti.service.MovieApiService.BoxOfficeMovie;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            MovieDAO dao = MovieDAO.getInstance();
            MovieApiService apiService = new MovieApiService();
            
            // 1. 외부 API에서 검색 (최신 데이터 확보)
            List<BoxOfficeMovie> apiResults = apiService.searchMovies(keyword);
            
            // 2. 검색된 영화들을 우리 DB에 저장 (캐싱 & ID 생성)
            for (BoxOfficeMovie movie : apiResults) {
                // ★ [수정] upsertMovie 대신 순위를 보호하는 saveSearchResult 사용
                dao.saveSearchResult(movie); 
            }
            
            // 3. 우리 DB에서 다시 조회 (movie_id를 포함한 데이터를 가져오기 위해)
            List<BoxOfficeMovie> searchList = dao.searchMoviesFromDB(keyword);
            
            request.setAttribute("searchList", searchList);
            request.setAttribute("keyword", keyword);
        }
        
        request.getRequestDispatcher("/movie/search_result.jsp").forward(request, response);
    }
}