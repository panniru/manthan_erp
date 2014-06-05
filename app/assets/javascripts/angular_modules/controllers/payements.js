(function(angular, app) {
    "use strict";
    app.controller("PaymentsController",["$scope","$location",  function($scope, $location) {
        $scope.go = function (code, student_id ) {
            alert(student_id)
            $scope.student_id = student_id
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

        $scope.annaul_fee_payment_details = function(){
        };
        
        $scope.term_fee_payment_details = function(){
        };

        $scope.month_fee_payment_details = function(){
        };
        
    }]);
    
})(angular, myApp);
