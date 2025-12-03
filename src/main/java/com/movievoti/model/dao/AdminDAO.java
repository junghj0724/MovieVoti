package com.movievoti.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.movievoti.common.db.DBManager;
import com.movievoti.model.dto.UserDTO;

public class AdminDAO {
    
    // 1. 전체 회원 목록 조회 (DB 연동)
    public ArrayList<UserDTO> selectAllMembers() {
        ArrayList<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM USERS ORDER BY join_date DESC"; // 최근 가입순
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserId(rs.getString("user_id"));
                user.setPassword(rs.getString("password"));
                user.setNickname(rs.getString("nickname"));
                user.setEmail(rs.getString("email"));
                user.setJoinDate(rs.getTimestamp("join_date"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return list;
    }

    // 2. 회원 추가 기능
    public void insertMember(UserDTO dto) {
        String sql = "INSERT INTO USERS (user_id, password, nickname, email, join_date) VALUES (?, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getUserId());
            pstmt.setString(2, dto.getPassword());
            pstmt.setString(3, dto.getNickname());
            pstmt.setString(4, dto.getEmail());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
    }

    // 3. 회원 정보 수정 기능
    public void updateMember(UserDTO dto) {
        String sql = "UPDATE USERS SET password=?, nickname=?, email=? WHERE user_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getPassword());
            pstmt.setString(2, dto.getNickname());
            pstmt.setString(3, dto.getEmail());
            pstmt.setString(4, dto.getUserId());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
    }

    // 4. 회원 강퇴 기능
    public void deleteMember(String id) {
        String sql = "DELETE FROM USERS WHERE user_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
    }

    // 5. 활동 기록 조회 (아직 로그 테이블이 없으므로 가짜 데이터 유지)
    public ArrayList<String> selectActivityLog(String id) {
        ArrayList<String> logs = new ArrayList<>();
        logs.add("[시스템] " + id + "님의 활동 로그 기능은 아직 DB와 연동되지 않았습니다.");
        logs.add("[예시] 2025-11-23 로그인 성공");
        return logs;
    }
}