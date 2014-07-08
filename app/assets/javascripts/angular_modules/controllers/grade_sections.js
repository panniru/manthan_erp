(function(angular, app) {
    "use strict";
    app.controller("GradeSectionsController", ["$scope", "resourceService",  function($scope, resourceService) {
        $scope.grade = ""
        $scope.section = ""
        $scope.grades = resourceService.GradeMaster.query();
        $scope.fetchSections = function(){
            $scope.sections = resourceService.SectionMaster.query({grade_master_id: $scope.grade.id});
        }
    }]);
})(angular, myApp);


