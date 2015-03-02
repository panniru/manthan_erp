(function(angular, app) {
    "use strict";
    app.controller("gradeLabMappingController", ["$scope" , "gradeLabMappingService", "gradesSubjectsMapService" , function($scope , gradeLabMappingService , gradesSubjectsMapService){
	
	gradeLabMappingService.getLabNames()
	    .then(function(response){
		$scope.subjects = response.data
	    });
	
	
	gradesSubjectsMapService.getGradesSubjectsServiceView()
            .then(function(result) {
                $scope.show_grades=result.data; 
            });
	
    }]);
    
})(angular, myApp);

