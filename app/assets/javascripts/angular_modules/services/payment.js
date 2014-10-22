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
            var url = "/parent_payment_masters/transaction_types.json"
            return $http.get(url)
        }
        
        var supportedBanks = function(){
            return [{value: "sbi", text: "State Bank Of India"}, {value: "icici", text: "ICICI"}, {value: "axis_bank", text: "Axis Bank"}]
        }

        var parent_transactions = function(parent_id){
            var url = "/parent_payment_transactions/parent_transactions.json"
            return $http.get(url)
        }

        var student_transactions = function(studentId){
            var url = "/parent_payment_masters/student_transactions.json"
            return $http.get(url, {params: {student_id: studentId}})
        }
        
        var savePayment = function(parent_payment_master){
            var url = "/parent_payment_masters.json"
            return $http.post(url, {parent_payment_master: parent_payment_master})
        }

        var updatePayment = function(parent_payment_master_id, parent_payment_master){
            var url = "/parent_payment_masters/"+parent_payment_master_id+".json"
            return $http.put(url, {parent_payment_master: parent_payment_master})
        }


        var transactionInDetail = function(parent_payment_master_id, transaction_id){
            var url = "/parent_payment_masters/"+parent_payment_master_id+"/parent_payment_transactions/"+transaction_id+"/in_detail.json"
            return $http.get(url)
        }

        var validateTransaction = function(transaction){
            var errors = {}
            if(typeof transaction.transaction_type == 'undefined' || transaction.transaction_type === null){
                errors["transaction_type"] = ["Invalid Transaction Type"]
            }
            if(typeof transaction.amount_in_rupees == 'undefined' || transaction.amount_in_rupees === null){
                errors["amount_in_rupees"] = ["Invalid Transaction Amount"]
            }
            if(typeof transaction.parent_cheque != 'undefined' && transaction.transaction_type == 'cheque'){
                $.extend(errors, validateCheque(transaction.parent_cheque))
            }
            return errors
        }

        var validateCheque = function(cheque){
            var errors = {} 
            if(typeof cheque.cheque_number == 'undefined' || cheque.cheque_number === null){
                errors["cheque_number"] =  ["Invalid Cheque Number"]
            }
            if(typeof cheque.bank_name == 'undefined' || cheque.bank_name === null){
                errors["bank_name"] = ["Invalid Bank Name"]
            }
            if(typeof cheque.cheque_date == 'undefined' || cheque.cheque_date === null){
                errors["cheque_date"] = ["Invalid Cheque Date"]
            }
            return errors
        }

        return {
            student_current_term_fee : student_current_term_fee,
            student_monthly_pdcs : student_monthly_pdcs,
            annual_discount_details : annual_discount_details,
            parent_payment_transactions : parent_payment_transactions,
            transactionTypes : transactionTypes,
            supportedBanks : supportedBanks,
            parent_transactions : parent_transactions,
            student_transactions : student_transactions,
            savePayment : savePayment,
            updatePayment : updatePayment,
            transactionInDetail: transactionInDetail,
            validateTransaction : validateTransaction,
            validateCheque : validateCheque
        };
        
    }]);
})(angular, myApp);
