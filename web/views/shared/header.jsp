<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>${title} - FollowME</title>
    <link href="/css/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
    <link href="/css/drtwitter.css" media="all" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/bootstrap.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

</head>
<body style="padding-top: 50px;">
    <div class="container" style="width: 850px;">
        <div class="navbar navbar-fixed-top" style="z-index: 10000;">
            <div class="navbar-inner" style="padding-top: 10px;">
                <div class="container" style="width: 850px;">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="/">FollowME</a>
                    <div class="nav-collapse pull-right">
                        <ul class="nav">
                            <security:authorize access="isAuthenticated()" >
                                <form class="navbar-search pull-left" method="get" action="/search">
                                    <input name="q" type="text" class="search-query" placeholder="Search users" style="padding: 12px;">
                                </form>
                                <li><a href="/users/">All Users</a></li>
                                <li><a href="/tweets/">All Tweets</a></li>
                                <li><a href="/users/${logged_user.getId()}">Hi ${logged_user.getUsername()}</a></li>
                                <li><a href="/j_spring_security_logout">Logout</a></li>
                            </security:authorize>
                            <security:authorize access="isAnonymous()" >
                                <li><a href="/login">Log In</a></li>
                                <li><a href="/signup">Sign Up</a></li>
                            </security:authorize>
                        </ul>
                    </div>
                </div>
                <div style="clear: both;"></div>
            </div>
        </div>
    </div>
<div class="container" style="width: 850px;background-color: rgba(255,255,255,0.2); padding: 15px;">