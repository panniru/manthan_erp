(function(angular, app) {
    "use strict";
    app.controller('StaffadminsController',["$scope", "staffadminsService",function($scope,staffadminsService) {
        $scope.myLead = 'teaching';
        
        staffadminsService.getCloseStatus()
            .then(function(result) {
                $scope.reasons = result.data
            });

        staffadminsService.getStaffadminServiceView()
            .then(function(result) {
                $scope.faculties=result.data
            });
        staffadminsService.getRoleAndHead()
            .then(function(result) {
                $scope.roles = result.data
            });
        staffadminsService.getSubjects()
            .then(function(result) {
                $scope.subjects = result.data
            });
        staffadminsService.getPostServiceView()
            .then(function(result) {
                $scope.posts = result.data
            });
        staffadminsService.getHeadServiceView()
            .then(function(result) {
                $scope.heads=result.data
            });
        staffadminsService.getKlassServiceView()
            .then(function(result) {
                $scope.klasses=result.data
            });
        
        
    }]);
})(angular, myApp);
