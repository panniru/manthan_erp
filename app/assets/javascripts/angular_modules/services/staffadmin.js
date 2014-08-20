(function(angular, app) {
    "use strict";
    app.service("staffadminsService",["$http", function($http) {
        var getStaffadminServiceView = function(){
            var url = "/staffadmins/get_faculty_names.json"
            return $http.get(url);
        };
        return {
            getStaffadminServiceView : getStaffadminServiceView,
            
        };
    }]);
})(angular, myApp);
