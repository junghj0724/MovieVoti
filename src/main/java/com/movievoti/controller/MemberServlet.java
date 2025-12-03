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

@WebServlet("/memberAction/*")
public class MemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getPathInfo();
        
        // 1. 회원가입
        if ("/signup".equals(action)) {
            String userId = request.getParameter("userId");
            String password = request.getParameter("password");
            String passwordConfirm = request.getParameter("passwordConfirm");
            String nickname = request.getParameter("nickname");
            String email = request.getParameter("email");

            if (!password.equals(passwordConfirm)) {
                response.sendRedirect(request.getContextPath() + "/member/signup.jsp?error=2");
                return;
            }

            UserDTO user = new UserDTO();
            user.setUserId(userId);
            user.setPassword(password);
            user.setNickname(nickname);
            user.setEmail(email);

            int result = UserDAO.getInstance().registerUser(user);
            
            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/member/login.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/signup.jsp?error=1");
            }
            
        } 
        // 2. 비밀번호 검증 (마이페이지 진입 전)
        else if ("/verify".equals(action)) {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
            
            if (loginUser == null) {
                response.sendRedirect(request.getContextPath() + "/member/login.jsp");
                return;
            }

            String inputPw = request.getParameter("password");
            
            if (loginUser.getPassword().equals(inputPw)) {
                // 검증 성공: 세션에 인증 플래그 저장
                session.setAttribute("isVerified", true);
                response.sendRedirect(request.getContextPath() + "/member/mypage.jsp");
            } else {
                // 검증 실패
                response.sendRedirect(request.getContextPath() + "/member/password_check.jsp?error=pw");
            }
        }
        // 3. 정보 수정 (실제 업데이트)
        else if ("/update".equals(action)) {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
            
            if (loginUser == null) {
                response.sendRedirect(request.getContextPath() + "/member/login.jsp");
                return;
            }

            // ★ 중요: 비밀번호 확인 단계를 거쳤는지(세션 플래그) 확인
            Boolean isVerified = (Boolean) session.getAttribute("isVerified");
            if (isVerified == null || !isVerified) {
                // 인증 안 된 상태로 접근 시도 시 차단
                response.sendRedirect(request.getContextPath() + "/member/password_check.jsp");
                return;
            }

            UserDTO user = new UserDTO();
            user.setUserId(loginUser.getUserId());
            user.setNickname(request.getParameter("nickname"));
            user.setEmail(request.getParameter("email"));
            
            String newPassword = request.getParameter("password");
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                user.setPassword(newPassword);
            } else {
                user.setPassword(loginUser.getPassword());
            }

            int result = UserDAO.getInstance().updateUser(user);
            if (result > 0) {
                user.setJoinDate(loginUser.getJoinDate());
                session.setAttribute("loginUser", user);
                
                // 수정 완료 후 인증 플래그 제거 (재진입 시 다시 비번 묻도록)
                session.removeAttribute("isVerified");
                
                // 편의성을 위해 '유지'하는 방식으로 코드 작성 (사용자가 계속 수정할 수도 있으니)
                session.setAttribute("isVerified", true); 
                response.sendRedirect(request.getContextPath() + "/member/mypage.jsp?msg=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/mypage.jsp?error=unknown");
            }
        }
    }
}