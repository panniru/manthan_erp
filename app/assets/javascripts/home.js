$(document ).ready(function() {
   
    
    $('#admission_bus').change(function() {
        if ($(this).val() == 't')
        {
            $('.textbox2').show();
        }
        else
        {
            $('.textbox2').hide();
        }
    });

    
    $('#admission_know_school').change(function() {
        if ($(this).val() != 'Parents whose children are studying here')
        {
            $('.textbox1').hide();
        }
        else
        {
            $('.textbox1').show();
        }
    });


    $('#guest_management_follow_up').change(function() {
	if ($(this).val() == 'Yes')
	{
	    $('#guest_management_follow_up_date').show();
	    $('#textbox').show();
	}
	else
	{
	    $('#guest_management_follow_up_date').hide();
	    $('#textbox').hide();
	}
    });

    $('body').on('focus',".datepicker", function(){
        $(this).datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
            dateFormat: 'dd/mm/yy'
        });
    });
    
    $("#flot-placeholder").on("plotclick", function (event, pos, item) { 
        angular.element($('#flot-placeholder')).scope().gridDataPoint(item)
        
    });
    $("#adm-flot-placeholder").on("plotclick", function (event, pos, item) { 
        angular.element($('#adm-flot-placeholder')).scope().gridAdmDataPoint(item)
    });
    $("#sta-flot-placeholder").on("plotclick", function (event, pos, item) { 
        angular.element($('#sta-flot-placeholder')).scope().gridStaDataPoint(item)
    });
    
    $("#flot-placeholder1").on("plotclick", function (event, pos, item) {
        angular.element($('#flot-placeholder')).scope().gridDataPoint(item)
        //angular.element($('#flot-placeholder')).scope().gridDataPoint1(item)
    });
});


function drawStudentAttendance(studentId){
    $("#student_attendence_calendar").fullCalendar({
        events: function( start, end, callback ) {
            var newMonth = end.getMonth();
            if(newMonth == 0){
                newMonth = 12;
            }
            var url = "/student_masters/"+studentId+"/attendance_calendar_for_month.json"
            $.ajax({
                url: url,
                dataType: 'json',
                type: 'GET',
                data: {
                    month: newMonth,
                    year: end.getFullYear()
                },
                success: function( response ) {
                    callback(response);
                    angular.element($('#student_attendence_calendar')).scope().reflectMonthChange(newMonth);
                }
            })
        },
        selectable: false,
        height: '400px',
        eventRender: function (event, element, monthView){
            var date = (event.start.getFullYear()+ "-" + (("0" + (event.start.getMonth()+1)).slice(-2)) + "-" + (("0" + event.start.getDate()).slice(-2)))
            var dayClass = $("td[data-date= '"+date+"']")
            if(event.title === 'P'){
                dayClass.addClass('present-class')
            }else if(event.title === 'A'){
                dayClass.addClass('absent-class')
            }else if(event.title === 'L'){
                dayClass.addClass('leave-class')
            }else{
                dayClass.addClass('default-class')
            } 
        }
    })
}

 function createAssessment(teacher_leader_id) {

    $('.calendar2').html("");
    $('.calendar2').fullCalendar({
        events: '/admissions.json?teacher_leader_id='+teacher_leader_id,
        
        selectable: true,
        select: function(date) {
        
            $('#selectdate').val(date)
            $('#myModal').modal('show');                
        }
    });
}


function createStaffAssessment(staff_admission_id) {
    $('.calendar2').html("");
    $('.calendar2').fullCalendar({
        events: '/staffrecruits.json?staff_admission_id='+staff_admission_id,
        
        selectable: true,
        select: function(date) {
            $('#selectdate').val(date)
            $('#myModal').modal('show');                
        }
    });
}


$(document ).ready(function() {
     var modal = function(){
         $('body').on('click','.Modal', function(){
             $('#Modal').modal('show');
         });
     }
     modal();
});
