(function(angular, app) {
    "use strict";
    app.controller("AttendanceController",["$scope", "attendanceService", function($scope, attendanceService) {

        $scope.submitToggle = true;
        $scope.myShowFormValue = true;
        $scope.myEditFormValue = false;
        
       // group by attendance_date
        var indexedDates = [];
        $scope.datesToFilter = function()
        {
            indexedDates = [];
            return $scope.attendances;
        }
        $scope.filterDates = function(attendance) {
            var dateIsNew = indexedDates.indexOf(attendance.attendance_date) == -1;
            if(dateIsNew) {
                indexedDates.push(attendance.attendance_date);
            }
            return dateIsNew;
        }
                                              
                                           // end of group by attendance_date
        
        $scope.dailyAttendence = function(d){
            $scope.myDate = (d.getFullYear() + "-" + (d.getMonth()+1) +"-"+d.getDate()); 
            // $('#myTable').show();                
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
                        name: null,
                    });
                }
                
            });
        $scope.saveStudentAttendance = function(){
            $scope.myShowFormValue = true;
            $scope.myEditFormValue = false;

            for(var i=0; i<$scope.save_attendence_details.length; i++){
                $scope.save_attendence_details[i]['student_master_id'] = $scope.students[i]['id'];
                $scope.save_attendence_details[i]['attendance'] = $scope.students[i]['attendance'];
                $scope.save_attendence_details[i]['attendance_date'] = $scope.myDate; 
            
            }
            $scope.submitToggle = !$scope.submitToggle;
            alert('hi');
            
            attendanceService.saveStudentAttendance($scope.save_attendence_details)
                .then(function(result) {
                    // $('#myTable').hide();                
                    alert(JSON.stringify(result.data));
                });
            
        };
        attendanceService.getStudentAndAttendanceView()
            .then(function(result) {
                $scope.attendances=result.data
            });
        
        $scope.goToEdit = function(){
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
        };

        // $scope.saveStudentAttendance = function(){
        //     $scope.myShowFormValue = true;
        //     $scope.myEditFormValue = false;
        // };


    }]);
})(angular, myApp);
