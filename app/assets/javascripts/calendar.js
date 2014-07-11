$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        events: '/events.json'     
        //teaching_plans: '/teaching_plans.json' // put your options and callbacks here
    })
    
        $('#calendar1').fullCalendar({
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


$(document).ready(function(){
    $('input.timepicker').timepicker({ 'scrollDefaultNow': true });
    
});
$(function() {
    $('.date-picker-year').datepicker({
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'yy',
        onClose: function(dateText, inst) { 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, 1));
        }
    });
    $(".date-picker-year").focus(function () {
        $(".ui-datepicker-month").hide();
    });
});
$(document).ready(function()
                  {
	              $('#search').keyup(function()
	                                 {
		                             searchTable($(this).val());
	                                 });
                  });

function searchTable(inputVal)
{
    var table = $('#tblData');
    table.find('tr').each(function(index, row)
	                  {
		              var allCells = $(row).find('td');
		              if(allCells.length > 0)
		              {
			          var found = false;
			          allCells.each(function(index, td)
			                        {
				                    var regExp = new RegExp(inputVal, 'i');
				                    if(regExp.test($(td).text()))
				                    {
					                found = true;
					                return false;
				                    }
			                        });
			          if(found == true)$(row).show();else $(row).hide();
		              }
	                  });
}


$(document).ready(function() {
  //alert("hey");
      var calendar2 = $('#calendar2').fullCalendar({
      defaultView: 'agendaWeek',
      editable: true,
        selectable: true,
      //header and other values
      select: function(start, end, allDay) {
          endtime = $.fullCalendar.formatDate(end,'h:mm tt');
          starttime = $.fullCalendar.formatDate(start,'ddd, MMM d, h:mm tt');
          var mywhen = starttime + ' - ' + endtime;
          $('#createEventModal #apptStartTime').val(start);
          $('#createEventModal #apptEndTime').val(end);
          $('#createEventModal #apptAllDay').val(allDay);
          $('#createEventModal #when').text(mywhen);
          $('#createEventModal').modal('show');
       }
    });

  $('#submitButton').on('click', function(e){
    // We don't want this to act as a link so cancel the link action
    e.preventDefault();

    doSubmit();
  });

  function doSubmit(){
    $("#createEventModal").modal('hide');
    console.log($('#apptStartTime').val());
    console.log($('#apptEndTime').val());
    console.log($('#apptAllDay').val());
    alert("form submitted");
        
    $("#calendar2").fullCalendar('renderEvent',
        {
            title: $('#patientName').val(),
            start: new Date($('#apptStartTime').val()),
            end: new Date($('#apptEndTime').val()),
            allDay: ($('#apptAllDay').val() == "true"),
        },
        true);
   }
});
$(document).ready(function() {
$('.popover-dismiss').popover({
  trigger: 'focus'
})
});

