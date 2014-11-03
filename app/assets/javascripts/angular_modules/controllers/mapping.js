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
	
	
	$scope.nearDownRoutes = function(){
	    $scope.route.location 
	    mapService.getRouteServiceView( $scope.route.location)
		.then(function(response){
		    $scope.route = response.data
		    
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
	$scope.page = 1 
	$scope.getStudents = function(page){
	    mapService.getStudentView(page)
		.then(function(response){
		    $scope.students = response.data.students
		    $scope.total_entries = response.data.total_entries;
		    $scope.current_page = parseInt(response.data.current_page)
		    $scope.to_index = response.data.to_index
		    $scope.from_index = response.data.from_index
		});
	}

	$scope.count = 0;
	$scope.isDisabled = false;
	$scope.Disabled = false;
	$scope.saveRoute = function(route,location, student_master_id){
	    alert("Alloted")
	    if (route.lpp == 'Up Route')
	    {$scope.Disabled = true;}
	    else
	    { $scope.isDisabled = true;}
	    mapService.saveRoute(route,location,student_master_id)
		.then(function(result) {
		    $scope.count = $scope.count +1 ;
		    if ($scope.count == '2')
		    { window.location.reload(); }
		    else
		    {$('createModal').modal('hide');}
		});
	};
	
	$scope.mapStudent = function(student_id){
	    $scope.student_id = student_id
	    $('#createModal').modal('show');
	};

	
    }]);
    
})(angular, myApp);
