(function(angular, app) {
    "use strict";
    app.service("guestService",["$http", function($http) {
        var getRoleServiceView = function(){
            var url = "/guest_managements/get_role_view.json"
            return $http.get(url);
        };
        return {
            getRoleServiceView : getRoleServiceView,
            
        };
    }]);
})(angular, myApp);
