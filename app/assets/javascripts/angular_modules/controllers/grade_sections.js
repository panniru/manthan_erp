(function(angular, app) {
    "use strict";
    app.controller("GradeSectionsController", ["$scope", "resourceService",  function($scope, resourceService) {
        $scope.grade = ""
        $scope.section = ""
        $scope.grades = resourceService.GradeMaster.query();
        $scope.fetchSections = function(){
            $scope.grade.$sections()
                .then(function(responce){
                  $scope.sections = responce.sections;  
                })
        }
    }]);
})(angular, myApp);


