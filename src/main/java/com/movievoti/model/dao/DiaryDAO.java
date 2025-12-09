package com.movievoti.model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.movievoti.common.db.DBManager;
import com.movievoti.model.dto.DiaryDTO;

public class DiaryDAO {
    private static DiaryDAO instance = new DiaryDAO();
    private DiaryDAO() {}
    public static DiaryDAO getInstance() { return instance; }

    // 일기 작성
    public int insertDiary(DiaryDTO diary) {
        String sql = "INSERT INTO MOVIE_DIARY (user_id, movie_title, watched_date, location, companion, mood, content, poster_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, diary.getUserId());
            pstmt.setString(2, diary.getMovieTitle());
            pstmt.setDate(3, diary.getWatchedDate());
            pstmt.setString(4, diary.getLocation());
            pstmt.setString(5, diary.getCompanion());
            pstmt.setString(6, diary.getMood());
            pstmt.setString(7, diary.getContent());
            pstmt.setString(8, diary.getPosterPath());
            return pstmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBManager.close(conn, pstmt, null); }
        return 0;
    }

    // 타임라인 목록 (최신 날짜순)
    public List<DiaryDTO> getDiariesByUserId(String userId) {
        List<DiaryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM MOVIE_DIARY WHERE user_id = ? ORDER BY watched_date DESC, diary_id DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                DiaryDTO d = new DiaryDTO();
                d.setDiaryId(rs.getInt("diary_id"));
                d.setMovieTitle(rs.getString("movie_title"));
                d.setWatchedDate(rs.getDate("watched_date"));
                d.setLocation(rs.getString("location"));
                d.setCompanion(rs.getString("companion"));
                d.setMood(rs.getString("mood"));
                d.setContent(rs.getString("content"));
                d.setPosterPath(rs.getString("poster_path"));
                list.add(d);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBManager.close(conn, pstmt, rs); }
        return list;
    }
    
 // 일기 삭제
    public int deleteDiary(int diaryId) {
        String sql = "DELETE FROM MOVIE_DIARY WHERE diary_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, diaryId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, null);
        }
        return 0;
    }
}