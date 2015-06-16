(function(angular, app) {
    "use strict";
    app.service("admission_dashboard_service",["$http", function($http) {

        var getCountStatus = function(){
            var url = "/admin_dashboards/get_count_status.json"
            return $http.get(url);
        };

        var getForms = function(reason){
            var url = "/admin_dashboards/get_forms.json?status="+reason
            return $http.get(url);
        };

        var getStaffCountStatus = function(){
            var url = "/admin_dashboards/get_staff_count_status.json"
            return $http.get(url);
        };

        var getStaffForms = function(reason){
            var url = "/admin_dashboards/get_staff_forms.json?status="+reason
            return $http.get(url);
        };

        
        return {
            getCountStatus : getCountStatus,
            getForms : getForms,
            getStaffCountStatus : getStaffCountStatus,
            getStaffForms : getStaffForms,

        };
    }]);
})(angular, myApp);

