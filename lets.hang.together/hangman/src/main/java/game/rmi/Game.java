package game.rmi;

import game.protocols.LetterGuessStatus;
import game.protocols.Player;
import game.protocols.enums.ON_TURN;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.List;


public class Game extends UnicastRemoteObject implements IGame{
    private int code;
    private Player player1;
    private Player player2;
    private String missingWord;
    private String revealedWord;
    private ON_TURN onTurn;
    private int winner;
    private int attemptsAvailable;
    private int points;
    private boolean gameOver;


    public Game() throws RemoteException {
    }

    public Game(int code, Player player1, Player player2, String missingWord, String revealedWord, ON_TURN onTurn, int winner, int attemptsAvailable, int points) throws RemoteException {
        this.code = code;
        this.player1 = player1;
        this.player2 = player2;
        this.missingWord = missingWord;
        this.revealedWord = revealedWord;
        this.onTurn = onTurn;
        this.winner = winner;
        this.attemptsAvailable = attemptsAvailable;
        this.points = points;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Player getPlayer1() {
        return player1;
    }

    public void setPlayer1(Player player1) {
        this.player1 = player1;
    }

    public Player getPlayer2() {
        return player2;
    }

    @Override
    public boolean canChangeAvailableAttempts() throws RemoteException {
        return (this.onTurn == ON_TURN.PLAYER_2) ? true : false;
    }

    @Override
    public void changePlayersTurn() throws RemoteException {
        this.onTurn = this.onTurn == ON_TURN.PLAYER_1 ? ON_TURN.PLAYER_2 : ON_TURN.PLAYER_1;
    }

    @Override
    public void reducePoints() throws RemoteException {
        this.points--;
    }

    @Override
    public void reduceAvailableAttempts() throws RemoteException {
        this.attemptsAvailable--;
        if(this.attemptsAvailable == 0){
            winner = 0;
            gameOver = true;
        }
    }

    public void setPlayer2(Player player2) {
        this.player2 = player2;
    }

    public String getMissingWord() {
        return missingWord;
    }

    public void setMissingWord(String missingWord) {
        this.missingWord = missingWord;
        int numberOfLetters = missingWord.length();

        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < numberOfLetters; i++){
            stringBuilder.append("_ ");
        }

        revealedWord = stringBuilder.toString();
    }

    public String getRevealedWord() {
        return revealedWord;
    }

    public void setRevealedWord(String revealedWord) {
        this.revealedWord = revealedWord;
    }

    public ON_TURN getOnTurn() {
        return onTurn;
    }

    public void setOnTurn(ON_TURN onTurn) {
        this.onTurn = onTurn;
    }

    public int getWinner() {
        return winner;
    }

    @Override
    public boolean isGameOver() throws RemoteException {
        return gameOver;
    }

    @Override
    public String getMissingWordForGameOver() throws RemoteException {
        return missingWord;
    }

    public void setWinner(int winner) {
        this.winner = winner;
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

    @Override
    public int getGameCode() throws RemoteException {
        return code;
    }

    @Override
    public int getMissingWordLettersNumber() throws RemoteException {
        return missingWord.length();
    }

    @Override
    public String getPlayer1Username() throws RemoteException {
        return player1.getUsername();
    }

    @Override
    public String getPlayer2Username() throws RemoteException {
        return player2.getUsername();
    }

    @Override
    public int getAvailableAttemptsNumber() throws RemoteException {
        return attemptsAvailable;
    }

    @Override
    public int getPointsNumber() throws RemoteException {
        return points;
    }

    @Override
    public LetterGuessStatus isLetterGuessed(Character letter) throws RemoteException {
        List<Integer> guessedLetterPositions = new ArrayList<>();
        boolean isLetterGuessed = false;
        char lowercaseLetter = Character.toLowerCase(letter);

        StringBuilder stringBuilder = new StringBuilder(revealedWord);

        for (int i = 0; i < missingWord.length(); i++) {
            char lowercaseMissingLetter = Character.toLowerCase(missingWord.charAt(i));
            if (lowercaseMissingLetter == lowercaseLetter) {
                guessedLetterPositions.add(i);

                stringBuilder.setCharAt(i * 2, missingWord.charAt(i));
                isLetterGuessed = true;
            }
        }

        revealedWord = stringBuilder.toString(); // Update the revealedWord

        if(!revealedWord.contains("_")){
            gameOver = true;
            if(onTurn == ON_TURN.PLAYER_1)
                winner = 1;
            else
                winner = 2;
        }

        return new LetterGuessStatus(isLetterGuessed, guessedLetterPositions);
    }

    @Override
    public boolean isWordGuessed(String word) throws RemoteException {
        boolean isWordGuessed = this.missingWord.toUpperCase().equals(word.toUpperCase());

        if(isWordGuessed){
            gameOver = true;
            if(onTurn == ON_TURN.PLAYER_1)
                winner = 1;
            else
                winner = 2;
        }
        return isWordGuessed;
    }


}
