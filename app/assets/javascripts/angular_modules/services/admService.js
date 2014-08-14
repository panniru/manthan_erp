(function(angular, app) {
    "use strict";
    app.service("admService",["$http", function($http) {
        
        var getAdmissionsOnStatus = function(status){
            var url = "/admission_reports/get_admissions_on_status.json?status="+status
            return $http.get(url);
        };

        var status_report = function(){
            return $http.get("/admission_reports/get_status_view.json")
        }
        
        return {
            getAdmissionsOnStatus : getAdmissionsOnStatus,
            status_report : status_report
        };
    }]);
})(angular, myApp);
