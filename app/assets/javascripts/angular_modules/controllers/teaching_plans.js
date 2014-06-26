(function(angular, app) {
    "use strict";
    app.controller("TeachingPlansController",["$scope", "gradeService","sectionService", function($scope, gradeService, sectionService) {
        $scope.map_grades = []
        gradeService.getGradeServiceMapView()
            .then(function(result) {
                $scope.map_grades=result.data
                
            });

        $scope.map_sections = []
        sectionService.getSectionServiceMapView()
            .then(function(result) {
                alert(result.data)
                $scope.map_sections=result.data
                
            });
    }]);
    
})(angular, myApp);



