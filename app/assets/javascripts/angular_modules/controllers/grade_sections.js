(function(angular, app) {
    "use strict";
    app.controller("GradeSectionsController", ["$scope", "resourceService",  function($scope, resourceService) {
        $scope.grades = resourceService.GradeMaster.query();
        $scope.fetchSections = function(){
            resourceService.GradeMaster.sections({id: $scope.grade.id}, function(responce){
                $scope.sections = responce.sections;  
            });
        }
    }]);
})(angular, myApp);


