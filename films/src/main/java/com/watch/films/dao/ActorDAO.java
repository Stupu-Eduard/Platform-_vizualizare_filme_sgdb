package com.watch.films.dao;

import com.watch.films.model.Actor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ActorDAO {

    private final JdbcTemplate jdbc;

    public ActorDAO(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Actor> gasesteDupaFilm(Integer idFilm) {
        String sql = "SELECT a.* FROM Actori a JOIN Distributie d ON a.ID_Actor = d.ID_Actor WHERE d.ID_Film = ?";
        return jdbc.query(sql, (rs, rowNum) -> {
            Actor a = new Actor();
            a.setIdActor(rs.getInt("ID_Actor"));
            a.setNumeScena(rs.getString("Nume_Scena_Actor"));
            a.setNumeFamilie(rs.getString("Nume_Familie_Actor"));
            a.setPrenume(rs.getString("Prenume_Actor"));
            return a;
        }, idFilm);
    }

    public List<Map<String, Object>> gasesteFeedbackActori(Integer idFilm) {
        String sql = "SELECT fa.*, a.Nume_Scena_Actor FROM Feedback_Actori fa " +
                "JOIN Actori a ON fa.ID_Actor = a.ID_Actor " +
                "WHERE fa.ID_Film = ?";
        return jdbc.queryForList(sql, idFilm);
    }

    public void salveazaFeedbackActor(Integer idFilm, Integer idActor, String comentariu) {
        String sql = "INSERT INTO Feedback_Actori (ID_Client, ID_Film, ID_Actor, Comentariu_Actor_Rol) " +
                "VALUES (1, ?, ?, ?)";
        jdbc.update(sql, idFilm, idActor, comentariu);
    }
    }