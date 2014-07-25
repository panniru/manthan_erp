(function(angular, app) {
    "use strict";
    app.config(["$routeProvider", "$locationProvider", function($routeProvider, $locationProvider) {
        $routeProvider
            .when('/annual_payment', {
                "templateUrl": 'annual_fee_payment.html'
            })
            .when('/term_wise_payment', {
                "templateUrl": 'term_fee_payment.html'
            })
            .when('/monthly_payment', {
                "templateUrl": 'month_fee_payment.html'
            })
       // $locationProvider.html5Mode(true);
           
    }]);
})(angular, myApp);


