package com.movievoti.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.movievoti.model.dao.MovieDAO;
import com.movievoti.service.MovieApiService;
import com.movievoti.service.MovieApiService.BoxOfficeMovie;

@WebServlet("/api/autocomplete")
public class AutocompleteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("q");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 2글자 미만이면 빈 배열 반환 (불필요한 검색 방지)
        if (query == null || query.trim().length() < 2) {
            out.print("[]");
            return;
        }

        MovieDAO dao = MovieDAO.getInstance();
        MovieApiService apiService = new MovieApiService();
        
        // 1. [DB 검색] 우리 DB에 있는지 먼저 확인
        List<BoxOfficeMovie> results = dao.searchMoviesFromDB(query);
        
        // 2. [API 검색] DB 결과가 부족하면(3개 미만) 외부 API 호출
        if (results.size() < 3) {
            List<BoxOfficeMovie> apiResults = apiService.searchMovies(query);
            
            // [저장] API 결과를 DB에 저장 (다음 검색을 위한 캐싱)
            for (BoxOfficeMovie movie : apiResults) {
                dao.saveSearchResult(movie);
            }
            
            // 더 정확한 API 결과로 교체
            if (!apiResults.isEmpty()) {
                results = apiResults;
            }
        }
        
        // 3. [응답] 최대 5개만 JSON으로 변환하여 전송
        Gson gson = new Gson();
        int limit = Math.min(results.size(), 5);
        out.print(gson.toJson(results.subList(0, limit)));
    }
}