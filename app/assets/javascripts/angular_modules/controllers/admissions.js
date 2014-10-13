(function(angular, app) {
    "use strict";
    app.controller('AdmissionsController',["$scope", "admissionsService",function($scope,admissionsService) {
        
        admissionsService.getKlassServiceView()
            .then(function(result) {
                $scope.klasses=result.data
            });
        
        }]);
})(angular, myApp);
