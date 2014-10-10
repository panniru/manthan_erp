
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
        height: '400px',
        selectable: true,
        select: function(date) {
            //var d = new Date(date);
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (day < 10) {
                day = "0" + day;
            }
            if (month < 10) {
                month = "0" + month;
            }
            var date_inn = day + "/" + month + "/" + year;
            
            alert(date_inn)
            $.ajax({
                url: "/attendances/attendance_on_date.json?date="+date_inn,
                type: 'PUT',
                data: {status: 'success',
                       date: (date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate())
                      },
                success: function(data) {
                    
                    $("#myModal").modal('show');
                    angular.element($('#myModal')).scope().dailyAttendence(date)
                }     
            });
        }
    });
});

