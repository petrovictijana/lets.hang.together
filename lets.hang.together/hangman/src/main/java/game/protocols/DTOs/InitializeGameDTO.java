package game.protocols.DTOs;

public class InitializeGameDTO {
    private String player1Username;
    private String player2Username;
    private int missingWordLettersNumber;
    private int attemptsAvailable;
    private int points;

    public InitializeGameDTO() {
    }

    public InitializeGameDTO(String player1Username, String player2Username, int missingWordLettersNumber, int attemptsAvailable, int points) {
        this.player1Username = player1Username;
        this.player2Username = player2Username;
        this.missingWordLettersNumber = missingWordLettersNumber;
        this.attemptsAvailable = attemptsAvailable;
        this.points = points;
    }

    public String getPlayer1Username() {
        return player1Username;
    }

    public void setPlayer1Username(String player1Username) {
        this.player1Username = player1Username;
    }

    public String getPlayer2Username() {
        return player2Username;
    }

    public void setPlayer2Username(String player2Username) {
        this.player2Username = player2Username;
    }

    public int getMissingWordLettersNumber() {
        return missingWordLettersNumber;
    }

    public void setMissingWordLettersNumber(int missingWordLettersNumber) {
        this.missingWordLettersNumber = missingWordLettersNumber;
    }

    public int getAttemptsAvailable() {
        return attemptsAvailable;
    }

    public void setAttemptsAvailable(int attemptsAvailable) {
        this.attemptsAvailable = attemptsAvailable;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }
}
