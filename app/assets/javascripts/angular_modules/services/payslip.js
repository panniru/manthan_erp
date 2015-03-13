(function(angular, app) {
    "use strict";
    app.service("payslipService",["$resource", function($resource) {
        var Payslip = $resource('payslips/:id', {faculty_master_id: '@faculty_master_id', id: '@id'},
				{
                                   "newPayslips": {url: "/payslips/new_payslips.json?designation_id=:designation_id", method: "GET", isArray: false},
                                   "payslips": {url: "/payslips.json", method: "GET", isArray: false},
                                   "savePayslips": {url: "/payslips/create_payslips.json", method: "POST"},
                                   "approvePayslips": {url: "/payslips/approve_payslips.json", method: "POST"},
                                   "emailPayslips": {url: "/payslips/email_payslips.json", method: "POST"}
                               }
                               );
        return {
            Payslip : Payslip
        };
    }]);
})(angular,  myApp);

