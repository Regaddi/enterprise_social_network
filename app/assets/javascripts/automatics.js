$(function() {
    window.setTimeout(function() {
        $('.alert').slideUp(400, function() {
            $(this).remove();
        });
    }, 2500);
    $('.dropdown-toggle').dropdown();
});