package net.davidrobles.followme.dao;

import net.davidrobles.followme.models.Tweet;
import net.davidrobles.followme.models.User;

import java.util.List;

public interface FollowMeDao
{
    // Users

    List<User> getUsers();
    User findUserById(int userId);
    User findUserByUsername(String username);
    List<User> findUsersByKeyword(String keyword);
    boolean save(User user);
    void deleteUser(int userId);
    void deleteAllUsers();

    // Tweets

    List<Tweet> getTweets();
    List<Tweet> getTweets(long afterTime);
    Tweet findTweetById(int tweetId);
    List<Tweet> findTweetsByUserId(int userId);
    List<Tweet> findTweetsByUserId(int userId, long afterTime);
    List<Tweet> findTweetsByUserIdWithFollowing(int userId);
    List<Tweet> findTweetsByUserIdWithFollowing(int userId, long afterTime);
    boolean save(Tweet tweet);
    void deleteTweet(int tweetId);
    void deleteAllTweets();

    // Relationships

    boolean relationshipExist(int followerId, int followedId);
    void addRelationship(int followerId, int followedId);
    List<User> getFollowers(int userId);
    int getNumFollowers(int userId);
    List<User> getFolloweds(int userId);
    int getNumFolloweds(int userId);
    void removeRelationship(int followerId, int followedId);
}
