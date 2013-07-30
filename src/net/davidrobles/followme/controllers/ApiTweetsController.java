package net.davidrobles.followme.controllers;

import net.davidrobles.followme.dao.FollowMeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class ApiTweetsController
{
    private final FollowMeDao dao;

    @Autowired
    public ApiTweetsController(FollowMeDao dao) {
        this.dao = dao;
    }

    @RequestMapping(value="/api/tweets", method=RequestMethod.GET)
    public String index(Map<String, Object> model, @RequestParam(value="afterTime") long afterTime) {
        model.put("tweets", dao.getTweets(afterTime));
        return "views/shared/tweets-partial";
    }

    @RequestMapping(value="/api/users/{userId}/tweets", method=RequestMethod.GET)
    public String indexByUser(Map<String, Object> model, @PathVariable("userId") int userId,
                              @RequestParam(value="afterTime") long afterTime) {
        model.put("tweets", dao.findTweetsByUserIdWithFollowing(userId, afterTime));
        return "views/shared/tweets-partial";
    }
}
