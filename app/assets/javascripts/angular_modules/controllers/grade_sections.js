(function(angular, app) {
    "use strict";
    app.controller("GradeSectionsController", ["$scope", "resourceService",  function($scope, resourceService) {
        $scope.grades = resourceService.GradeMaster.query();
        $scope.fetchSections = function(){
            resourceService.GradeMaster.sections({id: $scope.grade.id}, function(responce){
                $scope.sections = responce.sections;  
            });
        }
        $scope.emitState = function(){
            $scope.$emit('gradeMaster', $scope.grade.id)
            $scope.$emit('sectionMaster', $scope.section.id)
        }
    }]);
})(angular, myApp);


