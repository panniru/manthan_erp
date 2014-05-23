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
        
        return {
            getMonthyPdcView : getMonthyPdcView,
            saveMonthlyPdc : saveMonthlyPdc
        };
        
    }]);
})(angular, myApp);
