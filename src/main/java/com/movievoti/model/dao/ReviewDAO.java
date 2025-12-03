package com.movievoti.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.movievoti.common.db.DBManager;
import com.movievoti.model.dto.ReviewDTO;

public class ReviewDAO {
    
    // 리뷰 등록
    public int insertReview(ReviewDTO review) {
        String sql = "INSERT INTO REVIEWS (user_id, movie_id, rating, comment) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, review.getUserId());
            pstmt.setInt(2, review.getMovieId());
            pstmt.setInt(3, review.getRating());
            pstmt.setString(4, review.getComment());
            return pstmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        finally { DBManager.close(conn, pstmt); }
        return 0;
    }

    // 영화별 리뷰 목록 조회
    public ArrayList<ReviewDTO> getReviewsByMovieId(int movieId) {
        ArrayList<ReviewDTO> list = new ArrayList<>();
        // 닉네임을 가져오기 위해 조인
        String sql = "SELECT r.*, u.nickname FROM REVIEWS r JOIN USERS u ON r.user_id = u.user_id WHERE movie_id = ? ORDER BY created_at DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, movieId);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                ReviewDTO dto = new ReviewDTO();
                dto.setReviewId(rs.getInt("review_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setUserNick(rs.getString("nickname"));
                dto.setRating(rs.getInt("rating"));
                dto.setComment(rs.getString("comment"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(dto);
            }
        } catch (Exception e) { e.printStackTrace(); }
        finally { DBManager.close(conn, pstmt, rs); }
        return list;
    }
    
    public ArrayList<ReviewDTO> getReviewsByUserId(String userId) {
        ArrayList<ReviewDTO> list = new ArrayList<>();
        // 영화 테이블과 조인하여 제목과 포스터도 가져옴
        String sql = "SELECT r.*, m.title, m.poster_path " +
                     "FROM REVIEWS r " +
                     "JOIN MOVIES m ON r.movie_id = m.movie_id " +
                     "WHERE r.user_id = ? " +
                     "ORDER BY r.created_at DESC";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                ReviewDTO dto = new ReviewDTO();
                dto.setReviewId(rs.getInt("review_id"));
                dto.setMovieId(rs.getInt("movie_id"));
                dto.setRating(rs.getInt("rating"));
                dto.setComment(rs.getString("comment"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                
                // 영화 정보 세팅
                dto.setMovieTitle(rs.getString("title"));
                dto.setPosterPath(rs.getString("poster_path"));
                
                list.add(dto);
            }
        } catch (Exception e) { e.printStackTrace(); }
        finally { DBManager.close(conn, pstmt, rs); }
        return list;
    }
}