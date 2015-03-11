(function(angular, app) {
    "use strict";
    app.controller("DesignationMasterController",["$scope", "designationService",'$window', function($scope,designationService,$window) {

	$scope.getDesignation = function(page){
	    designationService.getDesignationServiceView(page)
		.then(function(result) {
		    $scope.designations =result.data;
		    $scope.total_entries = result.data.total_entries;
		    $scope.current_page = parseInt(result.data.current_page)
		    $scope.to_index = result.data.to_index
		    $scope.from_index = result.data.from_index
		    $scope.designation_details = [];
		    for(var i=0; i<result.data.designations.length; i++){
			$scope.designation_details.push({
			    id: null,
			    name: null,
			    managed_by: null,
			});
			
		    }
		    
		    
		});
	}
	$scope.saveDesignation = function(){
	    for(var i=0; i<$scope.designation_details.length; i++){
		$scope.designation_details[i]['id'] = $scope.designations.designations[i]['id'];
		$scope.designation_details[i]['name'] = $scope.designations.designations[i]['name'];
		$scope.designation_details[i]['managed_by'] = $scope.designations.designations[i]['managed_by'];
	    }
	    designationService.saveDesignation($scope.designation_details)
	        .then(function(result) {
	            $window.location.href = '/designation_masters';
	        });
	}
	
	$scope.saveDayEnds = function(day_ends ){
	    designationService.getDayEndsServiceView(day_ends)
		.then(function(result) {
		    if(result.status){
			$scope.editable = false
                        alert("Please sign in again to reflect the Day End.")
		    }
		})
	};

	$scope.getDayEnd = function(){
	    designationService.getDayEndView()
		.then(function(result) {
		    $scope.day_ends =result.data;
		}); 
	}
	

    }]);
})(angular, myApp);
