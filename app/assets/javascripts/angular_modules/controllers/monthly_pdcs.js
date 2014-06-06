(function(angular, app) {
    "use strict";
    app.controller("MonthlyPdcsController",["$scope", "monthlyPdcService", function($scope, monthlyPdcService) {
        $scope.monthly_pdcs = []
        
        $scope.submitted_pdcs = function(payment_master_id){
            monthlyPdcService.get_submitted_pdcs(payment_master_id)
                .then(function(response){
                    $scope.monthly_pdcs = response.data
                });
        };
        
        $scope.cleared_pdcs = function(payment_master_id){
            monthlyPdcService.get_cleared_pdcs(payment_master_id)
                .then(function(response){
                    $scope.monthly_pdcs = response.data
                });
        };
        
    }]);
    
})(angular, myApp);

