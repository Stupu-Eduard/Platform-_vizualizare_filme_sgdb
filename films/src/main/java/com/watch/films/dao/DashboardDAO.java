package com.watch.films.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class DashboardDAO {

    private final JdbcTemplate jdbc;

    public DashboardDAO(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    // 1. Recomandari personalizate bazate pe categorii preferate
    public List<Map<String, Object>> getRecomandariClient(Integer idClient) {
        String sql = "SELECT * FROM get_recomandari_client(?)";
        return jdbc.queryForList(sql, idClient);
    }

    // 2. Predictii sezoniere bazate pe luna
    public List<Map<String, Object>> getPredictieSezoniera(Integer luna) {
        String sql = "SELECT * FROM get_predictie_sezoniera(?)";
        return jdbc.queryForList(sql, luna);
    }

    // 3. Recomandari prin similaritate cu alti clienti
    public List<Map<String, Object>> getRecomandariSimilaritate(Integer idClient) {
        String sql = "SELECT * FROM get_recomandari_prin_similaritate(?)";
        return jdbc.queryForList(sql, idClient);
    }

    // 4. Statistici generale de consum ale unui client
    public Map<String, Object> getStatisticiConsum(Integer idClient) {
        String sql = "SELECT * FROM get_statistici_consum(?)";
        List<Map<String, Object>> result = jdbc.queryForList(sql, idClient);
        if (result.isEmpty()) return null;
        return result.get(0);
    }

    // 5. Istoric complet al activitatii unui client
    public List<Map<String, Object>> getIstoricComplet(Integer idClient) {
        String sql = "SELECT v.Data_Vizualizare, f.Titlu_Film, vf.Rezolutie, vf.Limba_Versiune, v.Durata_Vizualizare, v.Stare_Vizualizare " +
                "FROM Vizualizari v " +
                "JOIN Filme f ON v.ID_Film = f.ID_Film " +
                "JOIN Versiuni_Film vf ON v.ID_Versiune = vf.ID_Versiune " +
                "WHERE v.ID_Client = ? " +
                "ORDER BY v.Data_Vizualizare DESC";
        return jdbc.queryForList(sql, idClient);
    }
    }