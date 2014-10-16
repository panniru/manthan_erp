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
	
	routesService.getVendorName()
	    .then(function(result) {
		$scope.vendors = result.data
	    });

	$scope.defineNew = function(){
	    $scope.action = "new"
	    fetch_locations();
	    fetch_bus();
	    $scope.newRoute = new resourceService.Route({"route_no":"","lpp":"", "busno_up":"",  "locations":[]})
	    for(var i=0; i<2; i++){
	        $scope.newRoute.locations.push({"location_master_id":"" , "sequence_no": "" , "route_id" : ""});
            };
            $('#createModal').modal('show')
        }
	
	$scope.allStudents = function(route){
	    $('#studentModal').modal('show');
	    routesService.getStudentView(route)
		.then(function(response){
		    $scope.students = response.data
		});
	    
        }
	$scope.allLocations = function(location){
	    $('#indexModal').modal('show');
	    routesService.getLocationView(location)
		.then(function(response){
		    $scope.locations = response.data
		});
        }
	$scope.sendMail = function(){
	    routesService.routeMail($scope.subject, $scope.text)
		.then(function(response){
		    $('#myModal').modal('hide');  
		});
	}
	
	var createRoutes = function(){
	    $scope.newRoute.$save()
	   	.then(function(responce){
		    $scope.routes = resourceService.Route.query()
                    $('#createModal').modal('hide')
	    	    window.location.reload();
		})
	}

	var updateRoutes = function(){
	    $scope.newRoute.$update()
	   	.then(function(responce){
		    $scope.routes = resourceService.Route.query()
		    $('#createModal').modal('hide')
	    	    window.location.reload();
		})
	}
	
        $scope.submitRoutes = function(){
	    //alert($scope.action)
	    if($scope.action === 'edit'){
		updateRoutes();
	    }else{
		createRoutes();
	    }
	}
	
	
	$scope.editRoutes = function(route){
	    $scope.route = route
	    $scope.action = "edit"
	    fetch_bus();
	    fetch_locations();
	    routesService.getRouteLocation(route.id)
		.then(function(response){
		    route.locations = response.data
		    $scope.newRoute = route
		    $('#createModal').modal('show')
		});
	}
	
	$scope.destroy = function(route){
            route.$delete()
	    	.then(function(response){
                    $scope.routes.splice($scope.routes.indexOf(route), 1)
		});
	};

        $scope.addMoreterms = function(){
	    var lnt = parseInt($scope.newRoute.locations.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newRoute.locations.push({"location_master_id":"" ,"sequence_no":"" , "route_id": ""});
            };
        }
    }]);
    
})(angular, myApp);
