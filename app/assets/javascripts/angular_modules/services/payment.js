(function(angular, app) {
    "use strict";
    app.service("paymentService",["$http", function($http) {
        
        var student_current_term_fee = function(student_id){
            var url = "/student_hrs/"+student_id+"/next_term_fee.json"
            return $http.get(url)
        };
        
        var student_monthly_pdcs = function(student_id){
            var url = "/student_hrs/"+student_id+"/monthly_pdcs.json"
            return $http.get(url)
        };
        
        var student_annula_payment_discount = function(student_id){
        };
        
        var parent_payment_transactions = function(payment_id){
            var url = "/parent_payment_masters/"+payment_id+"/payment_transactions.json"
            return $http.get(url)
        };

        return {
            student_current_term_fee : student_current_term_fee,
            student_monthly_pdcs : student_monthly_pdcs,
            student_annula_payment_discount : student_annula_payment_discount,
            parent_payment_transactions : parent_payment_transactions
        };
        
    }]);
})(angular, myApp);
