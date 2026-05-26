package com.watch.films.controller;

import com.watch.films.dao.FeedbackDAO;
import com.watch.films.dao.FilmDAO;
import com.watch.films.model.Film;
import com.watch.films.service.FilmService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
public class FilmController {

    private final FilmDAO filmDAO;
    private final FeedbackDAO feedbackDAO;
    private final FilmService filmService;

    // Injectam DAO-ul
    public FilmController(FilmDAO filmDAO, FeedbackDAO feedbackDAO, FilmService filmService) {
        this.filmDAO = filmDAO;
        this.feedbackDAO = feedbackDAO;
        this.filmService = filmService;
    }

    @GetMapping("/")
    public String paginaAcasa() {
        return "index";
    }

    @GetMapping("/filme")
    public String afiseazaFilme(@RequestParam(required = false) String q, Model model) {
        model.addAttribute("listaFilme", filmDAO.gasesteFilme(q));
        model.addAttribute("q", q);
        return "filme";
    }
@GetMapping("/film/{id}")
public String paginaDetalii(@PathVariable Integer id, Model model) {
    Film film = filmDAO.gasesteDupaId(id);
    List<Map<String, Object>> comentarii = filmService.obtineComentarii(id);
    List<Map<String, Object>> versiuni = filmService.obtineVersiuni(id);
    List<com.watch.films.model.Actor> distributie = filmService.obtineDistributie(id);
    List<Map<String, Object>> feedbackActori = filmService.obtineFeedbackActori(id);

    model.addAttribute("film", film);
    model.addAttribute("comentarii", comentarii);
    model.addAttribute("versiuni", versiuni);
    model.addAttribute("distributie", distributie);
    model.addAttribute("feedbackActori", feedbackActori);

    return "detalii-film";
}

@PostMapping("/film/feedback")
public String adaugaFeedback(@RequestParam Integer idFilm, @RequestParam Integer nota,
                             @RequestParam String comentariu, 
                             @RequestParam(required = false) List<String> taguri,
                             RedirectAttributes ra) {
    try {
        filmService.adaugaComentariu(idFilm, nota, comentariu, taguri);
    } catch (Exception e) {
        String mesajEroare = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
        ra.addFlashAttribute("eroare", mesajEroare);
    }
    return "redirect:/film/" + idFilm;
}

@PostMapping("/film/feedback/actor")
public String adaugaFeedbackActor(@RequestParam Integer idFilm, @RequestParam Integer idActor,
                                  @RequestParam String comentariu, RedirectAttributes ra) {
    try {
        filmService.adaugaFeedbackActor(idFilm, idActor, comentariu);
    } catch (Exception e) {
        String mesajEroare = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
        ra.addFlashAttribute("eroare", mesajEroare);
    }
    return "redirect:/film/" + idFilm;
}


    @PostMapping("/film/vizionare/{actiune}/{id}")
    public String gestionareVizionare(@PathVariable String actiune,
                                      @PathVariable Integer id,
                                      @RequestParam(required = false) Integer idVersiune,
                                      @RequestParam(required = false) Integer durata,
                                      RedirectAttributes ra) {
        try {
            if ("start".equals(actiune)) {
                if (idVersiune == null) throw new RuntimeException("Te rugăm să selectezi o versiune a filmului.");
                filmService.startVizionare(id, idVersiune);
            } else {
                int durataFinala = (durata != null) ? durata : 120;
                filmService.stopVizionare(id, durataFinala);
            }
        } catch (Exception e) {
            String mesaj = (e.getCause() != null) ? e.getCause().getMessage() : e.getMessage();
            ra.addFlashAttribute("eroare", mesaj);
        }
        return "redirect:/film/" + id;
    }

}