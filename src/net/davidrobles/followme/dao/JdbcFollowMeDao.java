package net.davidrobles.followme.dao;

import net.davidrobles.followme.models.Tweet;
import net.davidrobles.followme.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JdbcFollowMeDao implements FollowMeDao
{
    @Autowired
    private NamedParameterJdbcTemplate jdbc;

    public void setJdbc(NamedParameterJdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    /////////////
    // CACHING //
    /////////////

    private Map<Integer, User> usersCache = new HashMap<Integer, User>();

    ///////////
    // USERS //
    ///////////

    private static final String SQL_INSERT_USER =
            "INSERT INTO users (username, email, password, name) " +
                    "VALUES (:username, :email, :password, :name)";
    private static final String SQL_SELECT_USERS =
            "SELECT id, username, email, password, name, created_at FROM users";
    private static final String SQL_SELECT_USER_BY_ID =
            SQL_SELECT_USERS + " WHERE id = :id";
    private static final String SQL_SELECT_USER_BY_USERNAME =
            SQL_SELECT_USERS + " WHERE username = :username";
    private static final String SQL_SELECT_USERS_WITH_QUERY =
            SQL_SELECT_USERS + " WHERE username LIKE :query OR name LIKE :query";
    private static final String SQL_DELETE_USERS = "DELETE FROM users";
    private static final String SQL_DELETE_USER_BY_ID = SQL_DELETE_USERS + " WHERE id = :id";

    @Override
    public List<User> getUsers() {
        return jdbc.query(SQL_SELECT_USERS, new HashMap<String, Object>(), new UserParameterizedRowMapper());
    }

    @Override
    public User findUserById(int id) {
//        if (usersCache.containsKey(id))
//            return usersCache.get(id);
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("id", id);
        User user = jdbc.queryForObject(SQL_SELECT_USER_BY_ID, args, new UserParameterizedRowMapper());
//        if (user != null)
//            usersCache.put(id, user);
        return user;
    }

    @Override
    public User findUserByUsername(String username) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("username", username);
        return jdbc.queryForObject(SQL_SELECT_USER_BY_USERNAME, args, new UserParameterizedRowMapper());
    }

    @Override
    public List<User> findUsersByKeyword(String query) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("query", "%" + query + "%");
        return jdbc.query(SQL_SELECT_USERS_WITH_QUERY, args, new UserParameterizedRowMapper());
    }

    @Override
    public boolean save(User user) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("username", user.getUsername());
        params.put("password", new Md5PasswordEncoder().encodePassword(user.getPassword(), null));
        params.put("email", user.getEmail());
        params.put("name", user.getName());
        int rowsAffected = 0;
        try {
            rowsAffected = jdbc.update(SQL_INSERT_USER, params);
        } catch (DataAccessException e) { }
        if (rowsAffected > 0)
            user.setId(findUserByUsername(user.getUsername()).getId());
        return rowsAffected > 0 ? true : false;
    }

    @Override
    public void deleteUser(int userId) {

    }

    @Override
    public void deleteAllUsers() {
        deleteAllTweets();
        jdbc.update(SQL_DELETE_USERS, new HashMap<String, Object>());
    }

    ////////////
    // TWEETS //
    ////////////

    private static final String SQL_SELECT_TWEETS =
            "SELECT id, content, user_id, created_at FROM tweets " +
                    "WHERE created_at > FROM_UNIXTIME(:after_time) " +
                    "ORDER BY created_at DESC";

    private static final String SQL_SELECT_TWEET_BY_ID =
            "SELECT id, content, user_id, created_at FROM tweets " +
                    "WHERE id = :id ORDER BY created_at DESC";

    private static final String SQL_SELECT_TWEETS_BY_USER_ID =
            "SELECT id, content, user_id, created_at FROM tweets " +
                    "WHERE user_id = :user_id AND created_at > FROM_UNIXTIME(:after_time) " +
                    "ORDER BY created_at DESC";

    private static final String SQL_SELECT_TWEETS_BY_USER_ID_WITH_FOLLOWING =
            "SELECT id, content, user_id, created_at FROM tweets " +
                    "WHERE user_id = :user_id AND created_at > FROM_UNIXTIME(:after_time) " +
                    "UNION " +
                    "SELECT t.id, t.content, t.user_id, t.created_at " +
                    "FROM tweets t, relationships r " +
                    "WHERE r.follower_id = :user_id AND r.followed_id = t.user_id " +
                    "AND t.created_at > FROM_UNIXTIME(:after_time) ORDER BY created_at DESC";

    private static final String SQL_INSERT_TWEET =
            "INSERT INTO tweets (content, user_id) VALUES (:content, :user_id)";

    private static final String SQL_DELETE_TWEETS =
            "DELETE FROM tweets";

    @Override
    public List<Tweet> getTweets() {
        return getTweets(0);
    }

    @Override
    public List<Tweet> getTweets(long afterTime) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("after_time", afterTime);
        return jdbc.query(SQL_SELECT_TWEETS, args, new TweetParameterizedRowMapper());
    }

    @Override
    public Tweet findTweetById(int tweetId) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("id", tweetId);
        return jdbc.queryForObject(SQL_SELECT_TWEET_BY_ID, args, new TweetParameterizedRowMapper());
    }

    @Override
    public List<Tweet> findTweetsByUserId(int userId) {
        return findTweetsByUserId(userId, 0);
    }

    @Override
    public List<Tweet> findTweetsByUserId(int userId, long afterTime) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user_id", userId);
        map.put("after_time", afterTime);
        return jdbc.query(SQL_SELECT_TWEETS_BY_USER_ID, map, new TweetParameterizedRowMapper());
    }

    @Override
    public List<Tweet> findTweetsByUserIdWithFollowing(int userId) {
        return findTweetsByUserIdWithFollowing(userId, 0);
    }

    @Override
    public List<Tweet> findTweetsByUserIdWithFollowing(int userId, long afterTime) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user_id", userId);
        map.put("after_time", afterTime);
        return jdbc.query(SQL_SELECT_TWEETS_BY_USER_ID_WITH_FOLLOWING, map, new TweetParameterizedRowMapper());
    }

    @Override
    public boolean save(Tweet tweet) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("content", tweet.getContent());
        params.put("user_id", tweet.getUserId());
        int rowsAffected = 0;
        try {
            rowsAffected = jdbc.update(SQL_INSERT_TWEET, params);
        } catch (DataAccessException e) {
            System.out.println(e);
        }
        return rowsAffected > 0 ? true : false;
    }

    @Override
    public void deleteTweet(int tweetId) {

    }

    @Override
    public void deleteAllTweets() {
        jdbc.update(SQL_DELETE_TWEETS, new HashMap<String, Object>());
    }

    ///////////////////
    // RELATIONSHIPS //
    ///////////////////

    private static final String SQL_INSERT_RELATIONSHIP =
            "INSERT INTO relationships (follower_id, followed_id) VALUES (:follower_id, :followed_id)";
    private static final String SQL_SELECT_FOLLOWERS = "SELECT id, username, email, password, name, created_at " +
            "FROM users u, relationships r " +
            "WHERE u.id = r.follower_id AND r.followed_id = :followed_id";
    private static final String SQL_NUM_FOLLOWERS = "SELECT COUNT(*) " +
            "FROM users u, relationships r " +
            "WHERE u.id = r.follower_id AND r.followed_id = :followed_id";
    private static final String SQL_SELECT_FOLLOWEDS = "SELECT id, username, email, password, name, created_at " +
            "FROM users u, relationships r " +
            "WHERE u.id = r.followed_id AND r.follower_id = :follower_id";
    private static final String SQL_NUM_FOLLOWEDS = "SELECT COUNT(*) " +
            "FROM users u, relationships r " +
            "WHERE u.id = r.followed_id AND r.follower_id = :follower_id";

    private static final String SQL_RELATIONSHIP_COUNT = "SELECT COUNT(*) " +
            "FROM relationships " +
            "WHERE follower_id = :follower_id AND followed_id = :followed_id";

    private static final String SQL_DELETE_RELATIONSHIP =
            "DELETE FROM relationships WHERE follower_id = :follower_id AND followed_id = :followed_id";

    @Override
    public void addRelationship(int followerId, int followedId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("follower_id", followerId);
        params.put("followed_id", followedId);
        jdbc.update(SQL_INSERT_RELATIONSHIP, params);
    }

    @Override
    public List<User> getFollowers(int userId) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("followed_id", userId);
        return jdbc.query(SQL_SELECT_FOLLOWERS, args, new UserParameterizedRowMapper());
    }

    @Override
    public int getNumFollowers(int userId) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("followed_id", userId);
        return jdbc.queryForInt(SQL_NUM_FOLLOWERS, args);
    }

    @Override
    public List<User> getFolloweds(int userId) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("follower_id", userId);
        return jdbc.query(SQL_SELECT_FOLLOWEDS, args, new UserParameterizedRowMapper());
    }

    @Override
    public int getNumFolloweds(int userId) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("follower_id", userId);
        return jdbc.queryForInt(SQL_NUM_FOLLOWEDS, args);
    }

    @Override
    public boolean relationshipExist(int followerId, int followedId) {
        Map<String, Object> args = new HashMap<String, Object>();
        args.put("follower_id", followerId);
        args.put("followed_id", followedId);
        return jdbc.queryForInt(SQL_RELATIONSHIP_COUNT, args) > 0;
    }

    @Override
    public void removeRelationship(int followerId, int followedId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("follower_id", followerId);
        params.put("followed_id", followedId);
        jdbc.update(SQL_DELETE_RELATIONSHIP, params);
    }
}
