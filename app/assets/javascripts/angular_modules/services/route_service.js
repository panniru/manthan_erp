(function(angular, app) {
    "use strict";
    app.service("routesService",["$http", function($http) {
        var getLocationServiceView = function(){
            var url = "/routes/get_location_view.json"
            return $http.get(url);
        };
        return {
            getLocationServiceView : getLocationServiceView
        };
    }]);
})(angular, myApp);
