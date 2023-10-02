package game.protocols.DTOs;

public class GameOverDTO {
    private String winner;
    private int points;
    private String missingWord;

    public GameOverDTO() {
    }

    public GameOverDTO(String winner, int points) {
        this.winner = winner;
        this.points = points;
    }

    public GameOverDTO(String winner, int points, String missingWord) {
        this.winner = winner;
        this.points = points;
        this.missingWord = missingWord;
    }

    public String getWinner() {
        return winner;
    }

    public void setWinner(String winner) {
        this.winner = winner;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getMissingWord() {
        return missingWord;
    }

    public void setMissingWord(String missingWord) {
        this.missingWord = missingWord;
    }
}
