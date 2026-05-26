package com.watch.films.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class FeedbackDAO {
    private final JdbcTemplate jdbc;
    public FeedbackDAO(JdbcTemplate jdbc) { this.jdbc = jdbc; }

    // Pasam comentariul prin funcția SQL 'analiza_sentiment'
    public List<Map<String, Object>> gasesteComentarii(Integer idFilm) {
        String sql = "SELECT ID_Feedback, Rating_Film, Comentariu_Film_Text, Sentiment_Analiza " +
                "FROM Feedback_Voturi WHERE ID_Film = ?";
        return jdbc.queryForList(sql, idFilm);
    }

    public Integer salveaza(Integer idFilm, Integer nota, String comentariu) {
        String sql = "INSERT INTO Feedback_Voturi (ID_Film, ID_Client, Rating_Film, Comentariu_Film_Text) " +
                "VALUES (?, 1, ?, ?) RETURNING ID_Feedback";
        return jdbc.queryForObject(sql, Integer.class, idFilm, nota, comentariu);
    }

    public void salveazaTaguri(Integer idFeedback, List<String> taguri) {
        String sql = "INSERT INTO Caracterizari_Selectate (ID_Feedback, Eticheta_Predefinita) VALUES (?, ?)";
        for (String tag : taguri) {
            jdbc.update(sql, idFeedback, tag);
        }
    }

    public List<String> gasesteTaguri(Integer idFeedback) {
        String sql = "SELECT Eticheta_Predefinita FROM Caracterizari_Selectate WHERE ID_Feedback = ?";
        return jdbc.queryForList(sql, String.class, idFeedback);
    }
    }