(function(angular, app) {
    "use strict";
    app.controller("TeachingPlansController",["$scope","teachersService", "teachingPlanService", function($scope,teachersService,teachingPlanService) {
        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
               // alert(JSON.stringify(result.data));
                $scope.faculty_names=result.data                
            });
        teachingPlanService.getFacultyIdService()
            .then(function(result) {
                $scope.faculty_id = result.data
                $scope.grades_sections_subjects = []
                teachingPlanService.getGradesSectionSubjectService($scope.faculty_id)
                    .then(function(result) {
                       
                        $scope.grades_sections_subjects =result.data
                    });
                
            });      
     
        $scope.months = []       
        teachingPlanService.getMonthlyCalendarService()
            .then(function(result) {                         
                $scope.months = result.data
            });
       // $scope.facultyDates = []       
       // teachingPlanService.getFacultyDatesService()
         //   .then(function(result) {
            //  alert(JSON.stringify(result.data));                         
           //     $scope.facultyDates = result.data
           // });
        var drawCalander = function(month){
            $('#calendar1').html("");
            $('#calendar1').fullCalendar({
                events: '/teaching_plans/calendardata.json?month='+month.month.trim(),
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
                    
                    
                    $('#selectdate').val(date)
                    $('#myModal').modal('show');   
                }    
            })
            $('#calendar1').fullCalendar('gotoDate', new Date(month.year, month.month_number, "01"));
        }
        
        $scope.getMonthData = function(month, implicit){
            teachingPlanService.getMonthDataService(month)
                .then(function(result) {                    
                    $scope.monthData = result.data
                    if (!implicit){
                        drawCalander(month)
                    }
                    
                });
        }     
        
        
        
        var monthNames = [ "January", "February", "March", "April", "May", "June",
                           "July", "August", "September", "October", "November", "December" ];
        var today = new Date();
        var current_month = {month: monthNames[today.getMonth()], month_number: today.getMonth(), year: today.getYear()}
        $scope.getMonthData(current_month, true)
        
        $scope.isCurrentMonth = function(month){
            var today = new Date();
            return today.getMonth() == parseInt(month.month_number)
        }
        
    }]);
    
    
})(angular, myApp);



