package com.movievoti.model.dto;

import java.sql.Timestamp;

public class UserDTO {
    private String userId;
    private String password;
    private String nickname;
    private String email;
    private Timestamp joinDate;
    private String role; // 추가됨: 권한 (USER, ADMIN)

    public UserDTO() {}

    // 전체 생성자 업데이트
    public UserDTO(String userId, String password, String nickname, String email, Timestamp joinDate, String role) {
        this.userId = userId;
        this.password = password;
        this.nickname = nickname;
        this.email = email;
        this.joinDate = joinDate;
        this.role = role;
    }

    // Getter & Setter
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public Timestamp getJoinDate() { return joinDate; }
    public void setJoinDate(Timestamp joinDate) { this.joinDate = joinDate; }
    
    // Role Getter/Setter 추가
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    // 편의 메서드: 관리자 여부 확인
    public boolean isAdmin() {
        return "ADMIN".equals(this.role);
    }
}