$(document).ready(function() { 
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var date = new Date();
    var day  = date.getDate();
    var month = date.getMonth() + 1;              
    var year =  date.getFullYear();
    $('#week_calendar').html("");
    var calendar = $('#week_calendar').fullCalendar({
        defaultView: 'basicWeek',
        editable: true,
        selectable: true,
        events: '/attendances/holidaycalendardata.json?month='+monthNames[date.getMonth()],
        slotMinutes: 15,

        dayClick: function(date, allDay, jsEvent, view) {

            if ($('div.fc-event').length > 0) {
                //
                var containerD = $(this).offset();
                var containerH = $(this).height();
                var mousex = jsEvent.pageX;

                $('div.fc-event').each(function(index) {
                    var offset = $(this).offset();

                    if (((offset.left + $(this).outerWidth()) > mousex && offset.left < mousex) && ((offset.top > containerD.top) && (offset.top < (containerD.top + containerH)))) {

                        alert($(this).html());
                        //This will only fire if an empty space is clicked
                        //This will not fire if an event is clicked on a day
                    }
                });

            }
            else {
                //Put code here to do things if no events on a day
    
            }
        },
        select: function(date) {
            $('#weekModal').modal('show');
            angular.element($('#myTable')).scope().dailyAttendence(date)
        } 
    })
    
});

