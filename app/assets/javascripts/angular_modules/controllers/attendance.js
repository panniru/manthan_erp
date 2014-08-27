(function(angular, app) {
    "use strict";
    app.controller("AttendanceController",["$scope", "attendanceService", function($scope, attendanceService) {

        
        $scope.dailyAttendence = function(d){
            $scope.myDate = (d.getFullYear() + "-" + (d.getMonth()+1) +"-"+d.getDate()); 
            $('#myModal').modal('show');                
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
                $scope.save_attendence_details[i]['attendance_date'] = $scope.myDate; 
            }
            attendanceService.saveStudentAttendance($scope.save_attendence_details)
                .then(function(result) {
                    $('#myModal').modal('hide');                
                });
            
        };
        

    }]);
})(angular, myApp);
