$(document).ready(function() { 
   
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var date = new Date();
    var day  = date.getDate();
    var month = date.getMonth() + 1;              
    var year =  date.getFullYear();
    alert(day + '-' + month + '-' + year);
    $('#attendance_calendar').html("");
    $('#attendance_calendar').fullCalendar({ 
        events: '/attendances/holidaycalendardata.json?month='+monthNames[date.getMonth()],
        selectable: true,
        dayClick: function(date, allDay, jsEvent, view) {
            var myDate = new Date();
            var daysToAdd = 0;
            myDate.setDate(myDate.getDate() + daysToAdd);
            if (date < myDate) {
                angular.element($('#myTable')).scope().dailyAttendence(date)
                alert("You can mark attendance on this day!");
            } else {
               // $("#attendance_calendar").hide();
                alert("You can't mark attendance on this day!..");
            }

        }
        // select: function(date) {
        //     angular.element($('#myTable')).scope().dailyAttendence(date)
        // }     
                  
    });
    });

