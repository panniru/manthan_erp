(function(angular, app) {
    "use strict";
    app.controller('StaffAdmissionsController',["$scope", "staffadmissionheadsService",function($scope,staffadmissionheadsService) {
        
        staffadmissionheadsService.getHeadServiceView()
            .then(function(result) {
                $scope.heads=result.data
            });
    }]);
})(angular, myApp);
