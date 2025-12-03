package com.movievoti.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.movievoti.model.dao.MovieDAO;
import com.movievoti.model.dao.ReviewDAO;
import com.movievoti.model.dto.ReviewDTO;
import com.movievoti.model.dto.UserDTO;
import com.movievoti.service.MovieApiService;
import com.movievoti.service.MovieApiService.BoxOfficeMovie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/movie/detail")
public class MovieDetailServlet extends HttpServlet {
    
    // 상세 페이지 조회
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if(idStr == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        int movieId = Integer.parseInt(idStr);
        
        // 1. 영화 정보 가져오기
        MovieDAO movieDao = MovieDAO.getInstance();
        BoxOfficeMovie movie = movieDao.getMovieById(movieId);
        
        MovieApiService apiService = new MovieApiService();
        apiService.getMovieDetail(movie);
        
        // 2. 리뷰 목록 가져오기
        ReviewDAO reviewDao = new ReviewDAO();
        ArrayList<ReviewDTO> reviews = reviewDao.getReviewsByMovieId(movieId);
        
        request.setAttribute("movie", movie);
        request.setAttribute("reviews", reviews);
        
        request.getRequestDispatcher("/movie/detail.jsp").forward(request, response);
    }

    // 리뷰 등록 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginUser");
        
        if(user == null) {
            response.sendRedirect(request.getContextPath() + "/member/login.jsp");
            return;
        }
        
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        
        ReviewDTO review = new ReviewDTO();
        review.setUserId(user.getUserId());
        review.setMovieId(movieId);
        review.setRating(rating);
        review.setComment(comment);
        
        ReviewDAO dao = new ReviewDAO();
        dao.insertReview(review);
        
        // 다시 상세 페이지로 이동
        response.sendRedirect("detail?id=" + movieId);
    }
}