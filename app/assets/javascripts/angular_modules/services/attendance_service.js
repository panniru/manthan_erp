(function(angular, app) {
    "use strict";
    app.service("attendanceService",["$http", function($http) {
        var getAttendanceServiceView = function(date){
            var url = "/attendances/get_students.json"
            return $http.get(url);
        };
        var saveStudentAttendance = function(save_attendence_details){
             var url = "/attendances/save_student_attendance.json"
            return $http.post(url,{attendence_details: save_attendence_details});
         };

        var getStudentAndAttendanceView = function(){
            var url = "/attendances/getStudentAndAttendanceView.json"
            return $http.get(url);
        };

        return {
            getAttendanceServiceView : getAttendanceServiceView,
            saveStudentAttendance : saveStudentAttendance,
            getStudentAndAttendanceView : getStudentAndAttendanceView,
          

        };
    }]);
})(angular, myApp);
