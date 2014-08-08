(function(angular, app) {
    "use strict";
    app.controller("IssuingsController",["$scope", "issuingService", function($scope,  issuingService) {
      $scope.myGrade = ""
             
        $scope.map_grades = []
        issuingService.getGradeServiceView()
            .then(function(result) {
                // alert(JSON.stringify(result.data))
                $scope.grades=result.data
                
                
            });
        $scope.map_sections = []
        issuingService.getSectionServiceView()
            .then(function(result) {
                // alert(JSON.stringify(result.data))
                $scope.sections=result.data
            });
       
}]);
    
})(angular, myApp);        

