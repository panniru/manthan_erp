(function(angular, app) {
    "use strict";
    app.controller('VendorController',["$scope", "vendorService",function($scope,vendorService) {
        
        vendorService.getVendorServiceView()
            .then(function(result) {
                $scope.vendors=result.data
            });
    }]);
})(angular, myApp);
