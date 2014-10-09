(function(angular, app) {
    "use strict";
    app.controller("PaymentTransactionsController",["$scope","paymentService", "resourceService","$element",  function($scope, paymentService, resourceService, $element) {
        $scope.selectedStudents = []
        $scope.getParentPaymentTransactions = function(parent_payment_id){
            paymentService.parent_payment_transactions(parent_payment_id)
                .then(function(response){
                    $scope.parent_payment_transactions = response.data;
                });
        }

        $scope.parentTransactions = function(){
            paymentService.parent_transactions()
                .then(function(response){
                    $scope.parent_payment_transactions = response.data;
                    $scope.filtered_payment_transactions = response.data;
                });
        }

        $scope.checked_item = function(student){

            if($("#student-"+student.id).is(':checked')){
                $scope.selectedStudents.push(student.id)
            }else{
                $scope.selectedStudents.splice($scope.selectedStudents.indexOf(student.id), 1)
            }
            if($scope.selectedStudents.length > 0){
                filter_values();
            }else{
                $scope.filtered_payment_transactions = $scope.parent_payment_transactions;
            }
        }

        var filter_values = function(){
            $scope.filtered_payment_transactions = []
            angular.forEach($scope.parent_payment_transactions, function(value){
                if($scope.selectedStudents.indexOf(value.student_id) != -1){
                    $scope.filtered_payment_transactions.push(value);
                }
            })
        }
    }]);

    app.controller("PaymentStudentTransactionsController",["$scope","paymentService", function($scope, paymentService) {
        $scope.getStudentPaymentTransactions = function(studentId){
            paymentService.student_transactions(studentId)
                .then(function(response){
                    $scope.filtered_payment_transactions = response.data;
                });
        }


    }]);

    
})(angular, myApp);
