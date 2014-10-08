$(document).ready(function() { 
    
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var today = new Date();
    //$('#holiday_calendar').html("");
    $('#holiday_calendar').fullCalendar({      
        events: '/holidaycalendars/holidaycalendardata.json?month='+monthNames[today.getMonth()],
        selectable: true,
        eventMouseover: function(date, event, view) {            
            var url = "/holidaycalendars/holiday_date.json?date="+date.holiday_date
           // alert(url)
            var curr_object = $(this) 
            $.get(url, function( date ) {
                var content_html = "<table><tbody>"
                content_html+= "<tr>"
                for (var i=0; i< date.length;i++)
                {
                    content_html+= "<tr>";                 
                    content_html+= '<td><a href="/holidaycalendars/'+date[i].id+'">'+date[i].description+'</a></td>';                  
                    content_html+= "</tr>";
                }                 
                content_html+= "</tbody></table>";
                curr_object.popover({html:true,title:event.title,placement:'top',container:'body', content: content_html}).popover('show');
            });
	},
       
        select: function(date) {
	    $('#holiday_date').val(date)
            //var checkUrl = "holidaycalendars/holiday_exists.json?date="+dateFormat    
            $('#myModal').modal('show');                
        }            
    });



    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        events: '/events.json'     
        //teaching_plans: '/teaching_plans.json' // put your options and callbacks here
    });

    $('#calendar3').fullCalendar({
        
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay',
            ignoreTimezone: false
        },
        
        events: '/admissions.json',
        
        selectable: true,
        select: function(date) {
            alert("welcome "+ date);
            $('#selectdate').val(date)
            $('#myModal').modal('show');                
        }
    });
    
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var today = new Date();
    $('#calendar1').html("");
    $('#calendar1').fullCalendar({ 
        events: '/teaching_plans/calendardata.json?month='+monthNames[today.getMonth()],
        selectable: true,
        eventMouseover: function(data, event, view) {
            var url = "/teaching_plans/teaching_date.json?date="+data.teaching_date
            var curr_object = $(this) 
            $.get(url, function( data ) {
                var content_html = "<table><tbody>"
                content_html+= "<tr>"
                for (var i=0; i< data.length;i++)
                {
                    content_html+= "<tr>";                 
                    content_html+= '<td><a href="/teaching_plans/'+data[i].id+'">'+data[i].plan_month+'</a></td>';                  
                    content_html+= "</tr>";
                }                 
                content_html+= "</tbody></table>";
                curr_object.popover({html:true,title:event.title,placement:'top',container:'body', content: content_html}).popover('show');
            });
	},
        select: function(date) {          
            var grade_master_id = $("#grade_master_id").val()            
            var section_master_id = $("#section_master_id").val()
            var faculty_master_id = $("#faculty_master_id").val()
            var subject_master_id = $("#subject_master_id").val()            
            var dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()         
            var checkUrl = "teaching_plans/plan_exists.json?grade_master_id="+grade_master_id+"&section_master_id="+section_master_id+"&subject_master_id="+subject_master_id+"&faculty_master_id="+faculty_master_id+"&date="+dateFormat
            
            alert(checkUrl)    
            
            $.get(checkUrl,function(data) {
                if(parseInt(data) > 0){
                    $('#selectdate').val(date)
                    $('#myModal').modal('show');   
                }else{
                    //prompt('there is no class today:');
                    alert("There is no plan defined on this day")
                }
                
            })
        }    
    });
    //   $('#calendar1').fullCalendar('gotoDate', new Date(parseInt(month.year), parseInt(month.month_number), 1));
    
});
$(function () {
    $(":file").change(function () {
        //alert("Display image")
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = imageIsLoaded;
            reader.readAsDataURL(this.files[0]);
        }
    });
});

function imageIsLoaded(e) {
    $('#myImg').attr('src', e.target.result);
};


