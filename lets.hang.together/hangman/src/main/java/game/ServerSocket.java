package game;

import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOServer;
import game.eventListeners.*;
import game.rmi.Game;
import game.rmi.ServerRMI;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

public class ServerSocket {
    public static List<Game> games = new ArrayList<>();
    public static ServerRMI serverRMI = new ServerRMI();

    public static void main(String[] args) throws RemoteException {
        Configuration configuration = new Configuration();
        configuration.setHostname("localhost");
        configuration.setPort(9090);
        SocketIOServer server = new SocketIOServer(configuration);

        try {
            serverRMI.startServerRMI();
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }

        server.addConnectListener(new ConnectionListener());

        server.addEventListener("requestToPlay", String.class, new RequestToPlayEventListener(games));

        server.addEventListener("letterGuess", String.class, new LetterGuessingEventListener(games));

        server.addEventListener("wordGuess", String.class, new WordGuessingEventListener(games));

        server.addEventListener("sendMessage", String.class, new SendMessageEventListener(games));


        server.start();
        System.out.println("Server je startovan na portu 9090");
    }
}




