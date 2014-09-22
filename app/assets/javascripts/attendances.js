$(document).ready(function() { 
    
    
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var view = "holiday";
    var date = new Date();
    var day  = date.getDate();
    var month = date.getMonth() + 1;              
    var year =  date.getFullYear();
    //alert(day + '-' + month + '-' + year);
    $('.attendance_calendar').html("");
    $('.attendance_calendar').fullCalendar({ 
        
        events: '/attendances/holidaycalendardata.json?month='+monthNames[date.getMonth()],
        // eventRender: function (event, element, monthView, cell) 
        // {
        //     var today = new Date();
        //     if(event.start == today.getDate())
        //     { 
        //         cell.css("background-color", "red");
                
        //     }
        // }
        
        dayRender: function (date, event,cell) {
            var today = new Date();
            if (event.start === today.getDate()) {
                cell.css("background-color", "red");
            }
        }
        // ,
        // dayClick: function(date, jsEvent, view) {
        //     var myDate = new Date();
        //     var daysToAdd = 0;
        //     var checkDay = new Date($.fullCalendar.formatDate(date, 'yyyy-MM-dd'));
        //     if (checkDay.getDay() == 6 || checkDay.getDay() == 0) alert('Weekend!');
            
        //     myDate.setDate(myDate.getDate() + daysToAdd);
            
        //     if (date < myDate) {
        //         angular.element($('#myTable')).scope().dailyAttendence(date)
        //         alert("You can mark attendance on this day!"+date);
                                                                                      
        //     }
        // },
        // viewDisplay   : function(view, event) {
        //     var now = new Date(); 
        //     var end = new Date();
        //     end.setMonth(now.getMonth() + 11); //Adjust as needed
        //     // var events = 'holiday';
        //     // var cur_event = $('.fc-event-title');
        //     // alert(cur_event);
        //     // if(events == cur_event) { jQuery('.fc-day').addClass('fc-state-highlight'); }
        //     //else { jQuery('.fc-day').removeClass('fc-state-highlight'); }
        //     var cal_date_string = view.start.getMonth()+'/'+view.start.getFullYear();
        //     var cur_date_string = now.getMonth()+'/'+now.getFullYear();
        //     var end_date_string = end.getMonth()+'/'+end.getFullYear();

        //     if(cal_date_string == cur_date_string) { jQuery('.fc-button-prev').addClass("fc-state-disabled"); }
        //     else { jQuery('.fc-button-prev').removeClass("fc-state-disabled"); }

        //     if(end_date_string == cal_date_string) { jQuery('.fc-button-next').addClass("fc-state-disabled"); }
        //     else { jQuery('.fc-button-next').removeClass("fc-state-disabled"); }
        // },
        
        // eventMouseclick: function(event) {
        //     alert('');
        // },
        
        
        // select: function(date) {
        //     angular.element($('#myTable')).scope().dailyAttendence(date)
        // }     
                  
    });
    });

// $(document).ready(function() { 


//     var monthNames = [ "January", "February", "March", "April", "May", "June",
//                        "July", "August", "September", "October", "November", "December" ]
//     var view = "holiday";
//     var date = new Date();
//     var day  = date.getDate();
//     var month = date.getMonth() + 1;              
//     var year =  date.getFullYear();
//     //alert(day + '-' + month + '-' + year);
//     $('.attendance_calendar').html("");
//     $('.attendance_calendar').fullCalendar({
//         header: {
//             left: 'prev,next today',
//             center: 'title',
//             right: 'month,agendaWeek,agendaDay'
//         },
        
//         defaultView: 'month',
//         editable: true,
//         selectable: true,
        
           
//         events: '/attendances/holidaycalendardata.json?month='+monthNames[date.getMonth()],
//         // dayRender: function (date, cell) {
//         //     var today = new Date();
//         //     if (date.getDate() >= today.getDate()) {
//         //         cell.css("background-color", "red");
//         //     }
//         // }
//         eventRender: function (event, element, monthView) 
//         {
//             if(event.title == 'holiday')
//             { 
//                 cell.css("background-color", "red");
                
//             }
//         }
        




        
// });
// });
