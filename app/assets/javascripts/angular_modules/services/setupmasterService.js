(function(angular, app) {
    "use strict";
    app.service("setupmasterService",["$http", function($http) {
        var getDesignation = function(){
            var url = "/setup_masters/get_designations.json"
            return $http.get(url);
        };

        var getFaculty = function(){
            var url = "/faculty_attendances/get_faculty.json"
            return $http.get(url);
        };
        var getMonth = function(designation){
            var url = "/faculty_attendances/get_faculty_designation.json?designation="+designation
            return $http.get(url);
        };
        var getAttendanceServiceView = function(date){
            var url = "/faculty_attendances/get_faculties.json"
            return $http.get(url);
        };
        
        var saveTodayAttendance = function(save_today_attendence){
            var url = "/faculty_attendances/save_today_attendance.json"
            return $http.post(url,{save_today_attendence: save_today_attendence});
        };

        return {
            getDesignation : getDesignation,
            getFaculty : getFaculty,
            getMonth : getMonth,
            getAttendanceServiceView : getAttendanceServiceView,
            saveTodayAttendance : saveTodayAttendance
        };
    }]);
})(angular, myApp);
