(function(angular, app) {
    "use strict";
    app.service("staffadminsService",["$http", function($http) {
        var getStaffadminServiceView = function(){
            var url = "/staffadmins/get_faculty_names.json"
            return $http.get(url);
        };
        var getRoleAndHead = function(){
            var url = "/staffadmins/get_role_and_head.json"
            return $http.get(url);
        };
        return {
            getStaffadminServiceView : getStaffadminServiceView,
            getRoleAndHead : getRoleAndHead
        };
    }]);
})(angular, myApp);
