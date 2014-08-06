(function(angular, app) {
    "use strict";
    app.controller('LeadController',["$scope", "addsService",function($scope,addsService) {
        
        addsService.getDeptServiceView()
            .then(function(result) {
                $scope.adds=result.data
            });
    }]);
})(angular, myApp);
