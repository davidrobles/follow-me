<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:forEach var="tweet" items="${tweets}">
    <li class="tweet" id="${tweet.getCreatedAt().getTime()}">
        <div class="tweet-date">
            <fmt:formatDate pattern="MMMM d, yyyy 'at' HH:mm aaa" value="${tweet.getCreatedAt()}" />
        </div>
        <a class="tweet-pic" href="/users/${tweet.getUserId()}"><img onerror="this.src='http://graph.facebook.com/testing/picture';" style="float: left;" src="http://graph.facebook.com/${dao.findUserById(tweet.getUserId()).getUsername()}/picture" alt="" /></a>
        <div class="tweet-headline">
            <span class="tweet-name"><a href="/users/${tweet.getUserId()}">${dao.findUserById(tweet.getUserId()).getName()}</a></span>
            <span class="tweet-username"><a href="/users/${tweet.getUserId()}">@${dao.findUserById(tweet.getUserId()).getUsername()}</a></span>
        </div>
        <div class="tweet-content">${tweet.getContent()}</div>
    </li>
</c:forEach>
