(function(angular, app) {
    "use strict";
    app.service("attendanceService",["$http", function($http) {
        var getAttendanceOnDate = function(date){
            var url = "/attendances/attendance_on_date.json?date="+date
            return $http.get(url);
        };

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
            getAttendanceOnDate : getAttendanceOnDate,
            getAttendanceServiceView : getAttendanceServiceView,
            saveStudentAttendance : saveStudentAttendance,
            getStudentAndAttendanceView : getStudentAndAttendanceView,
          

        };
    }]);
})(angular, myApp);
