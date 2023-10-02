package game.protocols;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

public class LetterGuessStatus implements Serializable {
    private boolean isLetterGuessed;
    private List<Integer> guessedLetterPositions;

    public LetterGuessStatus() {
    }

    public LetterGuessStatus(boolean isLetterGuessed, List<Integer> guessedLetterPositions) {
        this.isLetterGuessed = isLetterGuessed;
        this.guessedLetterPositions = guessedLetterPositions;
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
}
