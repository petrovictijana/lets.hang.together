package game.rmi;

import game.protocols.LetterGuessStatus;
import game.protocols.Player;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface IGame extends Remote {
    int getGameCode() throws RemoteException;
    int getMissingWordLettersNumber() throws RemoteException;
    String getPlayer1Username() throws RemoteException;
    String getPlayer2Username() throws RemoteException;
    int getAvailableAttemptsNumber() throws RemoteException;
    int getPointsNumber() throws RemoteException;
    LetterGuessStatus isLetterGuessed(Character letter) throws RemoteException;
    boolean isWordGuessed(String word) throws RemoteException;
    Player getPlayer1() throws RemoteException;
    Player getPlayer2() throws RemoteException;
    boolean canChangeAvailableAttempts() throws RemoteException;
    void changePlayersTurn() throws RemoteException;
    void reducePoints() throws RemoteException;
    void reduceAvailableAttempts() throws RemoteException;
    int getWinner() throws RemoteException;
    boolean isGameOver() throws RemoteException;
    String getMissingWordForGameOver() throws RemoteException;


}
