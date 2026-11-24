package com.orangeteam.sistemamotorrecomendaciones.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.GameSession;

public interface GameSessionRepository extends JpaRepository<GameSession, Long> {
    List<GameSession> findByUserId(Long userId);
    List<GameSession> findByUserIdAndGameId(Long userId, Long gameId);
}