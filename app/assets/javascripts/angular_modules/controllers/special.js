(function(angular, app) {
    "use strict";
    app.controller("SpecialController", ["$scope","resourceService", function($scope,routesService ) {
	//$scope.routes = resourceService.SpecialDayTransport.query();
	$scope.SaveRoutes = function(){
	    $scope.routes = [];
	    $scope.routes.push({
		
		time_up : "",
		time_down : "",
		new_up_route : "",
		new_down_route : "",
		new_busno_up : "",
		new_busno_down : "",
	    });
	};
	
	$('#timepicker').timepicker();
	$scope.submitRoutes = function(){
	    alert('submit')
	    $scope.newRoute.$save()
               	.then(function(responce){
		    //$scope.routes = resourceService.SpecialDayTransport.query()
                    //alert ("responce")
                    
                })
        }

    }]);
    
})(angular, myApp);
