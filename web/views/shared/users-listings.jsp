<script type="text/javascript">
    $(function() {
        $('.users-listing').find('button').mouseover(function() {
            if ($(this).text() == 'Following') {
                $(this).html('Unfollow');
                $(this).removeClass('btn-info');
                $(this).addClass('btn-danger');
            }
        }).mouseout(function(){
                    if ($(this).text() == 'Unfollow') {
                        $(this).html('Following');
                        $(this).addClass('btn-info');
                        $(this).removeClass('btn-important');
                    }
                });

        $('.users-listing').find('button').click(function(event) {
            the_button = $(this);
            if ($(this).text() == 'Follow') {
                $.ajax({
                    type: "POST",
                    url: "/users/${logged_user.getId()}/follow/" + $(this).prop('name')
                }).done(function( msg ) {
                            the_button.html('Following');
                            the_button.addClass('btn-info');
                        });
            } else {
                $.ajax({
                    type: "POST",
                    url: "/users/${logged_user.getId()}/unfollow/" + $(this).prop('name')
                }).done(function( msg ) {
                            the_button.html('Follow');
                            the_button.removeClass('btn-danger');
                            the_button.removeClass('btn-info');
                        });
            }
        });
    });
</script>

<ul class="users-listing">
    <c:forEach var="user" items="${users}">
        <li>
            <a href="/users/${user.getId()}"><img onerror="this.src='http://graph.facebook.com/testing/picture';" style="float: left;" src="http://graph.facebook.com/${user.getUsername()}/picture" alt="" /></a>
            <c:if test="${(user.getId() != logged_user.getId())}">
                <c:choose>
                    <c:when test="${user.getId() != logged_user.getId() && (dao.relationshipExist(logged_user.getId(), user.getId()))}">
                        <button id="user-button-${user.getId()}" name="${user.getId()}" class="btn btn-info" style="float: right">Following</button>
                    </c:when>
                    <c:otherwise>
                        <button id="user-button-${user.getId()}" name="${user.getId()}" class="btn" style="float: right">Follow</button>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <div style="margin-left: 60px">
                <a href="/users/${user.getId()}" class="user-name">${user.getName()}</a><br />
                <a class="username" href="/users/${user.getId()}">@${user.getUsername()}</a>
            </div>
            <div style="clear: both"></div>
        </li>
    </c:forEach>
</ul>