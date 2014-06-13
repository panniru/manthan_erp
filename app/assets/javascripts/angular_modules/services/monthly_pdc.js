(function(angular, app) {
    "use strict";
    app.service("monthlyPdcService",["$http", function($http) {
        var getMonthyPdcView = function(){
            var url = "/monthly_pdc_amounts/monthly_pdc_amounts.json"
            return $http.get(url);
        };
        
        var saveMonthlyPdc = function(termWiseFees){
            var url = "/monthly_pdc_amounts/save_monthly_pdc_amounts.json"
            return $http.post(url, {params: termWiseFees});
        };

        var get_pending_pdcs = function(payment_master_id){
            var url = "/parent_payment_masters/"+payment_master_id+"/pending_pdcs.json"
            return $http.get(url);
        }

        var get_cleared_pdcs = function(payment_master_id){
            var url = "/parent_payment_masters/"+payment_master_id+"/cleared_pdcs.json"
            return $http.get(url);
        }

        var get_submitted_pdcs = function(payment_master_id){
            var url = "/parent_payment_masters/"+payment_master_id+"/submitted_pdcs.json"
            return $http.get(url);
        }
        var search_pdcs = function(serialized_params){
            var url = "/parent_cheques.json?"+serialized_params
            return $http.get(url);
        }

        var clear_cheque = function(cheque){
            if(cheque.status === 'Pending'){
                var url = "/parent_cheques/"+cheque.id+".json"
                $http.put(url)
                    .then(function(responce){
                        cheque.status = "Cleared"
                    });
            }
        }
        
        
        return {
            getMonthyPdcView : getMonthyPdcView,
            saveMonthlyPdc : saveMonthlyPdc,
            get_pending_pdcs : get_pending_pdcs,
            get_cleared_pdcs : get_cleared_pdcs,
            get_submitted_pdcs : get_submitted_pdcs,
            search_pdcs : search_pdcs,
            clear_cheque : clear_cheque
        };
        
    }]);
})(angular, myApp);
