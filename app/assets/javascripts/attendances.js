function myFunction(date){
    
    angular.element($('.myFunction')).scope().dailyAttendence(date)
}
$(document).ready(function() { 
    var today = new Date();
  
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    $('.attendance_calendar').html("");
    $('.attendance_calendar').fullCalendar({ 
        
        events: '/attendances/holidaycalendardata.json?month='+monthNames[today.getMonth()],
        select: function(date) {
            $.ajax({
                url: "/attendances/dates.json",
                type: 'GET',
                data: "status=success",
                success: function(data) {
                    $("#myModal").modal('show');
                    angular.element($('#myModal')).scope().dailyAttendence(date)
                }
            });
                    
            $("#myModal").modal('show');
            angular.element($('#myModal')).scope().dailyAttendence(date)
        }     
        
    });
});

