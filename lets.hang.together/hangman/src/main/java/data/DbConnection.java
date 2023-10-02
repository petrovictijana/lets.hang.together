package data;

import apis.WordModelAPIs;
import models.WordModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DbConnection implements WordModelAPIs {
    private final Connection _conn;
    private static DbConnection _dbConnection;

    public static DbConnection get_dbConnection() {
        if(_dbConnection == null)
            return new DbConnection();
        return _dbConnection;
    }

    private DbConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            _conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hangman", "root", "");
        } catch (InstantiationException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public WordModel getRandomWord() {
        String query = "SELECT * FROM words ORDER BY RAND() LIMIT 1;";
        try {
            Statement statement = _conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            if(resultSet.next()){
                WordModel wordModel = new WordModel();
                wordModel.setWord(resultSet.getString("word"));
                wordModel.setLevel(resultSet.getInt("level"));

                return wordModel;
            }
            return null;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return null;
        }
    }


    @Override
    public WordModel addNewWord(WordModel wordModel) {
        String query = "INSERT INTO `words`(`level`, `word`) VALUES (?, ?)";
        try {
            PreparedStatement preparedStatement = _conn.prepareStatement(query);
            preparedStatement.setString(1, wordModel.getWord());
            preparedStatement.setInt(2, wordModel.getLevel());

            int rowsUpdated = preparedStatement.executeUpdate();

            if(rowsUpdated != 0)
                return wordModel;
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<WordModel> getAllWords() {
        String query = "SELECT * FROM words";
        try {
            Statement statement = _conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            List<WordModel> wordModels = new ArrayList<>();
            while(resultSet.next()){
                WordModel wordModel = new WordModel();
                wordModel.setWord(resultSet.getString("word"));
                wordModel.setLevel(resultSet.getInt("level"));
                wordModel.setId(resultSet.getInt("id"));

                wordModels.add(wordModel);
            }

            return wordModels;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public boolean deleteWord(int id) {
        String query = "DELETE FROM `words` WHERE id = ?";
        try {
            PreparedStatement preparedStatement = _conn.prepareStatement(query);
            int rowsUpdated = preparedStatement.executeUpdate();

            if(rowsUpdated != 0)
                return true;
            return false;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean isWordAlreadyExist(String word) {
        String query = "SELECT * FROM words WHERE word = ?";
        try {
            PreparedStatement preparedStatement = _conn.prepareStatement(query);
            preparedStatement.setString(1, word);
            ResultSet resultSet = preparedStatement.executeQuery();

            if(resultSet == null)
                return false;
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}


