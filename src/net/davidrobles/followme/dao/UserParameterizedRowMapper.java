package net.davidrobles.followme.dao;

import net.davidrobles.followme.models.User;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserParameterizedRowMapper implements ParameterizedRowMapper<User>
{
    @Override
    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new User(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("name"),
                        rs.getDate("created_at"));
    }
}
