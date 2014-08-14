$('#canteen_calendar').fullCalendar({
    events: '/canteeenmanagers.json?',
    select: function(date) {
        // var checkUrl = "holidaycalendars/holiday_exists.json?date="+dateFormat    
        $('#myModal').modal('show');                
    }            
});

