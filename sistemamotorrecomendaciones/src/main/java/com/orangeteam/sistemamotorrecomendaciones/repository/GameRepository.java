package com.orangeteam.sistemamotorrecomendaciones.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.Game;

public interface GameRepository extends JpaRepository<Game, Long> {
}