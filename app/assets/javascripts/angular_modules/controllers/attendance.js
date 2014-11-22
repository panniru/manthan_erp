(function(angular, app) {
    "use strict";
    app.controller("AttendanceController",["$scope", "attendanceService", "resourceService", function($scope, attendanceService, resourceService) {
        $scope.assesses = resourceService.Assess.query();        


        
        $scope.myShowFormValue = true;
        $scope.myEditFormValue = false;
        
       // group by attendance_date
        var indexedDates = [];
        $scope.datesToFilter = function()
        {
            indexedDates = [];
            return $scope.save_attendance_details;
        }
        $scope.filterDates = function(attendance) {
            
            var dateIsNew = indexedDates.indexOf(attendance.attendance_date) == -1;
            if(dateIsNew) {
                indexedDates.push(attendance.attendance_date);
            }
            return dateIsNew;
        }
                                              
        // end of group by attendance_date
        // -------------------------------------------------------------------
        // attendance submission

              

        $scope.dailyAttendence = function(date){
            var date = new Date();
            $scope.date = ((date.getDate()) + "/"+ (date.getMonth()+1) + "/" + (date.getFullYear())); 

        }
        attendanceService.getAttendanceServiceView()
            .then(function(result) {
                 //alert(JSON.stringify(result.data));
                $scope.students=result.data;
                $scope.save_attendence_details = [];
              
                for(var i=0; i<result.data.length; i++){
                    $scope.save_attendence_details.push({
                        student_master_id: null,
                        attendance: null,
                        attendance_date: null,
                        
                    });
                }
                
            });
        
        $scope.saveStudentAttendance = function(){
            
            for(var i=0; i<$scope.save_attendence_details.length; i++){
                $scope.save_attendence_details[i]['student_master_id'] = $scope.students[i]['id'];
                $scope.save_attendence_details[i]['attendance'] = $scope.students[i]['attendance'];
                $scope.save_attendence_details[i]['attendance_date'] = $scope.date; 
                
            }
            
            attendanceService.saveStudentAttendance($scope.save_attendence_details)
                .then(function(result) {
                    for(var i=0; i<$scope.save_attendence_details.length; i++){
                        $scope.students[i]['attendance'] = '';
                        $("#myModal").modal('hide');
                    }
                });
        }
        attendanceService.getStudentAssessment()
            .then(function(result) {
                $scope.ass = result.data;
            });
      
        $scope.getModal = function(assess){
            $scope.assess = assess;
            $('#getModal').modal('show');
        };

        $scope.update = function(){
            var assess = $scope.assess;
            assess.$update()
                .then(function(responce){
                })
            $('#getModal').modal('hide');
            $scope.showModal();
        };
        

        $scope.showModal = function(){
            $scope.assesses = resourceService.Assess.query();
        }

        $scope.getStudent = function(assess){
            $scope.assess = assess;
            // attendanceService.getModalServiceView()
            //     .then(function(result) {
                    $('#getModal').modal('hide');  
		//});
        }

        $scope.goToEdit = function(){
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
        };
        $scope.reflectStudents = function(students){
            $scope.attendances = students;
            $scope.$apply();
        }
        
        $scope.attendance = function(selected_value){
	    $scope.isPresent = function(value) {
		if (selected_value == 'P' || selected_value == 'A' || selected_value == 'L')
		    return true;
		else 
		    return false;
	    };
	}

        

    }]);
})(angular, myApp);
