package com.watch.films.service;

import com.watch.films.dao.ActorDAO;
import com.watch.films.dao.FeedbackDAO;
import com.watch.films.dao.FilmDAO;
import com.watch.films.model.Actor;
import com.watch.films.model.Film;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class FilmService {
    private final FilmDAO filmDAO;
    private final FeedbackDAO feedbackDAO;
    private final ActorDAO actorDAO;

    public FilmService(FilmDAO fDAO, FeedbackDAO fbDAO, ActorDAO actorDAO) {
        this.filmDAO = fDAO;
        this.feedbackDAO = fbDAO;
        this.actorDAO = actorDAO;
    }

    public List<Film> obtineToateFilmele() {
        return filmDAO.gasesteFilme(null);
    }

    public void adaugaComentariu(Integer idFilm, Integer nota, String text, List<String> taguri) {
        // Aici se va declanșa Trigger-ul din Postgres
        Integer idFeedback = feedbackDAO.salveaza(idFilm, nota, text);
        if (taguri != null && !taguri.isEmpty()) {
            feedbackDAO.salveazaTaguri(idFeedback, taguri);
        }
    }

    public void startVizionare(Integer idFilm, Integer idVersiune) {
        // cream o înregistrare în tabelul Vizualizari
        filmDAO.creeazaVizualizare(idFilm, idVersiune);
    }

    public List<Map<String, Object>> obtineVersiuni(Integer idFilm) {
        return filmDAO.gasesteVersiuni(idFilm);
    }

    public List<Actor> obtineDistributie(Integer idFilm) {
        return actorDAO.gasesteDupaFilm(idFilm);
    }

    public List<Map<String, Object>> obtineFeedbackActori(Integer idFilm) {
        return actorDAO.gasesteFeedbackActori(idFilm);
    }

    public void adaugaFeedbackActor(Integer idFilm, Integer idActor, String comentariu) {
        actorDAO.salveazaFeedbackActor(idFilm, idActor, comentariu);
    }

    public void stopVizionare(Integer idFilm, Integer durata) {
        filmDAO.finalizeazaVizualizare(idFilm, durata);
    }

    public Film detaliiFilm(Integer id) {
        return filmDAO.gasesteDupaId(id);
    }

    public List<Map<String, Object>> obtineComentarii(Integer id) {
        List<Map<String, Object>> comentarii = feedbackDAO.gasesteComentarii(id);
        for (Map<String, Object> c : comentarii) {
            Integer idFeedback = (Integer) c.get("ID_Feedback");
            c.put("taguri", feedbackDAO.gasesteTaguri(idFeedback));
        }
        return comentarii;
    }

}