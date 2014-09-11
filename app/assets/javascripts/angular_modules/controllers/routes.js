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
		    $scope.bus.splice($scope.bus.indexOf(bus), 1)
		});
	}
	
	$scope.items = [
	    { id: 1, name: 'Up route' },
	    { id: 2, name: 'Down Route' }
	];
	$scope.defineNew = function(){
	    fetch_locations();
	    fetch_bus();
	    $scope.newRoute = new resourceService.Route({"route_no":"","lpp":"", "busno_up":"",  "locations":[]})
	    for(var i=0; i<2; i++){
		alert('newRoute')
                $scope.newRoute.locations.push({"location_master_id":"" , "sequence_no": ""});
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
	
        $scope.submitRoutes = function(){
	    alert('')
	    $scope.newRoute.$save()
	   	.then(function(responce){
		    $scope.routes = resourceService.Route.query()
                    $('#createModal').modal('hide')
	    	})
	}
	
	$scope.busNo = function(){
	    alert(JSON.stringify(lpp));
        }
	
	$scope.editRoutes = function(route){
	    resourceService.Route.locations({id: route.id })
                .then(function(responce){
		    alert(JSON.strigify(responce.data))
                    // route.locations = responce.data
                })

	    $('#editModal').modal('show');
        }
	
	$scope.destroy = function(route){
            route.$delete()
                .then(function(responce){
                    $scope.routes.splice($scope.routes.indexOf(route), 1)
                })
        };

        $scope.addMoreterms = function(){
	    var lnt = parseInt($scope.newRoute.locations.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newRoute.locations.push({"location_master_id":"" ,"sequence_no":""});
            };
        }
    }]);
    
})(angular, myApp);
