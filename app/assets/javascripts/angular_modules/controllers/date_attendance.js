(function(angular, app) {
    "use strict";
    app.controller("DateAttendanceController",["$scope", "attendanceService", function($scope, attendanceService) {
        
        $scope.myShowFormValue = true;
        $scope.myEditFormValue = false;

        $scope.goToEdit = function(){
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
            $('#myModal').modal('show');
        }
        

        $scope.todayAttendence = function(date){
            var date = new Date();
            $scope.date = (date.getFullYear() + "-" + (date.getMonth()+1) +"-"+date.getDate()); 
            $scope.attendances = $scope.students;
            $scope.$apply();
            
        }
        
        $scope.reflectStudents = function(students){
            $scope.attendances = students;
            $scope.$apply();
        }
        
   
        attendanceService.getAttendanceServiceView()
            .then(function(result) {
                 //alert(JSON.stringify(result.data));
                $scope.students=result.data;
                //$scope.attendances= students;
                $scope.save_today_attendence_details = [];
                for(var i=0; i<result.data.length; i++){
                    $scope.save_today_attendence_details.push({
                
                        student_master_id: null,
                        attendance: null,
                        attendance_date: null,
                
                    });
                }
                
            });
        $scope.saveTodayStudentAttendance = function(){

            for(var i=0; i<$scope.save_today_attendence_details.length; i++){
                
                $scope.save_today_attendence_details[i]['student_master_id'] = $scope.attendances[i]['id'];
                $scope.save_today_attendence_details[i]['attendance'] = $scope.attendances[i]['attendance'];
                $scope.save_today_attendence_details[i]['attendance_date'] = $scope.date; 
            }
            attendanceService.saveTodayStudentAttendance($scope.save_today_attendence_details)
                .then(function(result) {
                    for(var i=0; i<$scope.save_today_attendence_details.length; i++){
                        $scope.attendances[i]['attendance'] = '';
                        $scope.myShowFormValue = false;
                        $scope.myEditFormValue = true;
                        $('#myModal').modal('hide');
                        
                    }
                 
                });
            
        };
        

    }]);
})(angular, myApp);
