$(document).ready(function() { 
    var date = new Date();
    var day  = date.getDate();
    var month = date.getMonth() + 1;              
    var year =  date.getFullYear();

    //--------------- academic year
    var myselect=document.getElementById("year"), year = new Date().getFullYear();
    var gen = function(max){do{myselect.add(new Option(year++,max--),null);}while(max>0);}(5);
    //-----------------------------


    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]

    //alert(day + '-' + month + '-' + year);
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
                alert("You can mark attendance on this day!"+date);
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

