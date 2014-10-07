
$(document).ready(function() { 

    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var view = "holiday";
    
    var modal = function(){
        $('body').on('click','.Modal', function(){
            $('#Modal').modal('show');
        });
    }
    modal();

    var date = new Date();
    var day  = date.getDate();
    var month = date.getMonth() + 1;              
    var year =  date.getFullYear();

    // //--------------- academic year
    // var myselect=document.getElementById("year"), year = new Date().getFullYear();
    // var gen = function(max){do{myselect.add(new Option(year++,max--),null);}while(max>0);}(5);
    // //-----------------------------


    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]

    //alert(day + '-' + month + '-' + year);
    $('.attendance_calendar').html("");
    $('.attendance_calendar').fullCalendar({ 
        
        events: '/attendances/holidaycalendardata.json?month='+monthNames[date.getMonth()],
        // eventRender: function (event, element, cell,monthView) 
        // {
        //     if (event.title == 'holiday')
        //     {
        //         $(cell).find('.fc-event').parent().css('background-color', '#6E5849');
        //         $(cell).find('.fc-event').css({
        //             'background-color': '#6E5849',
        //             'border': '1px solid #6E5849'
        //         })
        //     }
        // },
              
        
        dayClick: function(date, jsEvent, view) {
            var myDate = new Date();
            var daysToAdd = 0;
            var checkDay = new Date($.fullCalendar.formatDate(date, 'yyyy-MM-dd'));
            if (checkDay.getDay() == 6 || checkDay.getDay() == 0) alert('Weekend!');
            
            myDate.setDate(myDate.getDate() + daysToAdd);
            
            if (myDate > checkDay) {
                 if($(".fc-event").length > 0){
                    $('.fc-event-inner').addClass("fc-state-disabled");
                    alert("Image loaded.");
                }
                
            }
        },

                // jQuery('.fc-sat').addClass("fc-state-disabled");
                // jQuery('.fc-sun').addClass("fc-state-disabled");
                // $('.fc-event').addClass("fc-state-disabled");
                //alert("You can mark attendance on this day!"+date);
            
        select: function(date) {
            angular.element($('#myTable')).scope().dailyAttendence(date)
        }     
        
    });
});

