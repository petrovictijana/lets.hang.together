package game.protocols;

public class WordGuess {
    private String word;

    public WordGuess() {
    }

    public WordGuess(String word) {
        this.word = word;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }
}
