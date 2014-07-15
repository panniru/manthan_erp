(function(angular, app) {
    "use strict";
    app.controller("IssuingsController",["$scope", "gradeService","sectionService", function($scope, gradeService, sectionService) {
      $scope.myGrade = ""
             
        $scope.map_grades = []
        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data
                //alert(JSON.stringify($scope.grades));
                
            });
        $scope.map_sections = []
        sectionService.getSectionServiceView()
            .then(function(result) {
                //alert(JSON.stringify(result.data))
                $scope.sections=result.data
            });
       
}]);
    
})(angular, myApp);        

        
