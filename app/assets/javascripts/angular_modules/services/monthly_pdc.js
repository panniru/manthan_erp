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

        var next_month_date = function(current_date, increment_by=1){
            var month = current_date.getMonth(); // +1 bcz month count starts from 0
            var year = current_date.getFullYear();
            var date = current_date.getDate();
            
            if((month+increment_by) >= 12){
                return new Date(year+1, (increment_by+month)-12, date)
            }else{
                return new Date(year, (month+increment_by), date)
            }
        };
        
        
        return {
            getMonthyPdcView : getMonthyPdcView,
            saveMonthlyPdc : saveMonthlyPdc,
            get_pending_pdcs : get_pending_pdcs,
            get_cleared_pdcs : get_cleared_pdcs,
            get_submitted_pdcs : get_submitted_pdcs,
            search_pdcs : search_pdcs,
            clear_cheque : clear_cheque,
            next_month_date : next_month_date
        };
        
    }]);
})(angular, myApp);
