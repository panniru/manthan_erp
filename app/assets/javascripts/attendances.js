
$(document).ready(function() { 


    if($(".fc-event").length > 0){
        $('.fc-event-inner').addClass("fc-state-disabled");
        alert("Image loaded.");
    }


    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    $('#attendance_calendar').html("");
    $('#attendance_calendar').fullCalendar({ 
        events: '/attendances/holidaycalendardata.json?month='+monthNames[today.getMonth()],
        height: '300px',
        selectable: true,
        select: function(date) {
            //alert(date+ "" + (date.getFullYear() + "-" + (date.getMonth()+1)+"-"+date.getDate())) 
            
            $.ajax({
                url: "/attendances/attendance_on_date.json",
                type: 'GET',
                data: {status: 'success',
                       date: (date.getFullYear() + "-" + (date.getMonth()+1)+"-"+date.getDate())
                      },
                success: function(data) {
                    angular.element($('#attendance_calendar')).scope().reflectStudents(data);
                }     
            });
        }
    });
});

