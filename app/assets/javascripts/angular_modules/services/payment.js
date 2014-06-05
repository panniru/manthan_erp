(function(angular, app) {
    "use strict";
    app.service("paymentService",["$http", function($http) {
        
        var student_current_term_fee = function(student_id){
        };
        
        var student_monthly_pdcs = function(student_id){
        };
        
        var student_annula_payment_discount = function(student_id){
        };
        
        
        return {
            student_current_term_fee : student_current_term_fee,
            student_monthly_pdcs : student_monthly_pdcs,
            student_annula_payment_discount : student_annula_payment_discount
        };
        
    }]);
})(angular, myApp);
