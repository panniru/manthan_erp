(function(angular, app) {
    "use strict";
    app.service("mailService",["$http", function($http) {
        var feeStructureMail = function(){
            var url = "/fee_alerts/fee_struct_mail_to_parents.json"
            return $http.get(url);
        };

        var termResultsMail = function(myMailSubject,myMailMessage){
            var url = "/term_results/term_results_mail_to_teachers.json"
            return $http.get(url,{params : {myMailSubject: myMailSubject, myMailMessage: myMailMessage}});
        };        
        
        return {
            feeStructureMail : feeStructureMail,
            termResultsMail : termResultsMail,
        };
        
    }]);
})(angular, myApp);
