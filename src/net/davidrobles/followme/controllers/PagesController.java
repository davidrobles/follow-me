package net.davidrobles.followme.controllers;

import net.davidrobles.followme.dao.FollowMeDao;
import net.davidrobles.followme.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.Map;

@Controller
public class PagesController
{
    private final FollowMeDao dao;

    @Autowired
    public PagesController(FollowMeDao dao) {
        this.dao = dao;
    }

    @RequestMapping("/")
    public String home(Principal principal) {
        if (principal != null) {
            User user = dao.findUserByUsername(principal.getName());
            return "redirect:/users/" + user.getId();
        }
        return "redirect:/login";
    }

    @RequestMapping("/about")
    public String about(Map<String, Object> model) {
        model.put("title", "About");
        return "views/pages/about";
    }
}
