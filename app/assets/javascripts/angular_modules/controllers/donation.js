(function(angular, app) {
    "use strict";
    app.controller("DonationsController",["$scope", "donationService", function($scope,  donationService) {
        $scope.myGrade = ""
        
        $scope.map_grades = []
        donationService.getGradeServiceView()
            .then(function(result) {
               
                $scope.grades=result.data
                
                
            });
        $scope.map_sections = []
        donationService.getSectionServiceView()
            .then(function(result) {
                $scope.sections=result.data
            });
        
    }]);
    
})(angular, myApp);        

