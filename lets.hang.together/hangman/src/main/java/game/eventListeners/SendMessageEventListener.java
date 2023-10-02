package game.eventListeners;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.DataListener;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import game.chat.protocols.PrivateMessage;
import game.rmi.Game;

import java.rmi.RemoteException;
import java.util.List;

public class SendMessageEventListener implements DataListener<String> {
    List<Game> games;

    public SendMessageEventListener() {
    }

    public SendMessageEventListener(List<Game> games) {
        this.games = games;
    }

    @Override
    public void onData(SocketIOClient socketIOClient, String s, AckRequest ackRequest) throws Exception {
        int gameCode = findGameCodeBySocketIOClient(socketIOClient);
        Game game = games.get(gameCode);

        ObjectMapper objectMapper = new ObjectMapper();
        PrivateMessage privateMessage = objectMapper.readValue(s, PrivateMessage.class);

        //sender, receiver, message
        SocketIOClient receiver = game.getPlayer1().getUsername().equals(privateMessage.getFrom()) ? game.getPlayer2().getSocketIOClient() : game.getPlayer1().getSocketIOClient();

        Gson gson = new Gson();
        String privateMessage_JSON = gson.toJson(privateMessage);
        receiver.sendEvent("messageReceived", privateMessage_JSON);

    }

    public int findGameCodeBySocketIOClient(SocketIOClient client) throws RemoteException {
        Game game = new Game();
        if(games != null){
            for (Game g : games) {
                if(g.getPlayer1().getSocketIOClient() == client || g.getPlayer2().getSocketIOClient() == client){
                    game = g;
                }
            }
        }

        return game.getCode();
    }
}
