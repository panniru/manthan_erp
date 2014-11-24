function myFunction(date){
    
    angular.element($('.myFunction')).scope().todayAttendence(date)
}

$(document).ready(function() { 
    var today = new Date();
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    $('#attendance_calendar').html("");
    var today = new Date();
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

