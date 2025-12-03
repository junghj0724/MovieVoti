package com.movievoti.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.movievoti.model.dao.ReviewDAO;
import com.movievoti.model.dto.ReviewDTO;
import com.movievoti.model.dto.UserDTO;

@WebServlet("/memberAction/reviews")
public class ReviewServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginUser");
        
        // 비로그인 시 로그인 페이지로
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.jsp");
            return;
        }
        
        // 내 리뷰 목록 가져오기
        ReviewDAO dao = new ReviewDAO();
        ArrayList<ReviewDTO> myReviews = dao.getReviewsByUserId(user.getUserId());
        
        request.setAttribute("myReviews", myReviews);
        
        request.getRequestDispatcher("/member/my_reviews.jsp").forward(request, response);
    }
}