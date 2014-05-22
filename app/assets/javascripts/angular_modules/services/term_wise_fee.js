(function(angular, app) {
    "use strict";
    app.service("termWiseFeeService",["$http", function($http) {
        var getTermWiseFeeView = function(){
            var url = "/term_wise_grade_fees/term_wise_grade_fee.json"
            return $http.get(url);
        };

        var saveTermWiseFee = function(termWiseFees){
            var url = "/term_wise_grade_fees/save_term_wise_fee_grid.json"
            return $http.post(url, {params: termWiseFees});
        };
        
        return {
            getTermWiseFeeView : getTermWiseFeeView,
            saveTermWiseFee : saveTermWiseFee
        };
        
    }]);
})(angular, myApp);
