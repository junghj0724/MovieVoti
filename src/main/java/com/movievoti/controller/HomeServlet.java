package com.movievoti.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.movievoti.model.dao.MovieDAO;
import com.movievoti.service.MovieApiService.BoxOfficeMovie;

@WebServlet("/home") 
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        MovieDAO dao = MovieDAO.getInstance();

        // 1. DB 조회
        List<BoxOfficeMovie> boxOfficeList = dao.getBoxOfficeList();
        List<BoxOfficeMovie> upcomingList = dao.getUpcomingList();
        
        // 2. 데이터 저장
        request.setAttribute("boxOfficeList", boxOfficeList);
        request.setAttribute("upcomingList", upcomingList);
        
        // 3. 화면 이동 (진짜 파일인 index.jsp로 이동)
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}