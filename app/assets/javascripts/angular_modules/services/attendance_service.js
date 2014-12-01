(function(angular, app) {
    "use strict";
    app.service("attendanceService",["$http", function($http) {
        var getStudentAssessment = function(){
            var url = "/admissions/get_assessment_students.json"
            return $http.get(url);
        };
        var getWeek = function(){
            var url = "/attendances/get_week.json"
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
        var saveTodayStudentAttendance = function(save_today_attendence_details){
            var url = "/attendances/save_today_student_attendance.json"
            return $http.post(url,{save_today_attendence_details: save_today_attendence_details});
        };

        var getShowAttendance = function(){
            var url = "/attendances/show_attendance.json"
            return $http.get(url);
        };
        
        var getMonthlyAttendance = function(){
            var url = "/attendances/monthly_attendance.json"
            return $http.get(url);
        };
        var getUpdate = function(save_details){
            var url = "/admissions/get_update.json"
            return $http.post(url, {comment: save_details});
        };
        var getStudentAndAttendanceView = function(){
            var url = "/attendances/getStudentAndAttendanceView.json"
            return $http.get(url);
        };
      //  var getModalServiceView = 

        return {
            getAttendanceOnDate : getAttendanceOnDate,
            getAttendanceServiceView : getAttendanceServiceView,
            saveStudentAttendance : saveStudentAttendance,
            getStudentAndAttendanceView : getStudentAndAttendanceView,
            getStudentAssessment : getStudentAssessment,
            getWeek : getWeek,
            saveTodayStudentAttendance : saveTodayStudentAttendance,
            getShowAttendance : getShowAttendance,
            getMonthlyAttendance : getMonthlyAttendance
            //getModalServiceView : getModalServiceView

        };
    }]);
})(angular, myApp);
