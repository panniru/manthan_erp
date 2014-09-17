$(document).ready(function() { 
    $('#dp1').datepicker({
        beforeShow: function () { 
            $('#ui-datepicker-div').css('z-index',9999); 
        },
        dateFormat: 'mm/dd/yy',
        beforeShowDay: function(date){
            return [(date < ($("#dp1").datepicker("getDate") || new Date()))];

        }
    });
});
