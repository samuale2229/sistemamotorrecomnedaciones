package com.orangeteam.sistemamotorrecomendaciones.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.GameGenre;

public interface GameGenreRepository extends JpaRepository<GameGenre, Long> {
    List<GameGenre> findByGameId(Long gameId);
    List<GameGenre> findByGenreId(Long genreId);
    Optional<GameGenre> findByGameIdAndGenreId(Long gameId, Long genreId);
    long countByGenreId(Long genreId);
}