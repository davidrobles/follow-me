<form class="well" action="/j_spring_security_check" method="POST" style="text-align: center;">
    <h3>Sign in to FollowME</h3><br />
    <% if (request.getParameter("login_error") != null) { %>
    <div class="alert alert-danger" style="width: 200px; margin: 0 auto 20px auto">
        Incorrect username or password.
    </div>
    <% } %>
    <fieldset>
        <input name="j_username" type="text" class="input" placeholder="Username"><br />
        <input name="j_password" type="password" class="input" placeholder="Password"><br />
        <button type="submit" class="btn btn-info">Sign in</button><br />
    </fieldset>
    <br />
    <h4>New to FollowME?</h4>
    <br />
    <h4><a href="/signup">Sign Up!</a></h4>
</form>