package net.davidrobles.followme.controllers;

import net.davidrobles.followme.dao.FollowMeDao;
import net.davidrobles.followme.models.Tweet;
import net.davidrobles.followme.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.*;

@Controller
public class TweetsController
{
    private final FollowMeDao dao;

    @Autowired
    public TweetsController(FollowMeDao dao) {
        this.dao = dao;
    }

    @RequestMapping(value="/tweets", method=RequestMethod.GET)
    public String index(Map<String, Object> model) {
        model.put("tweets", dao.getTweets());
        return "views/tweets/index";
    }

    @RequestMapping(value="/tweets/create", method=RequestMethod.POST)
    public String create(@RequestParam(value="tweet") String tweet, Principal principal) {
        if (principal != null && !tweet.isEmpty()) {
            User user = dao.findUserByUsername(principal.getName());
            dao.save(new Tweet(user.getId(), tweet));
            return "redirect:/users/" + user.getId();
        }
        return "redirect:/";
    }

    @RequestMapping("/tweets/{id}")
    public String show(@PathVariable("id") int tweetId, Map<String, Object> model) {
        model.put("tweet", dao.findTweetById(tweetId));
        return "views/tweets/show";
    }
}
