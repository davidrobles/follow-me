package net.davidrobles.followme.models;

import java.util.*;

public class Tweet
{
    private int id;
    private int userId;
    private String content;
    private Date createdAt;

    public Tweet(int id, int userId, String content, Date createdAt) {
        this.id = id;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
    }

    public Tweet(int userId, String content) {
        this(0, userId, content, null);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public String getContent() {
        return content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }
    
    @Override
    public String toString() {
        return String.format("Tweet { id: %s, user_id: \"%s\", content: \"%s\", createdAt: \"%s\" }",
                id, userId, content, createdAt);
    }
}
