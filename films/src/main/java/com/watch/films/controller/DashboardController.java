package com.watch.films.controller;

import com.watch.films.dao.DashboardDAO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DashboardController {

    private final DashboardDAO dashboardDAO;

    public DashboardController(DashboardDAO dashboardDAO) {
        this.dashboardDAO = dashboardDAO;
    }

    @GetMapping("/dashboard")
    public String arataDashboard() {
        return "dashboard"; // Doar afișează formularul gol inițial
    }

    @PostMapping("/dashboard/statistici")
    public String ruleazaStatistici(
            @RequestParam(required = false, defaultValue = "1") Integer idClient,
            @RequestParam(required = false, defaultValue = "12") Integer lunaPredictie,
            Model model) {

        // Preluam rezultatele din baza de date folosind funcțiile PL/pgSQL
        model.addAttribute("recomandariGen", dashboardDAO.getRecomandariClient(idClient));
        model.addAttribute("recomandariSimilaritate", dashboardDAO.getRecomandariSimilaritate(idClient));
        model.addAttribute("statistici", dashboardDAO.getStatisticiConsum(idClient));
        model.addAttribute("predictii", dashboardDAO.getPredictieSezoniera(lunaPredictie));
        model.addAttribute("istoric", dashboardDAO.getIstoricComplet(idClient));

        // Trimitem datele inapoi in view pentru a pastra selectia
        model.addAttribute("idClient", idClient);
        model.addAttribute("lunaPredictie", lunaPredictie);

        return "dashboard";
    }
}