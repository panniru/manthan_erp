(function(angular, app) {
    "use strict";
    app.controller('StaffadminsController',["$scope", "staffadminsService",function($scope,staffadminsService) {
        
        staffadminsService.getStaffadminServiceView()
            .then(function(result) {
                $scope.faculties=result.data
            });
    }]);
})(angular, myApp);
