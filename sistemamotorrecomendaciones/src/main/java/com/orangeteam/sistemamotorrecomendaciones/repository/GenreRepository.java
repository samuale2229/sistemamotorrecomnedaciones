package com.orangeteam.sistemamotorrecomendaciones.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.Genre;

public interface GenreRepository extends JpaRepository<Genre, Long> {
    Optional<Genre> findBySlug(String slug);
    Optional<Genre> findByNameIgnoreCase(String name);
    boolean existsBySlug(String slug);
}