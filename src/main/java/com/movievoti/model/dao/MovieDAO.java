package com.movievoti.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.movievoti.common.db.DBManager;
import com.movievoti.service.MovieApiService.BoxOfficeMovie;

public class MovieDAO {
    private static MovieDAO instance = new MovieDAO();
    private MovieDAO() {}
    public static MovieDAO getInstance() { return instance; }

    public void resetAllFlags() {
        String sql = "UPDATE MOVIES SET daily_rank = 0, is_upcoming = 0";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBManager.close(conn, pstmt); }
    }

    public void upsertMovie(BoxOfficeMovie movie, boolean isUpcoming) {
        String checkSql = "SELECT movie_id FROM MOVIES WHERE title = ?";
        // ★ 쿼리 수정: genre 컬럼 추가
        String insertSql = "INSERT INTO MOVIES (title, open_dt, audi_acc, poster_path, vote_average, overview, daily_rank, is_upcoming, genre, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        String updateSql = "UPDATE MOVIES SET open_dt=?, audi_acc=?, poster_path=?, vote_average=?, overview=?, daily_rank=?, is_upcoming=?, genre=?, updated_at=NOW() WHERE title=?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, movie.getTitle());
            rs = pstmt.executeQuery();
            
            boolean exists = rs.next();
            DBManager.close(null, pstmt, rs);

            int rank = (movie.getRank() == null) ? 0 : Integer.parseInt(movie.getRank());
            int upcomingFlag = isUpcoming ? 1 : 0;

            if (exists) {
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setString(1, movie.getOpenDt());
                pstmt.setString(2, movie.getAudiAcc());
                pstmt.setString(3, movie.getPosterPath());
                pstmt.setDouble(4, movie.getVoteAverage());
                pstmt.setString(5, movie.getOverview());
                pstmt.setInt(6, rank);
                pstmt.setInt(7, upcomingFlag);
                pstmt.setString(8, movie.getGenre()); // ★ 장르 추가
                pstmt.setString(9, movie.getTitle());
                pstmt.executeUpdate();
            } else {
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, movie.getTitle());
                pstmt.setString(2, movie.getOpenDt());
                pstmt.setString(3, movie.getAudiAcc());
                pstmt.setString(4, movie.getPosterPath());
                pstmt.setDouble(5, movie.getVoteAverage());
                pstmt.setString(6, movie.getOverview());
                pstmt.setInt(7, rank);
                pstmt.setInt(8, upcomingFlag);
                pstmt.setString(9, movie.getGenre()); // ★ 장르 추가
                pstmt.executeUpdate();
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBManager.close(conn, pstmt); }
    }

    public List<BoxOfficeMovie> getBoxOfficeList() {
        return getList("SELECT m.*, COALESCE((SELECT AVG(rating) FROM REVIEWS r WHERE r.movie_id = m.movie_id), 0.0) as my_rating FROM MOVIES m WHERE daily_rank > 0 ORDER BY daily_rank ASC");
    }

    public List<BoxOfficeMovie> getUpcomingList() {
        return getList("SELECT m.*, COALESCE((SELECT AVG(rating) FROM REVIEWS r WHERE r.movie_id = m.movie_id), 0.0) as my_rating FROM MOVIES m WHERE is_upcoming = 1 ORDER BY open_dt ASC");
    }

    private List<BoxOfficeMovie> getList(String sql) {
        List<BoxOfficeMovie> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                BoxOfficeMovie movie = new BoxOfficeMovie();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setRank(String.valueOf(rs.getInt("daily_rank")));
                movie.setOpenDt(rs.getString("open_dt"));
                movie.setAudiAcc(rs.getString("audi_acc"));
                movie.setPosterPath(rs.getString("poster_path"));
                movie.setOverview(rs.getString("overview"));
                movie.setVoteAverage(rs.getDouble("vote_average"));
                movie.setGenre(rs.getString("genre")); // ★ 장르 조회
                
                double myRate = rs.getDouble("my_rating");
                myRate = Math.round(myRate * 10) / 10.0;
                movie.setMyRating(myRate);
                
                list.add(movie);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBManager.close(conn, pstmt, rs); }
        return list;
    }
    
    public BoxOfficeMovie getMovieById(int movieId) {
        String sql = "SELECT m.*, COALESCE((SELECT AVG(rating) FROM REVIEWS r WHERE r.movie_id = m.movie_id), 0.0) as my_rating FROM MOVIES m WHERE movie_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoxOfficeMovie movie = null;
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, movieId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                movie = new BoxOfficeMovie();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setOpenDt(rs.getString("open_dt"));
                movie.setAudiAcc(rs.getString("audi_acc"));
                movie.setPosterPath(rs.getString("poster_path"));
                movie.setOverview(rs.getString("overview"));
                movie.setVoteAverage(rs.getDouble("vote_average"));
                movie.setGenre(rs.getString("genre")); // ★ 장르 조회
                
                double myRate = rs.getDouble("my_rating");
                myRate = Math.round(myRate * 10) / 10.0;
                movie.setMyRating(myRate);
            }
        } catch (Exception e) { e.printStackTrace(); }
        finally { DBManager.close(conn, pstmt, rs); }
        return movie;
    }

    public List<BoxOfficeMovie> searchMoviesFromDB(String keyword) {
        String sql = "SELECT m.*, COALESCE((SELECT AVG(rating) FROM REVIEWS r WHERE r.movie_id = m.movie_id), 0.0) as my_rating " +
                     "FROM MOVIES m WHERE title LIKE ? ORDER BY CASE WHEN title = ? THEN 0 ELSE 1 END, open_dt DESC";
        
        List<BoxOfficeMovie> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, keyword);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BoxOfficeMovie movie = new BoxOfficeMovie();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setOpenDt(rs.getString("open_dt"));
                movie.setPosterPath(rs.getString("poster_path"));
                movie.setVoteAverage(rs.getDouble("vote_average"));
                movie.setOverview(rs.getString("overview"));
                movie.setGenre(rs.getString("genre")); // ★ 장르 조회
                
                double myRate = rs.getDouble("my_rating");
                myRate = Math.round(myRate * 10) / 10.0;
                movie.setMyRating(myRate);
                
                list.add(movie);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBManager.close(conn, pstmt, rs); }
        return list;
    }
}