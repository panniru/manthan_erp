(function(angular, app) {
    "use strict";
    app.service("faculty_master_service",["$http", function($http) {
        var getResignedStaffs = function(){
            var url = "/faculty_masters/get_resigned_staffs.json"
            return $http.get(url);
        };

        var getFilterValue = function(value){
            var url = "/faculty_masters/get_filter_values.json?value="+value
            return $http.get(url);
        };

        
        
        return {
            getResignedStaffs : getResignedStaffs,
            getFilterValue : getFilterValue
        };
        
    }]);
})(angular, myApp);
