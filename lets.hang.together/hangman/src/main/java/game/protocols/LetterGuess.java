package game.protocols;

public class LetterGuess {
    private char letter;

    public LetterGuess() {
    }

    public LetterGuess(char letter) {
        this.letter = letter;
    }

    public char getLetter() {
        return letter;
    }

    public void setLetter(char letter) {
        this.letter = letter;
    }
}
