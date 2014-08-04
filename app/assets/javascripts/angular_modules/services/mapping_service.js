(function(angular, app) {
    "use strict";
    app.service("MappingService",["$http", function($http) {
        var getLocationServiceView = function(){
            var url = "/student_route_mapping/get_location_view.json"
            return $http.get(url);
        };
   return {
            getLocationServiceView : getLocationServiceView,
	   
        };
    }]);
})(angular, myApp);
