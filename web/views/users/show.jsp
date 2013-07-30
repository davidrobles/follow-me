<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="show-header.jsp" %>

<script type="text/javascript">

    var last_update = new Date(0);

    function update_tweets() {
        $.ajax({
            type: "GET",
            url: "/api/users/${user.getId()}/tweets?afterTime=" + (Math.round(last_update.getTime() / 1000))
        }).done(function(msg) {
            $('ul.tweets-listing').prepend(msg);
//            var date_str = $('ul.tweets-listing li:first-child').prop('id');
//            last_update = new Date(parseInt(date_str));
            $('#loading-alert').css('display', 'none');
//            if ($('ul.tweets-listing li:first-child').children().length > 0) {
            if ($('ul.tweets-listing').children().length > 0) {
                var date_str = $('ul.tweets-listing li:first-child').prop('id');
                last_update = new Date(parseInt(date_str));
                $('#empty-alert').css('display', 'none');
            } else {
                $('#empty-alert').css('display', 'block');
            }
        });
    }

    $(function() {
        animation();
    });

    function animation() {
        update_tweets();
        setTimeout(jQuery.proxy(this, 'animation'), 5000);
    }


</script>

<div id="tweets-feed" class="well">
    <h2>Tweets</h2>
    <div id="loading-alert" class="alert alert-warning">Loading tweets.</div>
    <div id="empty-alert" class="alert alert-info" style="display: none">No tweets.</div>
    <ul class="tweets-listing">

    </ul>
</div>

<%@include file="show-footer.jsp" %>