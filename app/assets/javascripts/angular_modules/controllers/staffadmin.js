(function(angular, app) {
    "use strict";
    app.controller('StaffadminsController',["$scope", "staffadminsService",function($scope,staffadminsService) {
        
        staffadminsService.getStaffadminServiceView()
            .then(function(result) {
                $scope.faculties=result.data
            });
        staffadminsService.getRoleAndHead()
            .then(function(result) {
                $scope.roles = result.data
            });
    }]);
})(angular, myApp);
