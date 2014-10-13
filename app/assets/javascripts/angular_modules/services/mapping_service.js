(function(angular, app) {
    "use strict";
    app.service("mapService",["$http", function($http) {
        var getMappingServiceView = function(location){
	    var url = "/student_route_mappings/get_route_view.json?id="+location
            return $http.get(url);
        };
	var saveRoute = function(route,location,student_master_id){
	    var url = "/student_route_mappings/save_route.json"
            return $http.post(url,{route_id: route.id , student_master_id : student_master_id , location_master_id : location});
        };
	var getStudentView = function(){
	    var url = "/student_route_mappings/get_student_view.json"
            return $http.get(url);
	};
	return {
            getMappingServiceView : getMappingServiceView,
	    saveRoute : saveRoute,
	    getStudentView : getStudentView
        };
    }]);
})(angular, myApp);
