package com.movievoti.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.movievoti.model.dao.DiaryDAO;
import com.movievoti.model.dto.DiaryDTO;
import com.movievoti.model.dto.UserDTO;

@WebServlet("/timeline/*")
public class TimelineServlet extends HttpServlet {
    
    // 타임라인 페이지 보여주기 (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.jsp");
            return;
        }

        if (action == null || "/list".equals(action)) {
            List<DiaryDTO> diaryList = DiaryDAO.getInstance().getDiariesByUserId(loginUser.getUserId());
            request.setAttribute("diaryList", diaryList);
            request.getRequestDispatcher("/member/timeline.jsp").forward(request, response);
        }
    }

    // 일기 저장하기 (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getPathInfo();
        
        if ("/write".equals(action)) {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

            DiaryDTO diary = new DiaryDTO();
            diary.setUserId(loginUser.getUserId());
            diary.setMovieTitle(request.getParameter("movieTitle"));
            // 날짜 변환 (String -> java.sql.Date)
            diary.setWatchedDate(Date.valueOf(request.getParameter("watchedDate"))); 
            diary.setLocation(request.getParameter("location"));
            diary.setCompanion(request.getParameter("companion"));
            diary.setMood(request.getParameter("mood"));
            diary.setContent(request.getParameter("content"));
            // 포스터는 검색 결과 등에서 받아온다고 가정 (input type='hidden' 활용)
            diary.setPosterPath(request.getParameter("posterPath")); 

            DiaryDAO.getInstance().insertDiary(diary);
            
            response.sendRedirect(request.getContextPath() + "/timeline/list");
        }
    }
}