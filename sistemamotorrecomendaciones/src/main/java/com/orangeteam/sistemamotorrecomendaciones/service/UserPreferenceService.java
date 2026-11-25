package com.orangeteam.sistemamotorrecomendaciones.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.orangeteam.sistemamotorrecomendaciones.model.Genre;
import com.orangeteam.sistemamotorrecomendaciones.model.User;
import com.orangeteam.sistemamotorrecomendaciones.model.UserPreference;
import com.orangeteam.sistemamotorrecomendaciones.repository.GenreRepository;
import com.orangeteam.sistemamotorrecomendaciones.repository.UserPreferenceRepository;

@Service
@Transactional(readOnly = true)
public class UserPreferenceService {

    private final UserPreferenceRepository userPreferenceRepository;
    private final GenreRepository genreRepository;

    public UserPreferenceService(
            UserPreferenceRepository userPreferenceRepository,
            GenreRepository genreRepository
    ) {
        this.userPreferenceRepository = userPreferenceRepository;
        this.genreRepository = genreRepository;
    }

    public List<UserPreference> getPreferencesByUserId(Long userId) {
        return userPreferenceRepository.findByUserIdOrderByAffinityScoreDesc(userId);
    }

    public boolean isColdStartUser(Long userId) {
        return !userPreferenceRepository.existsByUserId(userId);
    }

    @Transactional
    public UserPreference upsertPreference(User user, Long genreId, BigDecimal affinityScore) {
        if (user == null || user.getId() == null) {
            throw new IllegalArgumentException("El usuario y su id son obligatorios");
        }
        if (affinityScore == null || affinityScore.compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("El puntaje de afinidad debe ser mayor o igual a 0");
        }

        Genre genre = genreRepository.findById(genreId)
                .orElseThrow(() -> new NoSuchElementException("Género no encontrado con id: " + genreId));

        UserPreference preference = userPreferenceRepository
                .findByUserIdAndGenreId(user.getId(), genreId)
                .orElseGet(() -> {
                    UserPreference created = new UserPreference();
                    created.setUser(user);
                    created.setGenre(genre);
                    return created;
                });

        preference.setAffinityScore(affinityScore);
        return userPreferenceRepository.save(preference);
    }

    @Transactional
    public void deletePreference(Long userId, Long genreId) {
        userPreferenceRepository.findByUserIdAndGenreId(userId, genreId)
                .ifPresent(userPreferenceRepository::delete);
    }
}