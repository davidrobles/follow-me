package net.davidrobles.followme.controllers;

import net.davidrobles.followme.dao.FollowMeDao;
import net.davidrobles.followme.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
public class UsersController
{
    private final FollowMeDao dao;

    @Autowired
    public UsersController(FollowMeDao dao) {
        this.dao = dao;
    }

    @RequestMapping(value="/signup", method=RequestMethod.GET)
    public String newUser(Map<String, Object> model) {
        model.put("title", "Sign Up");
        model.put("user", new User());
        return "views/users/new";
    }

    @RequestMapping(value="/users", method=RequestMethod.GET)
    public String index(Map<String, Object> model) {
        model.put("users", dao.getUsers());
        model.put("usersHeader", "All users");
        return "views/users/index";
    }

    @RequestMapping(value="/users", method=RequestMethod.POST)
    public String create(Map<String, Object> model, @Valid User user, BindingResult bindingResult) {
        model.put("title", "Sign Up");
        model.put("duplicated", false);
        if (bindingResult.hasErrors())
            return "views/users/new";
        if (dao.save(user))
            return "views/users/create";
        else {
            model.put("duplicated", true);
            return "views/users/new";
        }
    }

    @RequestMapping("/users/{id}")
    public String show(@PathVariable("id") int userId, Map<String, Object> model) {
        User user = dao.findUserById(userId);
        model.put("user", user);
        model.put("title", "@" + user.getUsername());
        model.put("tweets", dao.findTweetsByUserIdWithFollowing(userId));
        model.put("numTweets", dao.findTweetsByUserId(userId).size());
        model.put("numFollowers", dao.getNumFollowers(userId));
        model.put("numFolloweds", dao.getNumFolloweds(userId));
        model.put("emailHash", new Md5PasswordEncoder().encodePassword(user.getEmail(), null));
        return "views/users/show";
    }

    @RequestMapping("/users/{id}/following")
    public String following(@PathVariable("id") int userId, Map<String, Object> model) {
        User user = dao.findUserById(userId);
        model.put("user", user);
        model.put("title", "@" + user.getUsername() + "'s Followers");
        model.put("numTweets", dao.findTweetsByUserId(userId).size());
        model.put("numFollowers", dao.getNumFollowers(userId));
        model.put("numFolloweds", dao.getNumFolloweds(userId));
        model.put("users", dao.getFolloweds(userId));
        return "views/users/following";
    }

    @RequestMapping("/users/{id}/followers")
    public String followers(@PathVariable("id") int userId, Map<String, Object> model) {
        User user = dao.findUserById(userId);
        model.put("user", user);
        model.put("title", "@" + user.getUsername() + "'s Followers");
        model.put("numTweets", dao.findTweetsByUserId(userId).size());
        model.put("numFollowers", dao.getNumFollowers(userId));
        model.put("numFolloweds", dao.getNumFolloweds(userId));
        model.put("users", dao.getFollowers(userId));
        return "views/users/followers";
    }

    @RequestMapping("/users/{id}/follow/{followed_id}")
    public String follow(@PathVariable("id") int userId, @PathVariable("followed_id") int followedId) {
        dao.addRelationship(userId, followedId);
        return "redirect:/";
    }

    @RequestMapping("/users/{id}/unfollow/{followed_id}")
    public String unfollow(@PathVariable("id") int userId, @PathVariable("followed_id") int followedId) {
        dao.removeRelationship(userId, followedId);
        return "redirect:/";
    }
}
