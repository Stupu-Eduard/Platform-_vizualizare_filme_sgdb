package com.watch.films.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Film {
    private Integer idFilm;
    private String titluFilm;
    private String descriereFilm;
    private LocalDate dataLansare;
    private Integer idCategorie;

    private String tipCategorie;
    private Double ratingMediu;
}