package com.orangeteam.sistemamotorrecomendaciones.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.orangeteam.sistemamotorrecomendaciones.model.Game;
import com.orangeteam.sistemamotorrecomendaciones.model.GameSession;
import com.orangeteam.sistemamotorrecomendaciones.model.User;
import com.orangeteam.sistemamotorrecomendaciones.model.UserGameHistory;
import com.orangeteam.sistemamotorrecomendaciones.repository.GameSessionRepository;
import com.orangeteam.sistemamotorrecomendaciones.repository.UserGameHistoryRepository;

@Service
public class GameSessionService {

    private final GameSessionRepository gameSessionRepository;
    private final UserGameHistoryRepository userGameHistoryRepository;

    public GameSessionService(
            GameSessionRepository gameSessionRepository,
            UserGameHistoryRepository userGameHistoryRepository
    ) {
        this.gameSessionRepository = gameSessionRepository;
        this.userGameHistoryRepository = userGameHistoryRepository;
    }

    @Transactional
    public GameSession registrarSesion(
            User user,
            Game game,
            int durationMinutes,
            boolean completed,
            LocalDateTime sessionDate
    ) {
        int minutosValidos = Math.max(0, durationMinutes);
        LocalDateTime fechaEfectiva = (sessionDate != null) ? sessionDate : LocalDateTime.now();

        GameSession session = new GameSession();
        session.setUser(user);
        session.setGame(game);
        session.setDurationMinutes(minutosValidos);
        session.setCompleted(completed);
        session.setSessionDate(fechaEfectiva);

        GameSession savedSession = gameSessionRepository.save(session);

        UserGameHistory history = userGameHistoryRepository
                .findByUserIdAndGameId(user.getId(), game.getId())
                .orElseGet(() -> {
                    UserGameHistory nuevo = new UserGameHistory();
                    nuevo.setUser(user);
                    nuevo.setGame(game);
                    nuevo.setTotalPlaytimeMinutes(0);
                    nuevo.setSessionsCount(0);
                    nuevo.setLastPlayedAt(fechaEfectiva);
                    return nuevo;
                });

        Integer tiempoRaw = history.getTotalPlaytimeMinutes();
        int tiempoActual = (tiempoRaw != null) ? tiempoRaw : 0;

        Integer sesionesRaw = history.getSessionsCount();
        int sesionesActuales = (sesionesRaw != null) ? sesionesRaw : 0;

        history.setTotalPlaytimeMinutes(tiempoActual + minutosValidos);
        history.setSessionsCount(sesionesActuales + 1);
        if (history.getLastPlayedAt() == null || !fechaEfectiva.isBefore(history.getLastPlayedAt())) {
            history.setLastPlayedAt(fechaEfectiva);
        }

        userGameHistoryRepository.save(history);

        return savedSession;
    }

    public List<GameSession> obtenerSesionesPorUsuario(Long userId) {
        return gameSessionRepository.findByUserId(userId);
    }

    public List<UserGameHistory> obtenerHistorialPorUsuario(Long userId) {
        return userGameHistoryRepository.findByUserId(userId);
    }
}