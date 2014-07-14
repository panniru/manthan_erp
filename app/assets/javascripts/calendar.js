$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        events: '/events.json'     
        //teaching_plans: '/teaching_plans.json' // put your options and callbacks here
    })
    

    $('#calendar2').fullCalendar({
        events: '/teaching_plans/calendardata.json'
    })


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


        $('#calendar1').fullCalendar({
            events: '/teaching_plans/calendardata.json',
            selectable: true,
            select: function(date) {
                alert("welcome "+ date);
               // date: new Date($('#myModal').val(date))
                //console.log($('#myModal').val(date));
                $('#selectdate').val(date)
            
                          
                
                $('#myModal').modal('show');                
               
            }
            
        })
    


});
