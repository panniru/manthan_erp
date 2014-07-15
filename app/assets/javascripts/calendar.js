$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        events: '/events.json'     
        //teaching_plans: '/teaching_plans.json' // put your options and callbacks here
    })
    
    $('#calendar1').fullCalendar({
        events: '/teaching_plans/calendardata.json',
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
            //alert(JSON.stringify(data))
            
            
	},
        select: function(date) {
            alert("welcome "+ date);
            // date: new Date($('#myModal').val(date))
            //console.log($('#myModal').val(date));
            $('#selectdate').val(date)
            $('#myModal').modal('show');   
            
        }
    })
    


});




