(function(angular, app) {
    "use strict";
    app.service("mapService",["$http", function($http) {
        var getMappingServiceView = function(location){
	    var url = "/student_route_mappings/get_route_view.json?id="+location
            return $http.get(url);
        };
	return {
            getMappingServiceView : getMappingServiceView,
	    
        };
    }]);
})(angular, myApp);
