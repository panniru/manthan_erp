(function(angular, app) {
    "use strict";
    app.controller("AttendanceController",["$scope", "attendanceService", function($scope, attendanceService) {

        attendanceService.getAttendanceServiceView()
            .then(function(result) {
                $scope.students=result.data
            });

    }]);
})(angular, myApp);
