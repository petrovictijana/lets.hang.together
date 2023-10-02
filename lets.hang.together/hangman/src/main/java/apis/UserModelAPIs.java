package apis;

import models.UserModel;
import models.UserModelDTO;

import java.util.List;

public interface UserModelAPIs {
    List<UserModel> getAllUsers();
    UserModel checkUserForLogin(String username, String password);
    boolean isUsernameTaken(String username);
    boolean createUser(UserModel userModel);
    List<UserModelDTO> getTop3Players();
    boolean deleteUserById(int id);
    boolean addPointsByUsername(String username, int points);
    int getScoreById(int id);
}
