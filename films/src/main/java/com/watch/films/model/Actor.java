package com.watch.films.model;

import java.time.LocalDate;

public class Actor {
    private Integer idActor;
    private String numeScena;
    private String numeFamilie;
    private String prenume;
    private LocalDate dataNastere;

    public Integer getIdActor() { return idActor; }
    public void setIdActor(Integer idActor) { this.idActor = idActor; }

    public String getNumeScena() { return numeScena; }
    public void setNumeScena(String numeScena) { this.numeScena = numeScena; }

    public String getNumeFamilie() { return numeFamilie; }
    public void setNumeFamilie(String numeFamilie) { this.numeFamilie = numeFamilie; }

    public String getPrenume() { return prenume; }
    public void setPrenume(String prenume) { this.prenume = prenume; }

    public LocalDate getDataNastere() { return dataNastere; }
    public void setDataNastere(LocalDate dataNastere) { this.dataNastere = dataNastere; }
}