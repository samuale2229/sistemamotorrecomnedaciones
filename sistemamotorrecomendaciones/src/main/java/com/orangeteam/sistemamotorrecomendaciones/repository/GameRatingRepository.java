package com.orangeteam.sistemamotorrecomendaciones.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.GameRating;

public interface GameRatingRepository extends JpaRepository<GameRating, Long> {
}