(function(angular, app) {
    "use strict";
    app.service("setupmasterService",["$http", function($http) {

        var getAllDetails = function(){
            var url = "/leave_permissions/get_all_details.json"
            return $http.get(url);
        };


        var getTypeOfLeavesCount = function(){
            var url = "/leave_permissions/get_type_of_leaves_count.json"
            return $http.get(url);
        };


        var getTestExactLeave = function(type_of_leave){
            var url = "/leave_permissions/get_exact_type_of_leave.json?type_of_leave="+type_of_leave
            return $http.get(url);
        };
        var getExactJsonCount = function(){
            var url = "/leave_permissions/get_exact_json_count.json"
            return $http.get(url);
        };

        var getDesignation = function(){
            var url = "/setup_masters/get_designations.json"
            return $http.get(url);
        };

        var getFaculty = function(){
            var url = "/faculty_attendances/get_faculty.json"
            return $http.get(url);
        };

        var getDetails = function(){
            var url = "/leave_permissions/approval_status.json"
            return $http.get(url);
        };

        // var getAllDates = function(){
        //     var url = "/leave_permissions/get_date.json"
        //     return $http.get(url);
        // };

        var getCountno = function(type_of_leave){
            var url = "/leave_permissions/count_no.json?type_of_leave="+type_of_leave
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
	var updateStatus = function(status){
            var url = "/leave_permissions/update_leave_permission_status.json"
            return $http.post(url, {status: status});
	};

        return {
            getDesignation : getDesignation,
            getFaculty : getFaculty,
            getMonth : getMonth,
            getAttendanceServiceView : getAttendanceServiceView,
            saveTodayAttendance : saveTodayAttendance,
            getCountno : getCountno,
            getDetails : getDetails,
            getExactJsonCount : getExactJsonCount,
            getTestExactLeave : getTestExactLeave,
            getTypeOfLeavesCount : getTypeOfLeavesCount,
            getAllDetails : getAllDetails,
            updateStatus : updateStatus
            // getAllDates : getAllDates
        };
    }]);
})(angular, myApp);
