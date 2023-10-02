package game.chat.protocols;

public class PrivateMessage extends Message{
    private String to;

    public PrivateMessage() {
    }

    public PrivateMessage(String from, String message, String to) {
        super(from, message);
        this.to = to;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }
}
