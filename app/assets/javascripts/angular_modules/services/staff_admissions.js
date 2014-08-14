(function(angular, app) {
    "use strict";
    app.service("staffsService",["$http", function($http) {
        var getPostServiceView = function(){
            var url = "/staff_admissions/get_post_view.json"
            return $http.get(url);
        };
        var getStatusServiceView = function(){
            var url = "/staff_admissions/get_status_view.json"
            return $http.get(url);
        };

        return {
            getPostServiceView : getPostServiceView,
            getStatusServiceView : getStatusServiceView
            
        };
    }]);
})(angular, myApp);
