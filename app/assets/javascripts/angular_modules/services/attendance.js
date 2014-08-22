(function(angular, app) {
    "use strict";
    app.service("attendanceService",["$http", function($http) {
        var getAttendanceServiceView = function(){
            var url = "/attendances/get_students.json"
            return $http.get(url);
        };
        return {
            getAttendanceServiceView : getAttendanceServiceView
            
        };
    }]);
})(angular, myApp);
