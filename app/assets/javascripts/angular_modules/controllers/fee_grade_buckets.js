(function(angular, app) {
    "use strict";
    app.controller("FeeGradeBucketsController",["$scope", "gradeService",  function($scope, gradeService) {
        $scope.fee_grade_buckets = []
        
        for(var i=0; i<3; i++){
            $scope.fee_grade_buckets.push({"grade_from":""});
        };
        
        gradeService.allGrades()
            .then(function(responce){
                $scope.grades = responce.data
            });
      	
    }]);
	
})(angular, myApp);
