<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../shared/header.jsp" %>

<div class="rounded-widget" style="padding: 20px">
    <h2>${usersHeader}</h2>
    <%@include file="../shared/users-listings.jsp" %>
</div>

<%@include file="../shared/footer.jsp" %>