package game.eventListeners;

import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.listener.ConnectListener;

public class ConnectionListener implements ConnectListener {
    @Override
    public void onConnect(SocketIOClient socketIOClient) {
        System.out.println("Nov klijent je konektovan: " + socketIOClient.getSessionId());

    }
}
