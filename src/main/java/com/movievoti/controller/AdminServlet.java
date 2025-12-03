package com.movievoti.controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.movievoti.model.dao.AdminDAO;
import com.movievoti.model.dto.UserDTO;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        AdminDAO dao = new AdminDAO();
        String viewPage = "";
        
        // 1. 기본 페이지 (회원 목록)
        if (action == null || action.equals("list")) {
            ArrayList<UserDTO> list = dao.selectAllMembers();
            request.setAttribute("memList", list);
            viewPage = "admin/member_manager.jsp"; 
            
        // 2. 회원 추가
        } else if (action.equals("insert")) {
            UserDTO user = new UserDTO();
            user.setUserId(request.getParameter("id"));
            user.setPassword(request.getParameter("pw"));
            user.setEmail(request.getParameter("email"));
            user.setNickname(request.getParameter("nick"));
            
            dao.insertMember(user);
            viewPage = "AdminServlet?action=list"; // 리다이렉트 주소도 변경
            
        // 3. 회원 수정
        } else if (action.equals("update")) {
            UserDTO user = new UserDTO();
            user.setUserId(request.getParameter("id"));
            user.setPassword(request.getParameter("pw"));
            user.setEmail(request.getParameter("email"));
            user.setNickname(request.getParameter("nick"));
            
            dao.updateMember(user);
            viewPage = "AdminServlet?action=list"; // 리다이렉트 주소도 변경
            
        // 4. 회원 강퇴
        } else if (action.equals("delete")) {
            String id = request.getParameter("id");
            dao.deleteMember(id);
            viewPage = "AdminServlet?action=list"; // 리다이렉트 주소도 변경
            
        // 5. 활동 로그 보기
        } else if (action.equals("logs")) {
            String id = request.getParameter("id");
            ArrayList<String> logs = dao.selectActivityLog(id);
            
            request.setAttribute("targetId", id);
            request.setAttribute("logs", logs);
            viewPage = "admin/member_logs.jsp";
        }
        
        // 화면 이동 로직
        if(viewPage.contains("?")) {
            response.sendRedirect(viewPage);
        } else {
            request.getRequestDispatcher(viewPage).forward(request, response);
        }
    }
}