(function(angular, app) {
    "use strict";
    app.service("attendanceService",["$http", function($http) {
        var getStudentAssessment = function(){
            var url = "/admissions/get_assessment_students.json"
            return $http.get(url);
        };
        
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
        var getUpdate = function(save_details){
            var url = "/admissions/get_update.json"
            return $http.post(url, {comment: save_details});
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
            getStudentAssessment : getStudentAssessment

        };
    }]);
})(angular, myApp);
