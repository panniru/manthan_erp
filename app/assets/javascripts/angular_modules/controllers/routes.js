(function(angular, app) {
    "use strict";
    app.controller("RouteController", ["$scope","resourceService","routesService", function($scope, resourceService, routesService ) {
	$scope.routes = resourceService.Route.query();
	
	var fetch_loactions = function(){
	    routesService.getLocationServiceView()
		.then(function(result) {
                    $scope.all_locations =result.data
		});
	}
	
        
	$scope.defineNew = function(){
	    fetch_loactions();
	    $scope.newRoute = new resourceService.Route({"busno_up":"", "no_of_children":"", "route_no":"", "locations":[]})
	    for(var i=0; i<1; i++){
                $scope.newRoute.locations.push({"location_master_id":"" , "sequence_no": ""});
            };
            $('#createModal').modal('show')
        }

	$scope.sendMail = function(){
	    routesService.routeMail($scope.subject, $scope.text)
		.then(function(response){
		    //alert(response.data)
		});
	}
	
        $scope.submitRoutes = function(){
	    $scope.newRoute.$save()
	        .then(function(responce){
	    	    $scope.routes = resourceService.Route.query()
                    $('#createModal').modal('hide')
	    	})
	}
	
	$scope.editLocations = function(){
	    alert();
	    //$scope.newRoute.locations = $scope.Route;
            $('#editModal').modal('show');
        }

        $scope.addMoreterms = function(){
	    var lnt = parseInt($scope.newRoute.locations.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newRoute.locations.push({"location_master_id":"" ,"sequence_no":""});
            };
        }
    }]);
    
})(angular, myApp);
