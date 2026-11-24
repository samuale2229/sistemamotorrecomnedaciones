package com.orangeteam.sistemamotorrecomendaciones.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(
    name = "user_game_history",
    uniqueConstraints = @UniqueConstraint(name = "uq_user_game_history", columnNames = {"user_id", "game_id"})
)
public class UserGameHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "game_id", nullable = false)
    private Game game;

    @Column(name = "total_playtime_minutes", nullable = false)
    private Integer totalPlaytimeMinutes = 0;

    @Column(name = "sessions_count", nullable = false)
    private Integer sessionsCount = 0;

    @Column(name = "last_played_at", nullable = false)
    private LocalDateTime lastPlayedAt;

    public UserGameHistory() {
    }

    @PrePersist
    protected void onCreate() {
        if (totalPlaytimeMinutes == null) {
            totalPlaytimeMinutes = 0;
        }
        if (sessionsCount == null) {
            sessionsCount = 0;
        }
        if (lastPlayedAt == null) {
            lastPlayedAt = LocalDateTime.now();
        }
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public Integer getTotalPlaytimeMinutes() {
        return totalPlaytimeMinutes;
    }

    public void setTotalPlaytimeMinutes(Integer totalPlaytimeMinutes) {
        this.totalPlaytimeMinutes = totalPlaytimeMinutes;
    }

    public Integer getSessionsCount() {
        return sessionsCount;
    }

    public void setSessionsCount(Integer sessionsCount) {
        this.sessionsCount = sessionsCount;
    }

    public LocalDateTime getLastPlayedAt() {
        return lastPlayedAt;
    }

    public void setLastPlayedAt(LocalDateTime lastPlayedAt) {
        this.lastPlayedAt = lastPlayedAt;
    }
}