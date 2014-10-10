(function(angular, app) {
    "use strict";
    app.controller("AttendanceController",["$scope", "attendanceService", function($scope, attendanceService) {
                   
        $scope.list = [];
        $scope.text = 'hello';
        $scope.submit = function() {
            if ($scope.text) {
                $scope.list.push(this.text);
                $scope.text = '';
            }
           
        }
        attendanceService.getAttendanceOnDate()
	    .then(function(response){
		$scope.attendances = response.data
	    });
     
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
            $scope.date = ((date.getDate()) + "-"+ (date.getMonth()+1) + "-" + (date.getFullYear())); 

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
       
        $scope.goToEdit = function(){
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
        };
        

    }]);
})(angular, myApp);
