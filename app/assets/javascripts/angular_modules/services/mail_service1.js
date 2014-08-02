(function(angular, app) {
    "use strict";
    app.service("mailService1",["$http", function($http) {
        
        return {
            sendMail : sendMail
        };
        
    }]);
})(angular, myApp);
