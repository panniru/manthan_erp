(function(angular, app) {
    "use strict";
    app.controller('StaffsController',["$scope", "staffsService",function($scope,staffsService) {
        
        staffsService.getPostServiceView()
            .then(function(result) {
                $scope.posts=result.data
            });
        staffsService.getStatusServiceView()
            .then(function(result) {
                $scope.status=result.data
            });
        
    }]);
})(angular, myApp);
