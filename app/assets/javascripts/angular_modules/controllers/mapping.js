(function(angular, app) {
    "use strict";
    app.controller("MappingController", ["$scope","MappingService", function($scope, MappingService ) {
  
	var fetch_loactions = function(){
	    MappingService.getLocationServiceView()
		.then(function(result) {
                    $scope.all_locations =result.data
		});
	}



    }]);
    
})(angular, myApp);
