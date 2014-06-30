(function(angular, app) {
    "use strict";
    app.directive('paymentTypeTabs', function(){
        return{
            restrict: 'E',
            controller: ["$scope", "$attrs", "$http", "paymentService", function($scope, $attrs, $http, paymentService) {
                $scope.terms = [];
                $scope.is_tems_initiated = false;
                $scope.is_months_initiated = false;
                $scope.months = [];
                
                var student_id = $attrs.studentId;
                paymentService.annual_discount_details(student_id)
                    .then(function(responce){
                        $scope.discount = responce.data
                    });
                $scope.anual_fee_structure = function(){
                    $('#feeTab a:first').tab('show') 
                };
                
                $scope.term_wise_fee_structure = function(){
                    if(!$scope.is_tems_initiated){
                        var url = "/term_wise_grade_fees/term_wise_fee_of_student.json?student_id="+student_id
                        $http.get(url)
                            .then(function(response){
                                $scope.terms = response.data.term_fee_details
                                $scope.term_totals = response.data.total
                                $scope.is_tems_initiated = true;
                            });
                    }
                    $('#feeTab a:second').tab('show') 
                };
                
                $scope.monthly_fee_structure = function(){
                    if(!$scope.is_months_initiated){
                        var url = "/monthly_pdc_amounts/month_wise_fee_of_student.json?student_id="+student_id
                        $http.get(url)
                        .then(function(response){
                            $scope.months = response.data.month_fee_details
                            $scope.month_totals = response.data.total
                            $scope.is_months_initiated = true;
                        });
                    }
                    $('#feeTab a:last').tab('show') 
                };
            }],
            templateUrl: 'payment_type_tabs.html'
        };
    });
})(angular, myApp);
