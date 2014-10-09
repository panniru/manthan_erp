(function(angular, app) {
    "use strict";
    app.directive('parentChildren', function(){
        return{
            restrict: 'E',
            scope: {
                parentId: '=',
                editable: '=',
                checked_item: "&checkedItem"
            },
            controller: ["$scope", "resourceService", function($scope, resourceService){
                $scope.students = resourceService.StudentMaster.belongs_to_parent({parent_id: $scope.parentId })
                $scope.mark_item = function(student){
                    $scope.checked_item({student: student})
                }
            }],
            templateUrl: 'parent_children.html'
        };
    });
})(angular, myApp);
