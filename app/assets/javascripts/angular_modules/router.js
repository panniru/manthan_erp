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
            . when('/assessments', {
                templateUrl: 'academics/assessments/show_form.html'               
            })
            . when('/show_form', {
                templateUrl: 'academics/assessments/show_form.html'               
            })
            . when('/edit_form', {
                templateUrl: 'academics/assessments/edit_form.html'               
            })
            . when('/add_form', {
                templateUrl: 'academics/assessments/edit_form.html'               
            })
            . when('/save_form', {
                templateUrl: 'academics/assessments/show_form.html'               
            })
            . when('/delete_id', {
                templateUrl: 'academics/assessments/show_form.html'               
            })
            . when('/mapping_index', {
                templateUrl: 'academics/assessments/mapping_index.html'               
            })
        
           
    }]);
})(angular, myApp);


