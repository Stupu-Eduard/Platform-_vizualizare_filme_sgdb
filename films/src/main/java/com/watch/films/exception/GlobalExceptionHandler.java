package com.watch.films.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.sql.SQLException;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(SQLException.class)
    public String handleSQLException(SQLException ex, Model model) {
        String errorMessage = ex.getMessage();
        
        // Verificam daca eroarea vine din trigger-ul nostru
        if (errorMessage.contains("Eroare SGBD")) {
            model.addAttribute("error", errorMessage);
        } else {
            model.addAttribute("error", "A apărut o eroare neașteptată la nivelul bazei de date.");
        }
        
        return "error"; // Va cauta templates/error.html
    }

    @ExceptionHandler(Exception.class)
    public String handleGeneralException(Exception ex, Model model) {
        model.addAttribute("error", "Eroare aplicație: " + ex.getMessage());
        return "error";
    }
}
