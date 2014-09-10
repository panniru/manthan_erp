(function(angular, app) {
    "use strict";
    app.service("routesService",["$http", function($http) {
        var getLocationServiceView = function(){
            var url = "/routes/get_location_view.json"
            return $http.get(url);
        };
	var getBusServiceView = function(){
            var url = "/routes/get_bus_no.json"
            return $http.get(url);
	};
	var getStudentView = function(route){
	    var url = "/routes/all_students.json?route="+route
	    return $http.get(url);
	};
	var getLocationView = function(location){
	    var url = "/routes/all_locations.json?location="+location
	    return $http.get(url);
	};
	var routeMail = function(subject,text){
	    var url = "/routes/send_mail.json"
            return $http.post(url,{route_mail:{subject: subject, text: text }}); 
        };
	var getRouteLocation = function(routeId){
	    var url = "/routes/"+routeId+"/get_route_locations.json"
	    return $http.get(url);
	};
        return {
            getLocationServiceView : getLocationServiceView,
	    routeMail : routeMail,
	    getBusServiceView : getBusServiceView,
	    getStudentView : getStudentView,
	    getLocationView : getLocationView,
	    getRouteLocation :getRouteLocation
        };
    }]);
})(angular, myApp);
