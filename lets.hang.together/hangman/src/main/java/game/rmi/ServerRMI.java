package game.rmi;


import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;

public class ServerRMI {
    public void startServerRMI() throws RemoteException {
        try {
            LocateRegistry.createRegistry(5050);

            System.out.println("RMI protokol je startovan na portu 5050");
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    public void createNewRegisterName(Game game){
        String gameName = "Game" + game.getCode();
        try {
            Naming.rebind("//localhost:5050/" + gameName, game);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        }
    }

}
