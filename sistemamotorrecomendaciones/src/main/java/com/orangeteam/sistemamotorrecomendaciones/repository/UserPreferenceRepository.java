package com.orangeteam.sistemamotorrecomendaciones.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.UserPreference;

public interface UserPreferenceRepository extends JpaRepository<UserPreference, Long> {
    List<UserPreference> findByUserId(Long userId);
    List<UserPreference> findByUserIdOrderByAffinityScoreDesc(Long userId);
    Optional<UserPreference> findByUserIdAndGenreId(Long userId, Long genreId);
    boolean existsByUserId(Long userId);
}