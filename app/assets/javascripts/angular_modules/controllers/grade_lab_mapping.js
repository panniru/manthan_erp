(function(angular, app) {
    "use strict";
    app.controller("gradeLabMappingController", ["$scope" , "gradeLabMappingService", "timeTableService" , function($scope , gradeLabMappingService , timeTableService){
	
	gradeLabMappingService.getLabNames()
	    .then(function(response){
		$scope.subjects = response.data
	    });
	
        timeTableService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data;                 
            });
	
    }]);
    
})(angular, myApp);

