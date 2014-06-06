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

        var get_submitted_pdcs = function(payment_master_id){
            var url = "/parent_payment_masters/"+payment_master_id+"/submitted_pdcs.json"
            return $http.get(url);
        }

        var get_cleared_pdcs = function(payment_master_id){
            var url = "/parent_payment_masters/"+payment_master_id+"/cleared_pdcs.json"
            return $http.get(url);
        }
        
        return {
            getMonthyPdcView : getMonthyPdcView,
            saveMonthlyPdc : saveMonthlyPdc,
            get_submitted_pdcs : get_submitted_pdcs,
            get_cleared_pdcs : get_cleared_pdcs
            
        };
        
    }]);
})(angular, myApp);
