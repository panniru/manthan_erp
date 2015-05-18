(function(angular, app) {
    "use strict";
    app.service("mapService",["$http", function($http) {
        var getMappingServiceView = function(location){
	    var url = "/student_route_mappings/get_up_route_view.json?id="+location
            return $http.get(url);
        };
	var getBusView = function(){
	    var url = "/student_route_mappings/get_route_optimization"
            return $http.get(url);
        };
	var getRouteServiceView = function(location){
	    var url = "/student_route_mappings/get_down_route_view.json?id="+location
	    return $http.get(url);
	};
	var saveRoute = function(route,location,student_master_id ){
	    var url = "/student_route_mappings/save_route.json"
            return $http.post(url,{route_id: route.id , student_master_id : student_master_id , location_master_id : location ,lpp : route.lpp });
        };
	var getStudentView = function(page){
	    var url = "/student_route_mappings/get_student_view.json?page="+page
            return $http.get(url);
	};
	var getLocationMap = function() {
	    var url = "/student_route_mappings/location_bus_mapping.json"
            return $http.get(url);  
	};
	
	return {
            getMappingServiceView : getMappingServiceView,
	    getRouteServiceView : getRouteServiceView,
	    saveRoute : saveRoute,
	    getStudentView : getStudentView,
	    getBusView : getBusView,
	    getLocationMap : getLocationMap
	 
        };
    }]);
})(angular, myApp);
