package game.protocols;

import game.protocols.enums.GAME_STATUS;
import game.rmi.Game;

public class ProcessRequestModel {
    private Game game;
    private GAME_STATUS gameStatus;

    public ProcessRequestModel() {
    }

    public ProcessRequestModel(Game game, GAME_STATUS gameStatus) {
        this.game = game;
        this.gameStatus = gameStatus;
    }

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public GAME_STATUS getGameStatus() {
        return gameStatus;
    }

    public void setGameStatus(GAME_STATUS gameStatus) {
        this.gameStatus = gameStatus;
    }
}
