(function(angular, app) {
    "use strict";
    app.controller("DateAttendanceController",["$scope", "attendanceService", function($scope, attendanceService) {
        
        $scope.todayAttendence = function(date){
            //alert('');
            var date = new Date();
            $scope.date = (date.getFullYear() + "-" + (date.getMonth()+1) +"-"+date.getDate()); 
            
        }

        attendanceService.getAttendanceServiceView()
            .then(function(result) {
                 //alert(JSON.stringify(result.data));
                $scope.students=result.data;
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
                
                $scope.save_today_attendence_details[i]['student_master_id'] = $scope.students[i]['id'];
                $scope.save_today_attendence_details[i]['attendance'] = $scope.students[i]['attendance'];
                $scope.save_today_attendence_details[i]['attendance_date'] = $scope.date; 
            }
            attendanceService.saveTodayStudentAttendance($scope.save_today_attendence_details)
                .then(function(result) {
                    
                });
            
        };
        

    }]);
})(angular, myApp);
