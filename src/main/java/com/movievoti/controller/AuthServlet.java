package com.movievoti.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.movievoti.model.dao.UserDAO;
import com.movievoti.model.dto.UserDTO;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getPathInfo();
        
        if ("/login".equals(action)) {
            UserDTO user = UserDAO.getInstance().loginUser(
                request.getParameter("userId"), 
                request.getParameter("password")
            );
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loginUser", user);
                
                // ★ 관리자 여부 체크 후 이동 경로 분기 ★
                if (user.isAdmin()) {
                    // 관리자면 AdminServlet으로 이동 (목록 조회)
                    response.sendRedirect(request.getContextPath() + "/AdminServlet?action=list");
                } else {
                    // 일반 회원이면 메인으로 이동
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
                
            } else {
                response.sendRedirect(request.getContextPath() + "/member/login.jsp?error=1");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if ("/logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}