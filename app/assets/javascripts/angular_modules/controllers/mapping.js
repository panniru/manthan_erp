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


	$scope.sendForApproval = function(status,student){
	    if(status){
		$scope.request_status.push({
		    id: student.id,
		    status: ""
		});
	    }
	    else
	    {
		for (var i=0; i<$scope.request_status.length; i++){
		    if (student.id == $scope.request_status[i]['id']){
			$scope.request_status.splice(i, 1);
			break;
		    }
		}
	    }
	};
	
	mapService.getStudentView()
	    .then(function(response){
		$scope.students = response.data
	    });
	
	
	$scope.saveRoute = function(route,location, student_master_id){
	    mapService.saveRoute(route,location,student_master_id)
		.then(function(result) {
		    $('createModal').modal('hide');
		    window.location.reload();
		});
	};
	
	$scope.mapStudent = function(student_id){
	    $scope.student_id = student_id
	    $('#createModal').modal('show');
	};

	
    }]);
    
})(angular, myApp);
