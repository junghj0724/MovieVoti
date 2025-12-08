package com.movievoti.model.dto;
import java.sql.Date;
import java.sql.Timestamp;

public class DiaryDTO {
    private int diaryId;
    private String userId;
    private String movieTitle;
    private Date watchedDate;  // 관람일
    private String location;   // 장소
    private String companion;  // 동행인
    private String mood;       // 기분
    private String content;
    private String posterPath;
    private Timestamp createDate;

    // Getter & Setter 생성 (필수)
    public int getDiaryId() { return diaryId; }
    public void setDiaryId(int diaryId) { this.diaryId = diaryId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
    public Date getWatchedDate() { return watchedDate; }
    public void setWatchedDate(Date watchedDate) { this.watchedDate = watchedDate; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getCompanion() { return companion; }
    public void setCompanion(String companion) { this.companion = companion; }
    public String getMood() { return mood; }
    public void setMood(String mood) { this.mood = mood; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getPosterPath() { return posterPath; }
    public void setPosterPath(String posterPath) { this.posterPath = posterPath; }
    public Timestamp getCreateDate() { return createDate; }
    public void setCreateDate(Timestamp createDate) { this.createDate = createDate; }
}