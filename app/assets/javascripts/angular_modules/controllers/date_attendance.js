(function(angular, app) {
    "use strict";
    app.controller("DateAttendanceController",["$scope", "resourceService", "attendanceService", function($scope, resourceService, attendanceService) {
      
        //$scope.attendances = resourceService.Attend.query();
        //---------------------------------
        // var indexedDates = [];
        // $scope.datesToFilter = function()
        // {
        //     indexedDates = [];
        //     return $scope.weeks;
        // }
        // $scope.filterDates = function(week) {
            
        //     var dateIsNew = indexedDates.indexOf(week.student_name) == -1;
        //     if(dateIsNew) {
        //         indexedDates.push(week.student_name);
        //     }
        //     return dateIsNew;
        // }
        
        //-----------------------------
        
            attendanceService.getTypeOfLeavesCount()
                .then(function(result) {
                    $scope.get_types_counts = result.data;
                    alert(JSON.stringify($scope.get_types_counts))
                    alert(myCount)
                    // $scope.showCasualLeave = true;
                    // // $scope.showSickLeave = false;
                    // $scope.keys = Object.keys($scope.get_types_counts[0])
                    // alert(JSON.stringify($scope.keys))
                    //  console.log($scope.keys)
                    
                });
            

        

        $scope.get_types ={"casual_leave":"casual_leave","sick_leave":"sick_leave", "loss_of_pay":"loss_of_pay"};

        attendanceService.getGroupMonth()
            .then(function(result) {
                $scope.groups = result.data;
            });
       

        $scope.getUpdate = function(month){
            attendanceService.getMonth(month)
                .then(function(result) {
                    $scope.group_months = result.data;
                });
        }
      


        $scope.myShowFormValue = true;
        $scope.myEditFormValue = false;

        //----------------Weekly Attendance        
        attendanceService.getShowAttendance()
            .then(function(result) {
                $scope.weeks = result.data;
                $scope.keys = Object.keys($scope.weeks[0])
                console.log($scope.keys)
            });


        //-----------------Monthly Attendance
        attendanceService.getMonthlyAttendance()
            .then(function(result) {
                $scope.months = result.data;
            });
        

       //-----------------------------------
                                                                                       
        $scope.goToEdit = function(){
            //$scope.attendances = attendances
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
        }

          $scope.todayAttendence = function(date){
            var date = new Date();
            $scope.date = (date.getFullYear() + "-" + (date.getMonth()+1) +"-"+date.getDate()); 
            $scope.attendances = $scope.attendances;
            $scope.$apply();
            
          }
        
        $scope.reflectStudents = function(students){
            $scope.attendances = students;
            $scope.$apply();
        }
        
   
        attendanceService.getAttendanceServiceView()
            .then(function(result) {
                $scope.attendances = result.data;
                $scope.save_today_attendence_details = [];
                for(var i=0; i<result.data.length; i++){
                    $scope.save_today_attendence_details.push({
                        student_master_id: null,
                        attendance: null,
                        attendance_date: null,
                        faculty_master_id: null,
                        name: null,
                        id: null,
                    });
                }
            });


        $scope.saveTodayStudentAttendance = function(){
            
            for(var i=0; i<$scope.save_today_attendence_details.length; i++){
                $scope.save_today_attendence_details[i]['faculty_master_id'] = $scope.attendances[i]['faculty_id'];
                $scope.save_today_attendence_details[i]['student_master_id'] = $scope.attendances[i]['student_id'];
                $scope.save_today_attendence_details[i]['attendance'] = $scope.attendances[i]['attendance'];
                $scope.save_today_attendence_details[i]['attendance_date'] = $scope.attendances[i]['attendance_date']; 
                $scope.save_today_attendence_details[i]['name'] = $scope.attendances[i]['name'];
                $scope.save_today_attendence_details[i]['id'] = $scope.attendances[i]['id'];
            }
      
            attendanceService.saveTodayStudentAttendance($scope.save_today_attendence_details)
                .then(function(result) {
                    for(var i=0; i<$scope.save_today_attendence_details.length; i++){
                        $scope.myShowFormValue = true;
                        $scope.myEditFormValue = false;
                    }
                });
        };
        
        
    }]);
})(angular, myApp);
