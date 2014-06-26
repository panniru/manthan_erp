(function(angular, app) {
    "use strict";
    app.service("mailService",["$http", function($http) {
        var feeStructureMail = function(){
            var url = "/fee_alerts/fee_struct_mail_to_parents.json"
            return $http.get(url);
        };
        
        return {
            feeStructureMail : feeStructureMail
        };
        
    }]);
})(angular, myApp);
