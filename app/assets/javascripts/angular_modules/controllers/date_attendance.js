(function(angular, app) {
    "use strict";
    app.controller("DateAttendanceController",["$scope", "attendanceService", function($scope, attendanceService) {
      
        var indexedDates = [];
        $scope.datesToFilter = function()
        {
            indexedDates = [];
            return $scope.weeks;
        }
        $scope.filterDates = function(week) {
            
            var dateIsNew = indexedDates.indexOf(week.student_name) == -1;
            if(dateIsNew) {
                indexedDates.push(week.student_name);
            }
            return dateIsNew;
        }
        





        $scope.myShowFormValue = true;
        $scope.myEditFormValue = false;
        
        attendanceService.getShowAttendance()
            .then(function(result) {
                
                $scope.weeks = result.data;
                $scope.keys = Object.keys($scope.weeks[0])
                console.log($scope.keys)
            });
        
       
        
        $scope.goToEdit = function(){
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
            //$('#myModal').modal('show');
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
                        faculty_master_id: null,
                        name: null,
                    });
                }
                
            });
        $scope.saveTodayStudentAttendance = function(){

            for(var i=0; i<$scope.save_today_attendence_details.length; i++){

                $scope.save_today_attendence_details[i]['faculty_master_id'] = $scope.attendances[i]['faculty_id'];
                $scope.save_today_attendence_details[i]['student_master_id'] = $scope.attendances[i]['student_id'];
                $scope.save_today_attendence_details[i]['attendance'] = $scope.attendances[i]['attendance'];
                $scope.save_today_attendence_details[i]['attendance_date'] = $scope.date; 
                $scope.save_today_attendence_details[i]['name'] = $scope.attendances[i]['name'];
            }
            attendanceService.saveTodayStudentAttendance($scope.save_today_attendence_details)
                .then(function(result) {
                    for(var i=0; i<$scope.save_today_attendence_details.length; i++){
                        $scope.attendances[i]['attendance'] = '';
                        // $scope.myShowFormValue = false;
                        // $scope.myEditFormValue = true;
                       window.location.reload();
                        
                    }
                 
                });
            
        };
        

    }]);
})(angular, myApp);
