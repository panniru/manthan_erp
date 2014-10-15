(function(angular, app) {
    "use strict";
    app.controller("TeachingPlansController",["$scope","teachersService", "teachingPlanService", function($scope,teachersService,teachingPlanService) {

        $scope.myTeacher = ""
        $scope.myGrade_Section_Subject = ""
        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
               //alert(JSON.stringify(result.data));
                $scope.faculty_names= result.data               
            });
        $scope.getFacultyId = function(){
            teachingPlanService.getFacultyIdService()
                .then(function(result) {
                    $scope.myTeacher = result.data[0]['id'];
                    $scope.grades_sections_subjects = []
                    teachingPlanService.getGradesSectionSubjectService($scope.myTeacher)                
                        .then(function(result) {
                            //alert(JSON.stringify(result.data));
                            $scope.grades_sections_subjects =result.data
                        });
                    
                });    
        };  

        $scope.getFacultyGradeSectionSubject = function(){
            teachingPlanService.getGradesSectionSubjectService($scope.myTeacher)                
                .then(function(result) {
                    //alert(JSON.stringify(result.data));
                    $scope.grades_sections_subjects =result.data
                });            
        }; 
     
        $scope.months = []       
        teachingPlanService.getMonthlyCalendarService()
            .then(function(result) {                         
                $scope.months = result.data
                //alert(JSON.stringify(result.data));
            });
       
        
        
        var drawCalander = function(month, faculty_master_id){
            //alert("in draw calendar");
            //alert('drawCalander------'+faculty_master_id)
            $('#calendar1').html("");
            var grade_master_id = $("#grade_master_id").val()            
            var section_master_id = $("#section_master_id").val()           
            var subject_master_id = $("#subject_master_id").val()  
            //alert(grade_master_id+"--"+section_master_id+"--"+subject_master_id+"--"+JSON.stringify($scope.faculty_id));
            //alert(faculty_master_id);
            var student_id = typeof $scope.student_master_id  == 'undefined' ? "" : $scope.student_master_id
           // var grade_id = typeof $scope.grade_master_id == 'undefined' ? "" : :scope.grade_master_id
           // var section_id = typeof $scope.section_master_id == 'undefined' ? "" : :scope.section_master_id
          //  var subject_id = typeof $scope.subject_master_id == 'undefined' ? "" : :scope.subject_master_id
            $('#calendar1').html("");            
            $('#calendar1').fullCalendar({
                events: '/teaching_plans/calendardata.json?month='+month.month.trim()+"&grade_master_id="+grade_master_id+"&section_master_id="+section_master_id+"&subject_master_id="+subject_master_id+"&faculty_master_id="+faculty_master_id+"&student_master_id="+student_id,                               
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
                        
                    //alert(date.getFullYear())
                   // alert(checkUrl)
                    $.get(checkUrl,function(data) {
                        if(parseInt(data) > 0){                
                                  
                    $('#selectdate').val(date)
                    $('#myModal').modal('show');   
                }else{
                    alert("There is no plan defined on this day")                   
                    }
            })
                    }
                })
            //alert(JSON.stringify(month))
            $('#calendar1').fullCalendar('gotoDate', new Date(month.year, month.month_number, "01"));
        }
        
        $scope.getMonthData = function(month, implicit){
            $scope.current_month = month
           // alert($scope.student_master_id)
            teachingPlanService.getMonthDataService(month, $scope.myTeacher, $scope.myGrade_Section_Subject, $scope.student_master_id)
                .then(function(result) { 
                    $scope.monthData = result.data
                    // alert("1")
                    // alert(JSON.stringify(month));
                    // alert($scope.myTeacher);
                    if (!implicit){
                        // alert("2")
                        // alert(JSON.stringify(month));
                        // alert($scope.myTeacher);
                        drawCalander(month, $scope.myTeacher)
                    }
                });
        }     
        
        $scope.viewPlan= function(){
            //alert();
            //alert(JSON.stringify($scope.current_month));
            //alert($scope.myTeacher);
            //$scope.myTeacher = $scope.faculty_id;
            $scope.getMonthData($scope.current_month, true)
            drawCalander($scope.current_month, $scope.myTeacher)
        };

        
        var monthNames = [ "January", "February", "March", "April", "May", "June",
                           "July", "August", "September", "October", "November", "December" ];
        var today = new Date();
        $scope.current_month = {month: monthNames[today.getMonth()], month_number: today.getMonth(), year: today.getFullYear()}
        
        $scope.initializeCalendar = function (){
            $scope.getMonthData($scope.current_month, true)
            //drawCalander( $scope.current_month, $scope.myTeacher)
        }

        $scope.isCurrentMonth = function(month){
            var today = new Date();
            return today.getMonth() == parseInt(month.month_number)
        }
        
    }]);
    
    
})(angular, myApp);



