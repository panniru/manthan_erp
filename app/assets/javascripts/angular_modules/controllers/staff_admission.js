(function(angular, app) {
    "use strict";
    app.controller('StaffsController',["$scope", "staffsService",function($scope,staffsService) {
        
        staffsService.getPostServiceView()
            .then(function(result) {
                $scope.posts=result.data
            });
    }]);
})(angular, myApp);
