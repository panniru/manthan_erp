$(document).ready(function() {
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    var today = new Date();
    $('#canteen_calendar').fullCalendar({
	events: '/mealnames/canteenmanagerdata.json?month='+monthNames[today.getMonth()],
	height: '300px',
	selectable: true,
	
		
	eventMouseover: function(date, event, view) {        
            var url = "/mealnames/canteen_date.json?date="+date.canteen_date         
            var curr_object = $(this) 
            $.get(url, function( date ) {
		var content_html = "<table><tbody>"
		content_html+= "<tr>"
		for (var i=0; i< date.length;i++)
		{
                    content_html+= "<tr>";               
                    //content_html+= '<td><a "/canteenmanagers/'+date[i].id+'">'+date[i].mealtype.meal_type+'</a></td>';
                    content_html+= "</tr>";
                    content_html+= "<tr>";
                    content_html+= '<td> <a "/canteenmanagers/'+date[i].id+'">'+date[i].meal_detail_name+'</a></td>';
                    content_html+= "</tr>";              
		}                 
		content_html+= "</tbody></table>";
		curr_object.popover({html:true,title:event.title,placement:'top',container:'body', content: content_html}).popover('show');
            });
	},


	

	
	select: function(date) { 
	   
	    var myDate = new Date();
	    var day = myDate.getDate();
            var month = myDate.getMonth() + 1;
            var year = myDate.getFullYear();
            if (day < 10) {
                day = "0" + day;
            }
            if (month < 10) {
                month = "0" + month;
            }
            var date_in = (day + "/" + month + "/" + year);
            
	    var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (day < 10) {
                day = "0" + day;
            }
            if (month < 10) {
                month = "0" + month;
            }
            var date_inn = (day + "/" + month + "/" + year);
            
           
            
            if (date_inn > date_in) {
                angular.element($('#createModal')).scope().newMeal(date_inn)
	    }
	    else 
		{ alert('You Cannot Enter Meals For Past Day')}
            //angular.element($('#createModal')).scope().newMeal(date)
	} 
	
    });

});
