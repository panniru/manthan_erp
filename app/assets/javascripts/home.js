

$(document ).ready(function() {

    function getDates(start, end) {
        
        var datesArray = [];
        var startDate = new Date(start);
      
        while (startDate <= end) {
            
            datesArray.push(new Date(startDate).getFullYear() + "-"+(new Date(startDate).getMonth()+1)+ "-"+new Date(startDate).getDate());
            startDate.setDate(startDate.getDate()+1);
           
            
        }
  
       
        $.ajax({
            url: "/leave_permissions/get_date.json",
            type: "POST",
            data: {dates:datesArray},
            dataType: "json",
            async: false,
            success: function(data){
          //      alert(data);
            }
        });
        return datesArray;
        
    }
    $("#from_date").datepicker({ dateFormat: "yy-mm-dd" });
    $("#to_date").datepicker({ dateFormat: "yy-mm-dd" });
    $('.date').on("change", function () {
        var start = $("#from_date").datepicker("getDate",{ dateFormat: "yy-mm-dd" }),
        end = $("#to_date").datepicker("getDate",{ dateFormat: "yy-mm-dd" });
        var between = getDates(start, end);
        $('#results').html(between.join('<br> '));
    });

    $('textarea').autosize();

    $('#change2').click(function() {
        $('#mypopModal').modal('show');
    });
    
    
    $('.textbox1').show();
    $('.fc-day').hide();
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
     var today = new Date();
     var monthNames = [ "January", "February", "March", "April", "May", "June",
                        "July", "August", "September", "October", "November", "December" ]
     
     $('.calendar2').html("");
     $('.calendar2').fullCalendar({
         events: '/admissions/holidaycalendardata.json?teacher_leader_id='+teacher_leader_id,
         selectable: true,
         firstDay: 1,
         weekends: false,
         weekMode: 'variable',
         select: function(date, calEvent, jsEvent, view) {
             var dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()       
             var checkUrl = "/admissions/holidaycalendardata.json?teacher_leader_id="+teacher_leader_id+"&date="+dateFormat
             $.get(checkUrl, function(data){
                 $('#selectdate').val(date)
                 $('#myModal').modal('show');      
             })
             
         },
         eventRender: function (event, element, monthView){
             var date = (event.start.getFullYear()+ "-" + (("0" + (event.start.getMonth()+1)).slice(-2)) + "-" + (("0" + event.start.getDate()).slice(-2)))
             var dayClass = $("td[data-date= '"+date+"']")
             if(event.title === 'holiday'){
                 dayClass.addClass('disable-class')
             }else{
                 dayClass.addClass('default-class')
             } 
         },
     });
 }


function createStaffAssessment(staffadmin_id) {
    var today = new Date();
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                       "July", "August", "September", "October", "November", "December" ]
    
    $('.calendar2').html("");
    $('.calendar2').fullCalendar({
        events: '/staffrecruits/holidaycalendardata.json?staffadmin_id='+staffadmin_id,
        
        selectable: true,
        firstDay: 1,
        weekends: false,
        weekMode: 'variable',
        select: function(date, calEvent, jsEvent, view) {
            var dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()       
            var checkUrl = "/staffrecruits/holidaycalendardata.json?staffadmin_id="+staffadmin_id+"&date="+dateFormat
            $.get(checkUrl, function(data){
                $('#selectdate').val(date)
                $('#myModal').modal('show');      
            })
            
        },
        eventRender: function (event, element, monthView){
            var date = (event.start.getFullYear()+ "-" + (("0" + (event.start.getMonth()+1)).slice(-2)) + "-" + (("0" + event.start.getDate()).slice(-2)))
            var dayClass = $("td[data-date= '"+date+"']")
            if(event.title === 'holiday'){
                dayClass.addClass('disable-class')
            }else{
                dayClass.addClass('default-class')
            } 
        },
    });
}



// function Foo() {
    // alert('testing')
    // document.getElementById("#a").onchange = function(){
    
    //     document.getElementById("#a").value = this.value;
    
    //     document.getElementById("#a").value = "Return";
    // $("#a").prop('value', 'Save'); 
    // $("#a").button('refresh');
    
    
    // if ( a.text === "Issue" ){
    
    //     alert('if ');
    //     a.text = "Close Curtain";}
    // else{
    //     alert('test');
    //     a.text = "Issue";}
    // :javascript
    // function Foo() {
    //     alert('testing')
    //     var x = document.getElementById("myBtn");
    //     x.disabled = true;
    // }
    
// } 

                           


// function toggleText(button_id)
// {
//     if (document.getElementById('button_id').text == "UNLOCK")
//     {
//         document.getElementById('button_id').text = "Unlock";
//     }
//     else
//     {
//         document.getElementById('button_id').text = "UNLOCK";
//     }
// }



$(document ).ready(function() {
     var modal = function(){
         $('body').on('click','.Modal', function(){
             $('#Modal').modal('show');
         });
     }
     modal();
});


