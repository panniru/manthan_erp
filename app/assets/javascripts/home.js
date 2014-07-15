$(document ).ready(function() {
    $('body').on('focus',".datepicker", function(){
        $(this).datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
            dateFormat: 'dd/mm/yy'
        });
    });

    $("#flot-placeholder").on("plotclick", function (event, pos, item) { 
        angular.element($('#flot-placeholder')).scope().gridDataPoint(item)
    });
    
    $("#flot-placeholder1").on("plotclick", function (event, pos, item) {
        angular.element($('#flot-placeholder')).scope().gridDataPoint(item)
        //angular.element($('#flot-placeholder')).scope().gridDataPoint1(item)
    });
});
