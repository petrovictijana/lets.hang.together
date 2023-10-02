package data;

import apis.UserModelAPIs;
import jakarta.persistence.*;
import models.UserModel;
import models.UserModelDTO;

import java.util.ArrayList;
import java.util.List;

public class DbConnectionJPA implements UserModelAPIs {
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("userModelPersistence");
    EntityManager entityManager = emf.createEntityManager();

    public DbConnectionJPA() {
    }

    @Override
    public List<UserModel> getAllUsers() {
        List<UserModel> users = entityManager.createNativeQuery("SELECT * FROM users", UserModel.class)
                .getResultList();

        return users;
    }

    @Override
    public UserModel checkUserForLogin(String username, String password) {
        String query = "SELECT u FROM UserModel u WHERE u.username = :username AND u.password = :password";
        try{
            UserModel userModel = entityManager.createQuery(query, UserModel.class)
                    .setParameter("username", username)
                    .setParameter("password", password)
                    .getSingleResult();

            return userModel;
        }
        catch (NoResultException e){
            return null;
        }
        catch (NonUniqueResultException e){
            return null;
        }
    }

    @Override
    public boolean isUsernameTaken(String username) {
        String query = "SELECT COUNT(u.username) FROM UserModel u WHERE u.username = :username";
        long count = entityManager.createQuery(query, Long.class)
                .setParameter("username", username)
                .getSingleResult();

        return count > 0;
    }

    @Override
    public boolean createUser(UserModel userModel) {
        EntityTransaction entityTransaction = entityManager.getTransaction();

        try{
            entityTransaction.begin();
            entityManager.persist(userModel);
            entityTransaction.commit();
            return true;
        }
        catch (Exception e){
            if (entityTransaction != null && entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<UserModelDTO> getTop3Players() {
        String query = "SELECT * FROM users WHERE role_id = 2 ORDER BY score  DESC, name ASC LIMIT 3";
        List<UserModel> users = entityManager.createNativeQuery(query, UserModel.class)
                .getResultList();

        List<UserModelDTO> top3Users = new ArrayList<>();
        for (UserModel userModel: users) {
            UserModelDTO user = new UserModelDTO();
            user.setName(userModel.getName());
            user.setSurname(userModel.getSurname());
            user.setLevel(userModel.getLevel());
            user.setScore(userModel.getScore());

            top3Users.add(user);
        }

        return top3Users;
    }

    @Override
    public boolean deleteUserById(int id) {
        EntityTransaction entityTransaction = entityManager.getTransaction();

        try{
            entityTransaction.begin();

            UserModel userModel = entityManager.find(UserModel.class, id);
            if(userModel != null)
                entityManager.remove(userModel);

            entityTransaction.commit();
            return true;
        }
        catch (Exception e){
            if (entityTransaction != null && entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            return false;
        }
    }

    @Override
    public boolean addPointsByUsername(String username, int points) {
        EntityTransaction entityTransaction = entityManager.getTransaction();
        try{
            entityTransaction.begin();

            String query = "SELECT u FROM UserModel u WHERE u.username = :username";
            UserModel userModel = (UserModel) entityManager.createQuery(query, UserModel.class)
                    .setParameter("username", username)
                    .getSingleResult();

            if(userModel != null){
                userModel.setScore(userModel.getScore() + points);
                entityManager.merge(userModel);

                entityTransaction.commit();
                return true;
            }
            else{
                entityTransaction.rollback();
                return false;
            }
        }
        catch (NoResultException e){
            return false;
        }
        catch (NonUniqueResultException e){
            return false;
        }
        catch (Exception e){
            if (entityTransaction != null && entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            return false;
        }
    }

    @Override
    public int getScoreById(int id) {
        UserModel userModel = entityManager.find(UserModel.class, id);

        if(userModel != null)
            return userModel.getScore();
        return 0;
    }
}
