package com.orangeteam.sistemamotorrecomendaciones.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.UserGameHistory;

public interface UserGameHistoryRepository extends JpaRepository<UserGameHistory, Long> {
    List<UserGameHistory> findByUserId(Long userId);
    Optional<UserGameHistory> findByUserIdAndGameId(Long userId, Long gameId);
}