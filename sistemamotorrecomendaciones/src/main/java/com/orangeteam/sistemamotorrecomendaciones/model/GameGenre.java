package com.orangeteam.sistemamotorrecomendaciones.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(
    name = "game_genres",
    uniqueConstraints = {
        @UniqueConstraint(name = "uq_game_genre", columnNames = {"game_id", "genre_id"})
    },
    indexes = {
        @Index(name = "idx_game_genres_genre", columnList = "genre_id")
    }
)
public class GameGenre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "game_id", nullable = false)
    private Game game;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "genre_id", nullable = false)
    private Genre genre;

    @Column(name = "relevance_weight", nullable = false, precision = 4, scale = 2)
    private BigDecimal relevanceWeight = new BigDecimal("1.00");

    @Column(name = "created_at", nullable = false, updatable = false, insertable = false)
    private Instant createdAt;

    public GameGenre() {
    }

    public GameGenre(Game game, Genre genre, BigDecimal relevanceWeight) {
        this.game = game;
        this.genre = genre;
        this.relevanceWeight = relevanceWeight != null ? relevanceWeight : new BigDecimal("1.00");
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public BigDecimal getRelevanceWeight() {
        return relevanceWeight;
    }

    public void setRelevanceWeight(BigDecimal relevanceWeight) {
        this.relevanceWeight = relevanceWeight;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof GameGenre other)) return false;
        return id != null && Objects.equals(id, other.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}