$(document ).ready(function() {   
    $('body').on('focus',".datepicker", function(){
        $(this).datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
            dateFormat: 'yy-mm-dd'
        });
    });
    $('body').on('focus',".academicDatepicker", function(){
        $(this).datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: new Date(gon.academicYearFrom, 1-1, 1),
            maxDate: new Date(gon.academicYearTo, 12-1, 31),
            dateFormat: 'dd/mm/yy'
        });
    });
});
