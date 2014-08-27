$(document).ready(function() { 
   
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var today = new Date();
    $('#attendance_calendar').html("");
    $('#attendance_calendar').fullCalendar({      
        events: '/holidaycalendars/holidaycalendardata.json?month='+monthNames[today.getMonth()],
        selectable: true,
        eventMouseover: function(data, event, view) {            
          
	},
       
        select: function(date) {
           // var checkUrl = "holidaycalendars/holiday_exists.json?date="+dateFormat    

            angular.element($('#myModal')).scope().dailyAttendence(date)
        }            
    });
    });

