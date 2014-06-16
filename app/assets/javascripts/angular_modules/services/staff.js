(function(angular, app) {
    "use strict";
    app.service("getStaff",["$http", function($http) {
        var getStaffView = function(){
            var url = "/staffs.json"
            return $http.get(url);
        };
        
        return {
            getStaffView : getStaffView
        };
        
    }]);
})(angular, myApp);
