(function(angular, app) {
    "use strict";
    app.controller("PaymentTransactionsController",["$scope","paymentService",  function($scope, paymentService) {
        $scope.getParentPaymentTransactions = function(parent_payment_id){
            paymentService.parent_payment_transactions(parent_payment_id)
                .then(function(response){
                    
                    $scope.parent_payment_transactions = response.data;
                });
        }
    }]);
    
})(angular, myApp);
