<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../shared/header.jsp" %>
<div class="well">
    <sf:form action="/users" method="POST" modelAttribute="user" style="text-align: center;">
        <h3>Join FollowME!</h3><br />
        <c:if test="${duplicated == true}">
            <div class="alert alert-error">Username or email already taken!</div>
        </c:if>
        <fieldset>
            <sf:input path="name" id="user_name" placeholder="Full name" />
            <sf:errors path="name" cssClass="form-error" />
            <br />
            <sf:input path="email" id="user_email" placeholder="Email" />
            <sf:errors path="email" cssClass="form-error" />
            <br />
            <sf:password path="password" id="user_password" placeholder="Password" />
            <sf:errors path="password" cssClass="form-error" />
            <br />
            <sf:input path="username" id="user_username" placeholder="Username" />
            <sf:errors path="username" cssClass="form-error" />
            <br />
            <button type="submit" class="btn btn-warning">Create my account</button>
        </fieldset>
    </sf:form>
    <hr />
</div>
<%@include file="../shared/footer.jsp" %>
