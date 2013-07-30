<%@include file="show-header.jsp" %>
<div id="tweets-feed" class="well">
<h2>Following</h2>
<c:choose>
    <c:when test="${users.isEmpty()}">
        <div class="alert alert-info">
            Following no one.
        </div>
    </c:when>
    <c:otherwise>
        <%@include file="../shared/users-listings.jsp" %>
    </c:otherwise>
</c:choose>
</div>
<%@include file="show-footer.jsp" %>


