package net.davidrobles.followme.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
public class SessionsController
{
    @RequestMapping("/login")
    public String login(Map<String, Object> model) {
        model.put("title", "Login");
        return "views/sessions/new";
    }

    @RequestMapping("/logout")
    public String logout() {
        return "redirect:/j_spring_security_logout";
    }
}
