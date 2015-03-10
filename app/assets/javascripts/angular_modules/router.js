(function(angular, app) {
    "use strict";
    app.config(["$routeProvider", "$locationProvider", function($routeProvider, $locationProvider) {
        $routeProvider
            .when('/annual_payment', {
                controller: "AnnualFeePayamentsController", 
                templateUrl: 'annual_fee_payment.html'
            })
            .when('/term_wise_payment', {
                controller: "TermFeePayamentsController", 
                templateUrl: 'term_fee_payment.html'
            })
            .when('/monthly_payment', {
                controller: "MonthFeePayamentsController", 
                templateUrl: 'month_fee_payment.html'
            })
            .when('/trans_acknowledgement/:id', {
                controller: "TransAcknowledgementController", 
                templateUrl: 'trans_acknowledgement.html'
            })
       // $locationProvider.html5Mode(true);
            . when('/assessments', {
                templateUrl: 'academics/assessments/show_form.html'               
            })
            . when('assessments/show_form', {
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
            . when('/mapping_edit', {
                templateUrl: 'academics/assessments/mapping_edit.html',                
            })
            . when('/mapping_save', {
                templateUrl: 'academics/assessments/mapping_index.html', 
            })
            . when('/teacher_show', {
                templateUrl: 'academics/assessments/teacher_show.html'               
            })
            . when('/teacher_save_form', {
                templateUrl: 'academics/assessments/teacher_show.html'               
            })
            . when('/teacher_delete_id', {
                templateUrl: 'academics/assessments/teacher_show.html'              
            })
            . when('/teacher_edit_form', {
                templateUrl: 'academics/assessments/teacher_edit_form.html'               
            })
            . when('/show_assessments', {
                templateUrl: 'academics/assessments/show_assessments.html'               
            })
            . when('/add_assessment', {
                templateUrl: 'academics/assessments/add_assessment.html'               
            })
            . when('/assessment_results/show_form', {
                templateUrl: 'academics/assessment_results/show_form.html'               
            })
            . when('/class_show_form', {
                templateUrl: 'academics/assessment_results/class_show_form.html'               
            })
            . when('/assessment_results/add_form', {
                templateUrl: 'academics/assessment_results/add_form.html'               
            })  
             . when('/assessment_results/results_show_form', {
                templateUrl: 'academics/assessment_results/results_show_form.html'               
            }) 
             . when('/assessment_results/students_show_form', {
                templateUrl: 'academics/assessment_results/students_show_form.html'               
            })   
            . when('/save_assessment', {
                templateUrl: 'academics/assessments/show_assessments.html'               
            })      
           
    }]);
})(angular, myApp);


