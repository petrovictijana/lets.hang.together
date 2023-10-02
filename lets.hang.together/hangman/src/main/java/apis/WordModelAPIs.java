package apis;

import models.WordModel;

import java.util.List;

public interface WordModelAPIs {
    WordModel getRandomWord();
    WordModel addNewWord(WordModel wordModel);
    List<WordModel> getAllWords();
    boolean deleteWord(int id);
    boolean isWordAlreadyExist(String word);
}
