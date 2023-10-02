package game.eventListeners;

import apis.WordModelAPIs;
import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import data.DbConnection;
import game.ServerSocket;
import game.protocols.DTOs.InitializeGameDTO;
import game.protocols.Player;
import game.protocols.ProcessRequestModel;
import game.protocols.enums.GAME_STATUS;
import game.protocols.enums.ON_TURN;
import game.rmi.Game;
import game.rmi.IGame;
import models.WordModel;

import java.rmi.Naming;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

public class RequestToPlayEventListener implements DataListener<String> {
    WordModelAPIs apIs = DbConnection.get_dbConnection();
    List<Game> games;

    public RequestToPlayEventListener() {
    }

    public RequestToPlayEventListener(List<Game> games) {
        this.games = games;
    }

    @Override
    public void onData(SocketIOClient socketIOClient, String s, AckRequest ackRequest) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        Player player = objectMapper.readValue(s, Player.class);
        player.setSocketIOClient(socketIOClient);

        ProcessRequestModel processRequestModel = proccessRequestToPlay(player);

        Game game = processRequestModel.getGame();

        synchronized (game){
            if(processRequestModel.getGameStatus() == GAME_STATUS.WAITING_FOR_ANOTHER_PLAYER){
                game.wait();
            }
            else{
                game.notify();
                ServerSocket.serverRMI.createNewRegisterName(game);
            }
        }

        IGame iGame = (IGame) Naming.lookup("rmi://localhost:5050/Game" + game.getCode());

        InitializeGameDTO initializeGameDTO = new InitializeGameDTO();
        initializeGameDTO.setPlayer1Username(iGame.getPlayer1Username());
        initializeGameDTO.setPlayer2Username(iGame.getPlayer2Username());
        initializeGameDTO.setMissingWordLettersNumber(iGame.getMissingWordLettersNumber());
        initializeGameDTO.setAttemptsAvailable(iGame.getAvailableAttemptsNumber());
        initializeGameDTO.setPoints(iGame.getPointsNumber());

        Gson gson = new Gson();
        String initializeGameDTO_JSON = gson.toJson(initializeGameDTO);

        Game g = games.get(iGame.getGameCode());
        socketIOClient.sendEvent("initializeGame", initializeGameDTO_JSON);

        g.getPlayer2().getSocketIOClient().sendEvent("initializeGame", initializeGameDTO_JSON);
        Thread.sleep(1000);
        g.getPlayer2().getSocketIOClient().sendEvent("initializeGame", initializeGameDTO_JSON);
        Thread.sleep(1000);
        g.getPlayer2().getSocketIOClient().sendEvent("initializeGame", initializeGameDTO_JSON);

    }


    public ProcessRequestModel proccessRequestToPlay(Player player){
        if(games == null){
            games = new ArrayList<>();

            try {
                Game game = initializeGame(player);
                games.add(game);
                return new ProcessRequestModel(game, GAME_STATUS.WAITING_FOR_ANOTHER_PLAYER);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
        else{
            for (Game game: games) {
                if(game != null){
                    if(game.getPlayer1() != null && game.getPlayer2() == null){
                        game.setPlayer2(player);
                        return new ProcessRequestModel(game, GAME_STATUS.GAME_STARTED);
                    }
                }
            }

            try {
                Game game = initializeGame(player);
                games.add(game);
                return new ProcessRequestModel(game, GAME_STATUS.WAITING_FOR_ANOTHER_PLAYER);
            } catch (RemoteException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public Game initializeGame(Player player) throws RemoteException {
        Game game = new Game();
        WordModel wordModel = getRandomWord();

        game.setCode(games.size());
        game.setPlayer1(player);
        game.setPlayer2(null);
        game.setMissingWord(wordModel.getWord());
        game.setPoints(wordModel.getWord().length() + wordModel.getLevel());
        game.setOnTurn(ON_TURN.PLAYER_1);
        game.setAttemptsAvailable(10);
        game.setWinner(0);

        return game;
    }

    public WordModel getRandomWord(){
        return apIs.getRandomWord();
    }
}
