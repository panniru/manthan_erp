(function(angular, app) {
    "use strict";
    app.controller('KlassController',["$scope","klassService",function($scope,klassService) {
        
        klassService.getKlassServiceView()
            .then(function(result) {
                $scope.klasses=result.data
            });
        
    }]);
})(angular, myApp);
