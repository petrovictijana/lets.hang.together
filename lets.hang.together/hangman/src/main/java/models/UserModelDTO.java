package models;

public class UserModelDTO {
    private String name;
    private String surname;
    private int level;
    private int score;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return "UserModelDTO{" +
                "name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", level=" + level +
                ", score=" + score +
                '}';
    }
}
