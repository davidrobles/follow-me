<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../shared/header.jsp" %>

<div class="the-tweet">
    <div class="the-tweet-pic">
        <a href="/users/${tweet.getUserId()}"><img style="float: left;" src="http://graph.facebook.com/${dao.findUserById(tweet.getUserId()).getUsername()}/picture" alt="" /></a>
    </div>
    <div class="the-tweet-headline">
        <div class="the-tweet-name">${tweet.getUser().getName()}</div>
        <div class="the-tweet-username"><a href="/users/${tweet.getUser().getId()}">@${tweet.getUser().getUsername()}</a></div>
        <p class="the-tweet-content">${tweet.getContent()}</p>
        <hr />
        <p class="the-tweet-createdAt">${tweet.getCreatedAt()}</p>
    </div>
</div>

<%@include file="../shared/footer.jsp" %>