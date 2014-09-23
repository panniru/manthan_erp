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

        var requestBooksMail = function(myMailSubject,myMailMessage,myRequestBooks){
            var url = "/request_books/request_books_mail_to_vendors.json"
            return $http.post(url, {myMailSubject: myMailSubject, myMailMessage: myMailMessage, myRequestBooks: myRequestBooks});
        };      
        
        return {
            feeStructureMail : feeStructureMail,
            termResultsMail : termResultsMail,
            requestBooksMail : requestBooksMail
        };
        
    }]);
})(angular, myApp);
