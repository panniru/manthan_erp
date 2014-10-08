(function(angular, app) {
    "use strict";
    app.directive('parentChildren', function(){
        return{
            restrict: 'E',
            scope: {
                parentId: '=',
                editable: '='
            },
            controller: ["$scope", "resourceService", function($scope, resourceService){
                console.log($scope.editable)
                $scope.students = resourceService.StudentMaster.belongs_to_parent({parent_id: $scope.parentId })
            }],
            templateUrl: 'parent_children.html'
        };
    });
})(angular, myApp);
