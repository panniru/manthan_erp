$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        events: '/events.json'        // put your options and callbacks here
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
