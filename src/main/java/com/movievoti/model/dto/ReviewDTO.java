package com.movievoti.model.dto;

import java.sql.Timestamp;

public class ReviewDTO {
    private int reviewId;
    private String userId;
    private String userNick; // 화면 표시용 닉네임
    private int movieId;
    private int rating;
    private String comment;
    private Timestamp createdAt;
    private String movieTitle; // 추가: 영화 제목
    private String posterPath; // 추가: 포스터 경로

    public ReviewDTO() {}

    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getUserNick() { return userNick; }
    public void setUserNick(String userNick) { this.userNick = userNick; }
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
    public String getPosterPath() { return posterPath; }
    public void setPosterPath(String posterPath) { this.posterPath = posterPath; }
}