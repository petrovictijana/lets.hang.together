package game.protocols;

import com.corundumstudio.socketio.SocketIOClient;

import java.io.Serializable;


public class Player implements Serializable {
    private String username;
    private SocketIOClient socketIOClient;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public SocketIOClient getSocketIOClient() {
        return socketIOClient;
    }

    public void setSocketIOClient(SocketIOClient socketIOClient) {
        this.socketIOClient = socketIOClient;
    }
}


