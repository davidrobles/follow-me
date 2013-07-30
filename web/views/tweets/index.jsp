<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../shared/header.jsp" %>

<script type="text/javascript">
    $(function() {
        $.ajax({
            type: "GET",
            url: "/api/tweets?afterTime=0"
        }).done(function( msg ) {
            $('ul.tweets-listing').prepend(msg);
            $('#loading-alert').css('display', 'none');
            if ($('ul.tweets-listing li:first-child').children().length > 0) {
                $('#empty-alert').css('display', 'none');
            } else {
                $('#empty-alert').css('display', 'block');
            }
        });
    });
</script>

<div class="well">
    <h2>All Tweets</h2>
    <div id="loading-alert" class="alert alert-warning">Loading tweets.</div>
    <div id="empty-alert" class="alert alert-info" style="display: none">No tweets.</div>
    <ul class="tweets-listing"></ul>
</div>

<%@include file="../shared/footer.jsp" %>
