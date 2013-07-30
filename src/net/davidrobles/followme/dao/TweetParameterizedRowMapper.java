package net.davidrobles.followme.dao;

import net.davidrobles.followme.models.Tweet;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class TweetParameterizedRowMapper implements ParameterizedRowMapper<Tweet>
{
    @Override
    public Tweet mapRow(ResultSet rs, int rowNum) throws SQLException {
        Tweet tweet = new Tweet(rs.getInt("id"),
                                rs.getInt("user_id"),
                                rs.getString("content"),
                                new Date(rs.getTimestamp("created_at").getTime()));
        return tweet;
    }
}
