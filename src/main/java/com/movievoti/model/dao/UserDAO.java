package com.movievoti.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.movievoti.common.db.DBManager;
import com.movievoti.model.dto.UserDTO;

public class UserDAO {
    private static UserDAO instance = new UserDAO();
    private UserDAO() {}
    public static UserDAO getInstance() { return instance; }

    // 1. 회원가입 (role은 DB 기본값 'USER'로 자동 저장됨)
    public int registerUser(UserDTO user) {
        String sql = "INSERT INTO USERS (user_id, password, nickname, email) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getNickname());
            pstmt.setString(4, user.getEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, null);
        }
        return 0;
    }

    // 2. 로그인 (Role 정보 포함해서 조회)
    public UserDTO loginUser(String userId, String password) {
        String sql = "SELECT * FROM USERS WHERE user_id = ? AND password = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserId(rs.getString("user_id"));
                user.setPassword(rs.getString("password"));
                user.setNickname(rs.getString("nickname"));
                user.setEmail(rs.getString("email"));
                user.setJoinDate(rs.getTimestamp("join_date"));
                // ★ Role 추가
                user.setRole(rs.getString("role")); 
                
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return null;
    }

    // 3. 회원정보 수정
    public int updateUser(UserDTO user) {
        String sql = "UPDATE USERS SET nickname = ?, email = ?, password = ? WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getNickname());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getUserId());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, null);
        }
        return 0;
    }
    
    // 4. 회원 탈퇴
    public int deleteUser(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        
        String sql = "DELETE FROM USERS WHERE user_id = ?"; 

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
        return result;
    }
}