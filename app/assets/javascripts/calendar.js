$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        events: '/events.json'        // put your options and callbacks here
    })

});
$(function () {
    $(":file").change(function () {
        //alert("Display image")
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = imageIsLoaded;
            reader.readAsDataURL(this.files[0]);
        }
    });
});

function imageIsLoaded(e) {
    $('#myImg').attr('src', e.target.result);
};


$(document).ready(function(){
    $('input.timepicker').timepicker({});
});
$(function() {
    $('.date-picker-year').datepicker({
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'yy',
        onClose: function(dateText, inst) { 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, 1));
        }
    });
    $(".date-picker-year").focus(function () {
        $(".ui-datepicker-month").hide();
    });
});
