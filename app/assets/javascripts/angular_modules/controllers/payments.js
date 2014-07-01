(function(angular, app) {
    "use strict";
    app.controller("PaymentsController",["$scope","$location", "paymentService",  function($scope, $location, paymentService) {
        $scope.student_id = ""
        $scope.selected_transaction_type = ""
        $scope.go = function (code, student_id ) {
            $scope.student_id = student_id
            $scope.typeInitiated = true
            var path = "/"
            if(code == "annual"){
                path = "/annual_payment"
            }else if (code == "term_wise"){
                path = "/term_wise_payment"
            }else{
                path = "/monthly_payment"
            }
            $location.path( path );
        };

        $scope.annaul_discount_details = function(){
            paymentService.annual_discount_details($scope.student_id)
                .then(function(response){
                    $scope.discount = response.data
                });
        };
        
        $scope.term_fee_payment_details = function(){
            paymentService.student_current_term_fee($scope.student_id)
                .then(function(response){
                    $scope.term = response.data
                });
        };

        $scope.month_fee_payment_details = function(){
            paymentService.student_monthly_pdcs($scope.student_id)
                .then(function(response){
                    $scope.monthlyFees = response.data
                });
        };
        
        $scope.transactionTypeChange = function(selected_transaction_type){
            if(selected_transaction_type.trim() === "cheque"){
                $scope.is_cheque_payment = true
            }else{
                $scope.is_cheque_payment = false
            }
        }
        
        paymentService.transactionTypes().then(function(response){
            $scope.transactionTypes = response.data
        });
        $scope.supportedBanks = paymentService.supportedBanks();

    }]);
    
})(angular, myApp);
