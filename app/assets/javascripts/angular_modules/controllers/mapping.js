(function(angular, app) {
    "use strict";
    app.controller("Mapping1Controller", ["$scope","routesService","mapService", function($scope,routesService , mapService) {
	
	routesService.getLocationServiceView()
	    .then(function(result) {
		$scope.all_locations =result.data
		
	    })
	
	$scope.nearRoutes = function(){
	    $scope.location 
	    mapService.getMappingServiceView( $scope.location)
		.then(function(response){
		    $scope.routes = response.data
		});
        }
	
	$scope.saveRoute = function(route,location, student_master_id){
	    alert(student_master_id)
	    mapService.saveRoute(route,location,student_master_id)
		.then(function(result) {
		    
		});
	};
	
    }]);
    
})(angular, myApp);
