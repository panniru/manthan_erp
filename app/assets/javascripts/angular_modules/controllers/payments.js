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
                    $scope.monthlyFees = []
                    angular.forEach(response.data, function(value){
                        $scope.monthlyFees.push({post_dated_cheque_id: value.post_dated_cheque_id, month: value.month, amount_in_rupees: value.amount_in_rupees, cheque_number: value.cheque_number, clearence_date: value.clearence_date, bank_name: "", ifsc_code: ""})
                    })
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

        $scope.applyforAllMonths = function(){
            var first_value = $scope.monthlyFees[0]
            angular.forEach($scope.monthlyFees, function(value, index){
                value.cheque_number = parseInt(first_value.cheque_number)+index
                value.bank_name = first_value.bank_name
                value.ifsc_code = first_value.ifsc_code
            });
        }
        
        $scope.checkfirstFilled = function(){
            var first_value = $scope.monthlyFees[0]
            return (typeof first_value.cheque_number != 'undefined' && first_value.bank_name != "" && first_value.ifsc_code != "") 
        }
        $scope.supportedBanks = paymentService.supportedBanks();

    }]);
    
})(angular, myApp);
