(function(angular, app) {
    "use strict";
    app.controller("IssuingsController",["$scope", "issuingService", function($scope,  issuingService) {
      $scope.myGrade = ""
             
        $scope.map_grades = []
        issuingService.getGradeServiceView()
            .then(function(result) {
                
                $scope.grades=result.data
                
                
            });
        $scope.map_sections = []
        issuingService.getSectionServiceView()
            .then(function(result) {
                
                $scope.sections=result.data
            });
       
}]);
    
})(angular, myApp);        

