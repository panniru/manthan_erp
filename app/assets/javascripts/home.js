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

function createAssessment(teacher_leader_id) {
    alert('hi');
    $('.calendar2').html("");
    $('.calendar2').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay',
            ignoreTimezone: false
        },
        
        events: '/admissions.json?teacher_leader_id='+teacher_leader_id,
        
        selectable: true,
        select: function(date) {
            alert("welcome "+ date);
            $('#selectdate').val(date)
            $('#myModal').modal('show');                
        }
    });
}


