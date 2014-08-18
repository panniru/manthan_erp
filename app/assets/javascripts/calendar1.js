var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var today = new Date();
$('#canteen_calendar').fullCalendar({
    events: '/canteenmanagers/canteenmanagerdata.json?month='+monthNames[today.getMonth()],
    selectable: true,
    eventMouseover: function(data, event, view) {        
        var url = "/canteenmanagers/canteen_date.json?date="+data.canteen_date         
        var curr_object = $(this) 
        $.get(url, function( data ) {
            var content_html = "<table><tbody>"
            content_html+= "<tr>"
            for (var i=0; i< data.length;i++)
            {
                content_html+= "<tr>";               
                content_html+= '<td>breakfast= <a href="/canteenmanagers/'+data[i].id+'">'+data[i].breakfast+'</a></td>';
                content_html+= "</tr>";
                content_html+= "<tr>";
                content_html+= '<td>lunch= <a href="/canteenmanagers/'+data[i].id+'">'+data[i].lunch+'</a></td>';
                content_html+= "</tr>";
                content_html+= "<tr>";
                content_html+= '<td>snacks= <a href="/canteenmanagers/'+data[i].id+'">'+data[i].snacks+'</a></td>';
                content_html+= "</tr>";
                content_html+= "<tr>";
                content_html+= '<td>dinner= <a href="/canteenmanagers/'+data[i].id+'">'+data[i].dinner+'</a></td>'; 
                content_html+= "</tr>";
            }                 
            content_html+= "</tbody></table>";
            curr_object.popover({html:true,title:event.title,placement:'top',container:'body', content: content_html}).popover('show');
        });
    },

    select: function(date) {
    
        $('#myModal').modal('show');                
    }            
});

