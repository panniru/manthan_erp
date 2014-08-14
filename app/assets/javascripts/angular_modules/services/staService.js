(function(angular, app) {
    "use strict";
    app.service("staService",["$http", function($http) {
        
        var getStaffrecruitsOnStatus = function(status){
            var url = "/staff_reports/get_staffrecruits_on_status.json?status="+status
            return $http.get(url);
        };

        var status_report = function(){
            return $http.get("/staff_reports/get_status_view.json")
        }
        
        return {
            getStaffrecruitsOnStatus : getStaffrecruitsOnStatus,
            status_report : status_report
        };
    }]);
})(angular, myApp);
