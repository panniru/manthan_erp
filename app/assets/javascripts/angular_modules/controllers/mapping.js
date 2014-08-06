(function(angular, app) {
    "use strict";
    app.controller("Mapping1Controller", ["$scope","routesService","mapService", function($scope,routesService , mapService) {
	
	routesService.getLocationServiceView()
	    .then(function(result) {
		$scope.all_locations =result.data
		
	    });
	
	$scope.nearRoutes = function(){
	    $scope.location 
	    mapService.getMappingServiceView( $scope.location)
		.then(function(response){
		    $scope.routes = response.data
		});
        }
	$scope.saveRoute  = function(route_id){
	    alert(route_id)
	    $scope.save_routes = [];
            $scope.save_routes.push({
                student_master_id: "",
                route_id: "",
            }); 
	    
	};
		
    }]);
    
})(angular, myApp);
