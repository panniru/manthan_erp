(function(angular, app) {
    "use strict";
  
    app.controller("MonthFeePayamentsController",["$scope", "paymentService",  function($scope, paymentService) {
        $scope.getPdcs = function(){
            paymentService.student_monthly_pdcs($scope.student_id)
                .then(function(response){
                    $scope.monthlyFees = []
                    angular.forEach(response.data, function(value){
                        $scope.monthlyFees.push({post_dated_cheque_id: value.post_dated_cheque_id, cheque_date: value.month, amount_in_rupees: value.amount_in_rupees, cheque_number: value.cheque_number, clearence_date: value.clearence_date, bank_name: "", ifsc_code: ""})
                    })
                });
        }
        
        $scope.applyforAllMonths = function(){
            var first_value = $scope.monthlyFees[0]
            angular.forEach($scope.monthlyFees, function(value, index){
                value.cheque_number = parseInt(first_value.cheque_number)+index
                value.bank_name = first_value.bank_name
                value.ifsc_code = first_value.ifsc_code
            });
        }
        
        $scope.checkfirstFilled = function(){
            if (typeof $scope.monthlyFees != 'undefined' && typeof $scope.monthlyFees[0] != 'undefined'){
                var first_value = $scope.monthlyFees[0]
                return (typeof first_value.cheque_number != 'undefined' && first_value.bank_name != "" && first_value.ifsc_code != "") 
            }
        }
        
        $scope.submitPdcs = function(){
            var transactions = {}
            for(var i=0; i < $scope.monthlyFees.length ; i++){
                for(var j = i+1 ; j <  $scope.monthlyFees.length; j++){
                    if($scope.monthlyFees[i].cheque_number === $scope.monthlyFees[j].cheque_number){
                        $scope.$parent.errors.push({cheque_number: $scope.monthlyFees[j].cheque_number+" is duplicated"})
                        return false;
                    }
                }
            }
            angular.forEach($scope.monthlyFees, function(value, index){
                transactions[index] = {parent_cheque: value}
            });
            $scope.$parent.doPayment(transactions);
        }

    }]);

    app.controller("TermFeePayamentsController",["$scope", "paymentService",  function($scope, paymentService) {
        $scope.getNextTerm = function(){
            paymentService.student_current_term_fee($scope.student_id)
                .then(function(response){
                    var nextTerm = response.data
                    var mockCheque = {cheque_number: null, bank_name: null, ifsc_code: null, cheque_date: null}
                    $scope.parent_payment_transaction = {term_definition_id: nextTerm.term_definition_id, particulars: nextTerm.term, amount_in_rupees: nextTerm.amount_in_rupees, transaction_type: null, parent_cheque: mockCheque}
            });
        }
        
        $scope.submitTermFee = function(){
            $scope.parent_payment_transaction.parent_cheque.cheque_date = $("#parentChequeDate").val()
            $scope.$parent.doPayment({0: $scope.parent_payment_transaction});
        }
    }]);

    app.controller("AnnualFeePayamentsController",["$scope", "paymentService",  function($scope, paymentService) {
        $scope.getDiscount = function(){
            paymentService.annual_discount_details($scope.student_id)
                .then(function(response){
                    $scope.discount = response.data
                    var mockCheque = {cheque_number: null, bank_name: null, ifsc_code: null, cheque_date: null}
                    $scope.parent_payment_transaction = {amount_in_rupees: $scope.discount.amount_to_be_paid, transaction_type: null, parent_cheque: mockCheque}
            });
        }
        $scope.submitAnnualFee = function(){
            $scope.parent_payment_transaction.parent_cheque.cheque_date = $("#parentChequeDate").val()
            $scope.$parent.doPayment({0: $scope.parent_payment_transaction});
        }
    }]);
    
    app.controller("TransAcknowledgementController",["$scope", "$route","paymentService",  function($scope, $route, paymentService) {
        $scope.buildAcknowledgement = function(){
            paymentService.transactionInDetail($scope.$parent.parent_payment_master_id, $route.current.params.id)
                .then(function(responce){
                    $scope.parent_payment_transaction = responce.data
                })
        }
    }]);


                   
    
    app.controller("PaymentsController",["$scope","$location", "paymentService",  function($scope, $location, paymentService) {
        $scope.student_id = ""
        $scope.is_cheque_payment = false
        $scope.selected_transaction_type = ""
        $scope.errors = []
        $scope.go = function (code, student_id ) {
            $scope.payment_type_code = code
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

        
        $scope.doPayment = function(transactions){
            $scope.errors = {}
            $scope.submitted = false
            angular.forEach(transactions, function(value, key){
                if($scope.payment_type_code != 'monthly'){
                    $.extend($scope.errors, paymentService.validateTransaction(value))
                }else{
                    $.extend($scope.errors, paymentService.validateCheque(value.parent_cheque))
                }
            })
            if(Object.keys($scope.errors).length === 0){ //$scope.errors.length === 0
                var parent_payment_master = {payment_type_id: $scope.payment_type_id, student_id: $scope.student_id, parent_payment_transactions: transactions}
                if(typeof $scope.parent_payment_master_id != 'undefined' && $scope.parent_payment_master_id != null){
                    update($scope.parent_payment_master_id, parent_payment_master);
                }else{
                    save(parent_payment_master);
                }
            }

        }
        
        var save = function(parent_payment_master){
            paymentService.savePayment(parent_payment_master)
                .then(function(response){
                    var data = response.data
                    if(data.status){
                        $scope.submitted = true;
                        $scope.parent_payment_master_id = data.parent_payment_master_id
                        if($scope.payment_type_code != 'monthly'){
                            $location.path("/trans_acknowledgement/"+data.last_transaction_id );
                        }
                    }else{
                        $scope.errors = data.errors
                    }
                });
        }

        var update = function(parent_payment_master_id, parent_payment_master){
            paymentService.updatePayment(parent_payment_master_id, parent_payment_master)
                .then(function(response){
                    var data = response.data
                    if(data.status){
                        $scope.submitted = true;
                        $location.path("/trans_acknowledgement/"+data.last_transaction_id );
                    }else{
                        $scope.errors = data.errors
                    }
                });
        }

        $scope.routeToTermFee = function(){
            $location.path("/term_wise_payment");
        }
        $scope.supportedBanks = paymentService.supportedBanks();
        
    }]);
    
})(angular, myApp);
