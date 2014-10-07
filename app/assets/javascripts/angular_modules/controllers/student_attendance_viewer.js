(function(angular, app) {
    "use strict";
    app.controller("StudentAttendanceViewerController",["$scope", "studentService", "MONTH_NAME_CONSTS", function($scope, studentService, MONTH_NAME_CONSTS) {
        $scope.activeMonth = "Test"
        $scope.get_monthly_attendance = function(studentId){
            window.drawStudentAttendance(studentId)
            studentService.summarized_monthly_attendance(studentId)
                .then(function(responce){
                    $scope.month_wise_attendance = responce.data;
                }
                )
        }
        $scope.reflectMonthChange = function(month){
            $scope.activeMonth = angular.fromJson(angular.toJson(MONTH_NAME_CONSTS[month-1]))
            $scope.$apply()
        }
        
        $scope.checkForMatching = function(monthName){
            return $scope.activeMonth.trim() == monthName.trim()
        }

    }]);
    
})(angular, myApp);
