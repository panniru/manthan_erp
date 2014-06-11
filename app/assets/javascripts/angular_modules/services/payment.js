(function(angular, app) {
    "use strict";
    app.service("paymentService",["$http", function($http) {
        
        var student_current_term_fee = function(student_id){
            var url = "/student_masters/"+student_id+"/next_term_fee.json"
            return $http.get(url)
        };
        
        var student_monthly_pdcs = function(student_id){
            var url = "/student_masters/"+student_id+"/monthly_pdcs.json"
            return $http.get(url)
        };
        
        var annual_discount_details = function(student_id){
            var url = "/student_masters/"+student_id+"/annual_discount_details.json"
            return $http.get(url)
        };
        
        var parent_payment_transactions = function(payment_id){
            var url = "/parent_payment_masters/"+payment_id+"/payment_transactions.json"
            return $http.get(url)
        };

        var transactionTypes = function(){
            return [{value: "cash", text: "CASH"}, {value: "cheque", text: "CHEQUE"}]
        }
        
        var supportedBanks = function(){
            return [{value: "sbi", text: "State Bank Of India"}, {value: "icici", text: "ICICI"}, {value: "axis_bank", text: "Axis Bank"}]
        }

        return {
            student_current_term_fee : student_current_term_fee,
            student_monthly_pdcs : student_monthly_pdcs,
            annual_discount_details : annual_discount_details,
            parent_payment_transactions : parent_payment_transactions,
            transactionTypes : transactionTypes,
            supportedBanks : supportedBanks
        };
        
    }]);
})(angular, myApp);
