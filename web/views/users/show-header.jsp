<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../shared/header.jsp" %>

<script type="text/javascript">
    function open_tweet_widget() {
        $('#tweet-chars-count').show();
        $('#new-tweet-content').css('height', '100px')
    }
    function close_tweet_widget() {
        $('#new-tweet-content').css('height', '40px')
        $('#tweet-chars-count').hide();
    }
    function keypressed_in_tweet_textarea() {
        len = $("#new-tweet-content").val().length;
        $("#tweet-chars-count").html(len);
        if (len > 0 && len <=140) {
            $('#new-tweet-btn').prop('disabled', false);
        } else
            $('#new-tweet-btn').prop('disabled', true);
    }
    $(function() {
        $("#new-tweet-content").keydown(function() {
            keypressed_in_tweet_textarea();
        });
        $("#new-tweet-content").keypress(function() {
            keypressed_in_tweet_textarea();
        });
        flag = 0
        $('#new-tweet-content').focus(function(event) {
            if (flag == 0) {
                flag = 1;
                open_tweet_widget();
            }
        });
        $('#new-tweet-content').change(function(event) {
//            alert($('#new-tweet-content').val().length);
        });
        $('#new-tweet-btn').click(function(event) {
            $('#new-tweet-btn').prop('disabled', true);
            $('#new-tweet-content').prop('disabled', true);
            $.ajax({
                type: "POST",
                url: "/tweets/create",
                data: {tweet: $('#new-tweet-content').prop('value')}
            }).done(function( msg ) {
                        $('#new-tweet-btn').prop('disabled', false);
                        $('#new-tweet-content').prop('disabled', false);
                        $('#new-tweet-content').prop('value', '');
                        close_tweet_widget();
                        update_tweets();
                    });
        });
        $('#followbtn').css('font-weight', 'bold')
        $('#followbtn').click(function(event) {
            if ($('#followbtn').text() == 'Follow') {
                $.ajax({
                    type: "POST",
                    url: "/users/${logged_user.getId()}/follow/${user.getId()}"
                }).done(function( msg ) {
                            $('#followbtn').html('Following')
                            $('#followbtn').addClass('btn-info')
                            $('#followers-count').html('1')
                        });
            } else {
                $.ajax({
                    type: "POST",
                    url: "/users/${logged_user.getId()}/unfollow/${user.getId()}"
                }).done(function( msg ) {
                            $('#followbtn').html('Follow')
                            $('#followbtn').removeClass('btn-danger')
                            $('#followbtn').removeClass('btn-info')
                            $('#followers-count').html('0')
                        });
            }
        });

        $("#followbtn").mouseover(function() {
            if ($('#followbtn').text() == 'Following') {
                $('#followbtn').html('Unfollow')
                $('#followbtn').removeClass('btn-info')
                $('#followbtn').addClass('btn-danger')
            }
        }).mouseout(function(){
            if ($('#followbtn').text() == 'Unfollow') {
                $('#followbtn').html('Following')
                $('#followbtn').addClass('btn-info')
                $('#followbtn').removeClass('btn-important')
            }
        });
    });

//    var i = 1;                     //  set your counter to 1
//
//    function myLoop () {           //  create a loop function
//        setTimeout(function () {    //  call a 3s setTimeout when the loop is called
//            $('#tweet-chars-count').html('sap')
//            i++;                     //  increment the counter
//            if (i < 10) {            //  if the counter < 10, call the loop function
//                myLoop();             //  ..  again which will trigger another
//            }                        //  ..  setTimeout()
//        }, 5000)
//    }
//    myLoop();
</script>

<div class="logged-user-widget">
    <div class="user-info">
        <a href="/users/${user.getId()}">

                <img onerror="this.src='http://graph.facebook.com/testing/picture';" style="float: left;" src="http://graph.facebook.com/${user.getUsername()}/picture" alt="" />

        </a>
        <div class="content">
            <c:if test="${user.getId() == logged_user.getId()}">
                <span class="label label-important" style="float: right;">You</span>
            </c:if>
            <c:if test="${(user.getId() != logged_user.getId()) && (dao.relationshipExist(user.getId(), logged_user.getId()))}">
                <span class="label">Follows you</span>
            </c:if>
            <c:if test="${(user.getId() != logged_user.getId())}">
                <c:choose>
                    <c:when test="${user.getId() != logged_user.getId() && (dao.relationshipExist(logged_user.getId(), user.getId()))}">
                        <a name="something" id="followbtn" href="#" class="btn btn-info" style="float: right;">Following</a>
                    </c:when>
                    <c:otherwise>
                        <a name="something" id="followbtn" href="#" class="btn" style="float: right;">Follow</a>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <p class="name">${user.getName()}</p>
            <p class="profile-page">@${user.getUsername()}</p>
        </div>
        <div style="clear: both;"></div>
    </div>
    <table class="logged-user-widget">
        <tr>
            <td><a href="/users/${user.getId()}"><span class="count">${numTweets}</span><br /><span class="type">Tweets</span></a></td>
            <td><a href="/users/${user.getId()}/following"><span id="following-count" class="count">${numFolloweds}</span><br /><span class="type">Following</span></a></td>
            <td><a href="/users/${user.getId()}/followers"><span id="followers-count" class="count">${numFollowers}</span><br /><span class="type">Followers</span></a></td>
        </tr>
    </table>
    <security:authorize access="isAuthenticated()" >
        <c:if test="${user.getId() == logged_user.getId()}">
            <%--<form method="post" action="/hola23">--%>
            <div style="padding: 10px;">
                <textarea maxlength="140" style="width: 100%; padding: 8px; height: 50px;" id="new-tweet-content" name="tweet" type="text" class="input" placeholder="New Teet..."></textarea><br />
                <button disabled="disabled" style="float: right;" id="new-tweet-btn" type="submit" class="btn btn-info">Tweet</button>
                <div id="tweet-chars-count" style="font-size: 14px; font-weight: bold; display: none;">0</div>
                <br style="clear: both;" />
                <br style="clear: both;" />
            </div>

            <%--</form>--%>
        </c:if>
    </security:authorize>
</div>
