package com.watch.films.dao;

import com.watch.films.model.Film;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

@Repository
public class FilmDAO {

    private final JdbcTemplate jdbc;
    
    // jdbcTemplate
    public FilmDAO(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Film> gasesteFilme(String cautare) {
        String sql;
        Object[] params;
        
        // daca utilizatorul nu a cautat nimic in bara de search, aducem niste filme la intamplare
        if (cautare == null || cautare.trim().isEmpty()) {
            sql = "SELECT f.*, c.Tip_Categorie FROM Filme f JOIN Categorii c ON f.ID_Categorie = c.ID_Categorie ORDER BY RANDOM() LIMIT 50";
            params = new Object[]{};
        } else {
            // daca a cautat ceva anume, folosim LIKE ca sa gasim potriviri partiale (indiferent de litere mari/mici)
            sql = "SELECT f.*, c.Tip_Categorie FROM Filme f JOIN Categorii c ON f.ID_Categorie = c.ID_Categorie WHERE LOWER(f.Titlu_Film) LIKE LOWER(?) LIMIT 50";
            params = new Object[]{"%" + cautare + "%"};
        }

        // luam fiecare rand venit din baza de date (rs) si il transformam in obiectul nostru Film
        return jdbc.query(sql, params, (rs, rowNum) -> {
            Film f = new Film();
            f.setIdFilm(rs.getInt("ID_Film"));
            f.setTitluFilm(rs.getString("Titlu_Film"));
            f.setDescriereFilm(rs.getString("Descriere_Film"));
            f.setDataLansare(rs.getDate("Data_Lansare").toLocalDate());
            f.setIdCategorie(rs.getInt("ID_Categorie"));
            f.setTipCategorie(rs.getString("Tip_Categorie")); 
            return f;
        });
    }

    public Film gasesteDupaId(Integer id) {
        // un sub-query in SELECT ca sa scot direct si rating-ul mediu
        String sql = "SELECT f.*, c.Tip_Categorie, " +
                "(SELECT AVG(Rating_Film) FROM Feedback_Voturi WHERE ID_Film = f.ID_Film) as medie " +
                "FROM Filme f " +
                "JOIN Categorii c ON f.ID_Categorie = c.ID_Categorie " +
                "WHERE f.ID_Film = ?";

        return jdbc.queryForObject(sql, (rs, rowNum) -> {
            Film f = new Film();
            f.setIdFilm(rs.getInt("ID_Film"));
            f.setTitluFilm(rs.getString("Titlu_Film"));
            f.setDescriereFilm(rs.getString("Descriere_Film"));
            f.setDataLansare(rs.getDate("Data_Lansare").toLocalDate());
            f.setTipCategorie(rs.getString("Tip_Categorie"));
            
            // luam media din sub-query-ul de mai sus si o setam pe obiect
            f.setRatingMediu(rs.getDouble("medie"));
            return f;
        }, id);
    }

    public List<Map<String, Object>> gasesteVersiuni(Integer idFilm) {
        String sql = "SELECT * FROM Versiuni_Film WHERE ID_Film = ?";
        return jdbc.queryForList(sql, idFilm);
    }

    public void creeazaVizualizare(Integer idFilm, Integer idVersiune) {
        // ID_Client pus pe 1 pentru testare, folosim idVersiune primit
        String sql = "INSERT INTO Vizualizari (ID_Client, ID_Film, Data_Vizualizare, Durata_Vizualizare, ID_Versiune, Stare_Vizualizare) " +
                "VALUES (1, ?, CURRENT_TIMESTAMP, 0, ?, 'Inceputa')";
        jdbc.update(sql, idFilm, idVersiune);
    }

    public void finalizeazaVizualizare(Integer idFilm, Integer durata) {
        // cqnd se apasa pe STOP - cautam inregistrarea care abia incepuse (cea cu durata 0)
        // si ii dam UPDATE cu minutele reale introduse, trecand starea pe 'Terminata'
        String sql = "UPDATE Vizualizari SET Durata_Vizualizare = ?, Stare_Vizualizare = 'Terminata' " +
                "WHERE ID_Film = ? AND ID_Client = 1 AND Durata_Vizualizare = 0";
        jdbc.update(sql, durata, idFilm);
    }

}
