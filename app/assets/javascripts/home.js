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
    $("#adm-flot-placeholder").on("plotclick", function (event, pos, item) { 
        angular.element($('#adm-flot-placeholder')).scope().gridAdmDataPoint(item)
    });
    $("#sta-flot-placeholder").on("plotclick", function (event, pos, item) { 
        angular.element($('#sta-flot-placeholder')).scope().gridStaDataPoint(item)
    });
    
    $("#flot-placeholder1").on("plotclick", function (event, pos, item) {
        angular.element($('#flot-placeholder')).scope().gridDataPoint(item)
        //angular.element($('#flot-placeholder')).scope().gridDataPoint1(item)
    });

    $("#student_attendence_calendar").fullCalendar({
        events: [
            {
                title  : 'event1',
                start  : '2010-01-01',
                color: 'red'
            },
            {
                title  : 'event2',
                start  : '2014-07-05',
                end    : '2014-07-07',
                color : 'red'
            },
            {
                title  : 'event3',
                start  : '2014-07-09T12:30:00',
                allDay : true // will make the time show
            }
        ]
    })

    
});

function createAssessment(teacher_leader_id) {

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


function createStaffAssessment(staff_admission_id) {

    $('.calendar2').html("");
    $('.calendar2').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay',
            ignoreTimezone: false
        },
        
        events: '/staffrecruits.json?staff_admission_id='+staff_admission_id,
        
        selectable: true,
        select: function(date) {
            alert("welcome "+ date);
            $('#selectdate').val(date)
            $('#myModal').modal('show');                
        }
    });
}

$(document ).ready(function() {
    var modal = function(){
        $('body').on('click','.Modal', function(){
            $('#Modal').modal('show');
        });
    }
    modal();
});
