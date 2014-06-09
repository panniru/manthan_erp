$(document ).ready(function() {
    $('body').on('focus',".datepicker", function(){
        $(this).datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
            dateFormat: 'dd/mm/yy'
        });
    });
    $('.collapse').collapse();

    $('#collapse-div0').on('show.bs.collapse', function () {
        $("#collapse-icon").removeClass("fa-angle-double-down").addClass("fa-angle-double-up")
    });

    $('#collapse-div0').on('hide.bs.collapse', function () {
        $("#collapse-icon").removeClass("fa-angle-double-up").addClass("fa-angle-double-down")
    });
});
