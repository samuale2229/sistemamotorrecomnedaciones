package com.orangeteam.sistemamotorrecomendaciones.service;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.orangeteam.sistemamotorrecomendaciones.model.Genre;
import com.orangeteam.sistemamotorrecomendaciones.repository.GameGenreRepository;
import com.orangeteam.sistemamotorrecomendaciones.repository.GenreRepository;

@Service
@Transactional(readOnly = true)
public class GenreService {

    private final GenreRepository genreRepository;
    private final GameGenreRepository gameGenreRepository;

    public GenreService(GenreRepository genreRepository, GameGenreRepository gameGenreRepository) {
        this.genreRepository = genreRepository;
        this.gameGenreRepository = gameGenreRepository;
    }

    public List<Genre> findAll() {
        return genreRepository.findAll();
    }

    public Genre findById(Long genreId) {
        return genreRepository.findById(genreId)
                .orElseThrow(() -> new NoSuchElementException("Género no encontrado con id: " + genreId));
    }

    public Genre findBySlug(String slug) {
        return genreRepository.findBySlug(slug)
                .orElseThrow(() -> new NoSuchElementException("Género no encontrado con slug: " + slug));
    }

    public long countGamesInGenre(Long genreId) {
        findById(genreId);
        return gameGenreRepository.countByGenreId(genreId);
    }

    public boolean isLowDensityGenre(Long genreId, long threshold) {
        return countGamesInGenre(genreId) <= threshold;
    }
}