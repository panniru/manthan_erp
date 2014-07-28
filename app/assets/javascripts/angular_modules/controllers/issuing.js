(function(angular, app) {
    "use strict";
    app.controller("IssuingsController",["$scope", "gradeService","sectionService", function($scope, gradeService, sectionService) {
      $scope.myGrade = ""
             
        $scope.map_grades = []
        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data
                
                
            });
        $scope.map_sections = []
        sectionService.getSectionServiceView()
            .then(function(result) {
                
                $scope.sections=result.data
            });
       
}]);
    
})(angular, myApp);        

