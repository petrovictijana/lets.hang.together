package game.protocols.DTOs;

import game.protocols.enums.ON_TURN;

import java.util.List;

public class LetterGuessStatusDTO {
    //General data
    private ON_TURN onTurn;
    private int availableAttempts;
    private int points;
    //Podaci vezani za pogadjanje slova
    private char letter;
    private boolean isLetterGuessed;
    private List<Integer> guessedLetterPositions;


    public LetterGuessStatusDTO() {
    }

    public LetterGuessStatusDTO(ON_TURN onTurn, int availableAttempts, char letter, boolean isLetterGuessed, List<Integer> guessedLetterPositions, int points) {
        this.onTurn = onTurn;
        this.availableAttempts = availableAttempts;
        this.letter = letter;
        this.isLetterGuessed = isLetterGuessed;
        this.guessedLetterPositions = guessedLetterPositions;
        this.points = points;
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

    public char getLetter() {
        return letter;
    }

    public void setLetter(char letter) {
        this.letter = letter;
    }

    public boolean isLetterGuessed() {
        return isLetterGuessed;
    }

    public void setLetterGuessed(boolean letterGuessed) {
        isLetterGuessed = letterGuessed;
    }

    public List<Integer> getGuessedLetterPositions() {
        return guessedLetterPositions;
    }

    public void setGuessedLetterPositions(List<Integer> guessedLetterPositions) {
        this.guessedLetterPositions = guessedLetterPositions;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }
}
