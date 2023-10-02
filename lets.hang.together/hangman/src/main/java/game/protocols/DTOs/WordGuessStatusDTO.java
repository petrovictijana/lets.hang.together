package game.protocols.DTOs;

import game.protocols.enums.ON_TURN;


public class WordGuessStatusDTO {
    private ON_TURN onTurn;
    private int availableAttempts;
    private int points;
    private String word;

    public WordGuessStatusDTO() {
    }

    public WordGuessStatusDTO(ON_TURN onTurn, int availableAttempts, int points, String word) {
        this.onTurn = onTurn;
        this.availableAttempts = availableAttempts;
        this.points = points;
        this.word = word;
    }

    public ON_TURN getOnTurn() {
        return onTurn;
    }

    public void setOnTurn(ON_TURN onTurn) {
        this.onTurn = onTurn;
    }

    public int getAvailableAttempts() {
        return availableAttempts;
    }

    public void setAvailableAttempts(int availableAttempts) {
        this.availableAttempts = availableAttempts;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }
}
