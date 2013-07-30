package net.davidrobles.followme.controllers;

import net.davidrobles.followme.dao.FollowMeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class SearchController
{
    private final FollowMeDao dao;

    @Autowired
    public SearchController(FollowMeDao dao) {
        this.dao = dao;
    }

    @RequestMapping(value="/search", method= RequestMethod.GET)
    public String index(Map<String, Object> model, @RequestParam(value="q") String q) {
        model.put("usersHeader", "Search results for: " + q);
        model.put("users", dao.findUsersByKeyword(q));
        return "views/users/index";
    }
}
