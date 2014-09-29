(function(angular, app) {
    "use strict";
    app.controller('GuestController',["$scope", "guestService",function($scope,guestService) {
        
        guestService.getRoleServiceView()
            .then(function(result) {
                $scope.roles=result.data
            });
    }]);
})(angular, myApp);
