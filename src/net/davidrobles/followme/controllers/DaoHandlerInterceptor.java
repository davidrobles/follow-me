package net.davidrobles.followme.controllers;

import net.davidrobles.followme.dao.FollowMeDao;
import net.davidrobles.followme.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;
import java.util.Date;

public class DaoHandlerInterceptor implements HandlerInterceptor
{
    private final FollowMeDao dao;

    @Autowired
    public DaoHandlerInterceptor(FollowMeDao dao) {
        this.dao = dao;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        Principal principal = request.getUserPrincipal();
        if (dao != null && principal != null && modelAndView != null) {
            String username = request.getUserPrincipal().getName();
            modelAndView.addObject("logged_user", dao.findUserByUsername(username));
            modelAndView.addObject("dao", dao);
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
