package game.eventListeners;

import apis.UserModelAPIs;
import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import data.DbConnectionJPA;
import game.protocols.DTOs.GameOverDTO;
import game.protocols.DTOs.WordGuessStatusDTO;
import game.protocols.WordGuess;
import game.protocols.enums.ON_TURN;
import game.rmi.Game;
import game.rmi.IGame;

import java.rmi.Naming;
import java.rmi.RemoteException;
import java.util.List;

public class WordGuessingEventListener implements DataListener<String> {
    UserModelAPIs apIs = new DbConnectionJPA();
    List<Game> games;

    public WordGuessingEventListener() {
    }

    public WordGuessingEventListener(List<Game> games) {
        this.games = games;
    }

    @Override
    public void onData(SocketIOClient socketIOClient, String s, AckRequest ackRequest) throws Exception {
        int gameCode = findGameCodeBySocketIOClient(socketIOClient);
        IGame iGame = (IGame) Naming.lookup("rmi://localhost:5050/Game" + gameCode);

        ObjectMapper objectMapper = new ObjectMapper();
        WordGuess wordGuess = objectMapper.readValue(s, WordGuess.class);

        Game game = games.get(gameCode);

        boolean isWordGuessed = iGame.isWordGuessed(wordGuess.getWord());

        if(!isWordGuessed){
            //ako rec nije pogodjena
            iGame.changePlayersTurn();
        }

        if(iGame.isGameOver()){
            GameOverDTO gameOverDTO = new GameOverDTO();
            if(iGame.getWinner() == 1){
                gameOverDTO.setWinner(iGame.getPlayer1Username());
                apIs.addPointsByUsername(iGame.getPlayer1Username(), iGame.getPointsNumber());
            }
            else if(iGame.getWinner() == 2){
                gameOverDTO.setWinner(iGame.getPlayer2Username());
                apIs.addPointsByUsername(iGame.getPlayer2Username(), iGame.getPointsNumber());
            }
            else{
                gameOverDTO.setWinner("It's a draw!");
            }

            gameOverDTO.setPoints(iGame.getPointsNumber());
            gameOverDTO.setMissingWord(iGame.getMissingWordForGameOver());

            Gson gson = new Gson();
            String gameOverDTO_JSON = gson.toJson(gameOverDTO);

            game.getPlayer1().getSocketIOClient().sendEvent("gameOver", gameOverDTO_JSON);
            game.getPlayer2().getSocketIOClient().sendEvent("gameOver", gameOverDTO_JSON);

            return;
        }

        WordGuessStatusDTO wordGuessStatusDTO = new WordGuessStatusDTO();
        wordGuessStatusDTO.setOnTurn(game.getOnTurn());
        wordGuessStatusDTO.setAvailableAttempts(iGame.getAvailableAttemptsNumber());
        wordGuessStatusDTO.setPoints(iGame.getPointsNumber());
        wordGuessStatusDTO.setWord(wordGuess.getWord());

        Gson gson = new Gson();
        String wordGuessStatusDTO_JSON = gson.toJson(wordGuessStatusDTO);

        game.getPlayer1().getSocketIOClient().sendEvent("wordGuessing", wordGuessStatusDTO_JSON);
        game.getPlayer2().getSocketIOClient().sendEvent("wordGuessing", wordGuessStatusDTO_JSON);
    }

    public void changePlayersTurn(Game game){
        game.setOnTurn(game.getOnTurn() == ON_TURN.PLAYER_1 ? ON_TURN.PLAYER_2 : ON_TURN.PLAYER_1);
    }

    public int findGameCodeBySocketIOClient(SocketIOClient client) throws RemoteException {
        Game game = new Game();
        for (Game g : games) {
            if(g.getPlayer1().getSocketIOClient() == client || g.getPlayer2().getSocketIOClient() == client){
                game = g;
            }
        }

        return game.getCode();
    }
}
