(function(angular, app) {
    "use strict";
    app.controller("RouteController", ["$scope","resourceService","routesService", function($scope, resourceService, routesService ) {
	$scope.routes = resourceService.Route.query();
	var fetch_locations = function(){
	    routesService.getLocationServiceView()
		.then(function(result) {
                    $scope.all_locations =result.data
		});
	}
	var fetch_bus = function(){
	    routesService.getBusServiceView()
		.then(function(result) {
                    $scope.bus =result.data
		});
	}
	        
	$scope.defineNew = function(){
	    fetch_locations();
	    fetch_bus();
	    $scope.newRoute = new resourceService.Route({"route_no":"", "busno_up":"",  "locations":[]})
	    for(var i=0; i<2; i++){
                $scope.newRoute.locations.push({"location_master_id":"" , "sequence_no": ""});
            };
            $('#createModal').modal('show')
        }

	$scope.sendMail = function(){
	    routesService.routeMail($scope.subject, $scope.text)
		.then(function(response){
		    //this.modal('hide');
		    //$location.path('/routes');
		});
	    //$('#MailModal').modal('hide')
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
